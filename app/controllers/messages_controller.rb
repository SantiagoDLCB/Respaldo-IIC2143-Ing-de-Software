# Clase que maneja la lógica de los mensajes de una iniciativa.
class MessagesController < ApplicationController
  before_action :authenticate_user!

  # Crea un nuevo mensaje
  # @return [Message] el mensaje creado
  def create
    @message = Message.new(message_params)
    @message.user = current_user
    @message.initiative = Initiative.find(params[:initiative_id])
    @message = @current_user.messages.create(content: message_params[:content], initiative_id: params[:initiative_id])
  end


  private
  # Parametros permitidos para la creación de un mensaje
  def message_params
    params.require(:message).permit(:content, :user_id, :initiative_id)
  end
end
