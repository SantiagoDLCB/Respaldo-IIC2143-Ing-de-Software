class MessagesController < ApplicationController
  before_action :authenticate_user!
  def create
    @message = Message.new(message_params)
    @message.user = current_user
    @message.initiative = Initiative.find(params[:initiative_id])
    @initiative = @message.initiative
    if @message.save
      # Create a new turbo_stream for the updated chat messages
      render turbo_stream: turbo_stream.replace(@message.initiative, partial: 'initiatives/chat',
locals: { initiative: @message.initiative, chat: @message.initiative.messages.order(created_at: :asc) })
    else
      # Render the errors if the message is not saved successfully
      render turbo_stream: turbo_stream.update('chat-body', partial: 'initiatives/chat', locals: { initiative: @message.initiative, chat: @message.initiative.messages.order(created_at: :asc) })
    end
  end


  private

  def message_params
    params.require(:message).permit(:content, :user_id, :initiative_id)
  end
end
