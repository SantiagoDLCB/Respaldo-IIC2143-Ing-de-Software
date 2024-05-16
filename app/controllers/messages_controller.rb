class MessagesController < ApplicationController
  before_action :authenticate_user!
  def index
    @initiative = Initiative.find(params[:initiative_id])
    @all_messages = @initiative.messages
  end
  def create
    @message = Message.new(message_params)
    @message.user = current_user
    @message.initiative = Initiative.find(params[:initiative_id])

    if @message.save!
      redirect_to initiative_path(@message.initiative), notice: 'Mensaje enviado.'
    else
      render :new
    end
  end


  private

  def message_params
    params.require(:message).permit(:content, :user_id, :initiative_id)
  end
end
