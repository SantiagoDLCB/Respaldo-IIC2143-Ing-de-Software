class MessagesController < ApplicationController
  before_action :authenticate_user!
  def create
    @message = Message.new(message_params)
    @message.user = current_user
    @message.initiative = Initiative.find(params[:initiative_id])
    @message = @current_user.messages.create(content: message_params[:content], initiative_id: params[:initiative_id])
  end


  private

  def message_params
    params.require(:message).permit(:content, :user_id, :initiative_id)
  end
end
