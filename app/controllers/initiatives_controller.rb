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
    @message = Message.new
    @report = Report.new
    @members = @initiative.get_members
    @events = @initiative.get_events
    @chat = @initiative.messages
  end

  def destroy
    @initiative = Initiative.find(params[:id])
    @initiative.destroy
    redirect_to root_path, notice: 'La iniciativa fue eliminada.'
  end

  def edit
    @initiative = Initiative.find(params[:id])
    @admins = @initiative.get_all_admins
    @members = @initiative.get_members
  end

  def update
    @initiative = Initiative.find(params[:id])
    @type =params[:initiative][:update_type]
    puts @type
    if @type == 'data'
      if @initiative.update(initiative_params)
        redirect_to initiative_path(@initiative), notice: 'La iniciativa fue actualizada exitosamente.'
      else
        render :edit
      end
    elsif @type == 'add_admin'
      @user = User.find(params[:initiative][:user_id])
      @user.add_role :admin_initiative, @initiative
      @user.remove_role :member, @initiative
      if @user.has_role? :admin_initiative, @initiative
        redirect_to initiative_path(@initiative), notice: 'El usuario ahora es administrador'
      else
        render :edit
      end
    elsif @type == 'remove_admin'
      @user = User.find(params[:initiative][:user_id])
      @user.add_role :member, @initiative
      @user.remove_role :admin_initiative, @initiative
      if @user.has_role? :member, @initiative
        redirect_to initiative_path(@initiative), notice: 'El usuario ya no es administrador'
      else
        render :edit
      end
    elsif @type == 'remove_member'
      @user = User.find(params[:initiative][:user_id])
      @user.remove_role :member, @initiative
      @user.remove_role :admin_initiative, @initiative
      @user.remove_role :admin_initiative, @initiative
      @event

      if !@user.has_role?(:member, @initiative) && !@user.has_role?(:admin_initiative, @initiative)
        redirect_to initiative_path(@initiative), notice: 'El usuario fue expulsado de la iniciativa'
      else
        render :edit
      end
    else
      redirect_to initiative_path(@initiative), alert: 'No se pudo realizar la acción solicitada.'

    end
  end

  def search_users
    @users = User.where("email LIKE ?", "%#{params[:query]}%")
  end


    private

    def initiative_params
      params.require(:initiative).permit(:name, :topic, :description)
    end
end
