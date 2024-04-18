class InitiativesController < ApplicationController
    def new
      @initiative = Initiative.new
    end

    def create
      @initiative = Initiative.new(initiative_params)
  
      if @initiative.save

        current_user.add_role :admin_initiative, @initiative
        redirect_to root_path, notice: 'Initiative was successfully created.'
      else
        p @initiative.errors.full_messages # Print validation errors to console for debugging
        render :new
      end
    end
    private

    def initiative_params
        params.require(:initiative).permit(:name, :topic, :description)
    end
  end