class UserRolesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_initiative
  before_action :find_user

  def destroy
    @user.remove_role params[:role], @initiative
    redirect_to @initiative, notice: "Role removed successfully"
  end

  private

  def find_initiative
    @initiative = Initiative.find(params[:initiative_id])
  end

  def find_user
    @user = User.find(params[:id])
  end
end
