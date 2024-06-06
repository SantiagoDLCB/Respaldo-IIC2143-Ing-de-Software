# Clase que controla las acciones de los roles de los usuarios en las iniciativas.
class UserRolesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_initiative
  before_action :find_user

  # Destruye un rol de un usuario en una iniciativa y redirige a la vista de la iniciativa
  def destroy
    @user.remove_role params[:role], @initiative
    redirect_to @initiative, notice: "El rol se ha eliminado correctamente."
  end


  private
  # Encuentra una iniciativa
  # @return [Initiative] la iniciativa
  def find_initiative
    @initiative = Initiative.find(params[:initiative_id])
  end

  # Encuentra un usuario
  # @return [User] el usuario
  def find_user
    @user = User.find(params[:id])
  end
end
