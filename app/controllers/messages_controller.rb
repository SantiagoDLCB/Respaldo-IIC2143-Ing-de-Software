class MessagesController < ApplicationController
  before_action :authenticate_user!
  def index
    @initiative = Initiative.find(params[:initiative_id])
    @messages = @initiative.messages.order(created_at: :asc)
  end
  def create
    @message = Message.new(message_params)
    @message.user = current_user
    @message.initiative = Initiative.find(params[:initiative_id])
    if @message.save!
      render json: { message: "Message saved successfully" }
    end
  end

  def get_messages
    @initiative = Initiative.find(params[:id])
    @messages = @initiative.messages.order(created_at: :asc)
    render partial: 'messages', locals: { messages: @messages }, formats: :html
  end


  private

  def message_params
    params.require(:message).permit(:content, :user_id, :initiative_id)
  end
end
