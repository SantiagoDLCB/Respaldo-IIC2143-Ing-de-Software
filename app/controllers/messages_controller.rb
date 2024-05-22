class MessagesController < ApplicationController
  before_action :authenticate_user!
  def create
    @current_user = current_user
    Rails.logger.info(request.env['warden'].inspect)

    @message = @current_user.messages.create(content: msg_params[:content], initiative_id: params[:initiative_id])
  end
  def index
    @current_user = current_user
  end

  private

  def msg_params
    params.require(:message).permit(:content)
  end
end
