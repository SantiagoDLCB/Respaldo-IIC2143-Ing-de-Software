class InitiativesController < ApplicationController
  before_action :authenticate_user!
  def new
    @initiative = Initiative.new
  end

  def create
    @initiative = Initiative.new(initiative_params)
    if @initiative.save
      current_user.add_role :admin_initiative, @initiative
      redirect_to initiative_path(@initiative.id) , notice: 'La iniciativa fue creada de manera exitosa.'
    else
      error1 = "No se ha podido crear la iniciativa, por favor revise que los datos esten bien ingresados."
      if @initiative.errors[:name].include?("has already been taken")
        error1 = "El nombre de la iniciativa ya existe. Por favor, elige un nombre diferente."
        end
        redirect_to root_path, notice: error1
    end
  end

  def index
    @all_initiatives = Initiative.all
  end

  def show
    @initiative = Initiative.find(params[:id])
    @members = @initiative.get_members
    @events = @initiative.get_events
  end

  def destroy
    @initiative = Initiative.find(params[:id])
    @initiative.roles.destroy_all
    @initiative.requests.destroy_all
    @initiative.events.destroy_all
    @initiative.destroy
    redirect_to root_path, notice: 'La iniciativa fue eliminada.'
  end



    private

  def initiative_params
    params.require(:initiative).permit(:name, :topic, :description)
  end
  end
