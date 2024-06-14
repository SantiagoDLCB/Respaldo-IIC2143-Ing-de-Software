# Clase que maneja la lógica de las iniciativas.
class InitiativesController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user_is_admin?, only: [:destroy, :update]

  # Crea una nueva iniciativa
  # @return [Initiative] la iniciativa creada
  def new
    @initiative = Initiative.new
  end

  # Crea una nueva iniciativa y redirige a la vista de la iniciativa
  def create
    @initiative = Initiative.new(new_initiative_params)

    if @initiative.save
      current_user.add_role :admin_initiative, @initiative
      redirect_to initiative_path(@initiative.id) , notice: 'La iniciativa fue creada de manera exitosa.'
    else
      handle_initiative_creation_error
    end
  end

  # Retorna todas las iniciativas
  # @return [Initiative] todas las iniciativas
  def index
    @all_initiatives = Initiative.all
  end

  # Retorna una iniciativa determinada
  # @return [Initiative] la iniciativa
  def show
    @initiative = Initiative.find(params[:id])
    @message = Message.new
    @report = Report.new
    @current_user = current_user
    @events = @initiative.get_events
    @chat = @initiative.messages
    @messages = @initiative.messages
    @admins = @initiative.get_all_admins
    @members = @initiative.get_members
    @all_requests = @initiative.requests
    @active_requests = @initiative.requests.where(status: :pending)
    @old_requests = @initiative.requests.where(status: [:accepted, :denied])
    @old_events = Event.where(capacity: false).where(initiative: @initiative)
  end

  # Elimina una iniciativa y redirige a la vista principal
  def destroy
    @initiative = Initiative.find(params[:id])
    @initiative.destroy
    redirect_to root_path, notice: 'La iniciativa fue eliminada.'
  end

  # Actualiza una iniciativa y redirige a la vista de la iniciativa
  def update
    @initiative = Initiative.find(params[:id])
    @type =params[:initiative][:update_type]

    if @type == 'data'
      if @initiative.update(initiative_params)
        redirect_to initiative_path(@initiative) , notice: "La iniciativa fue actualizada exitosamente."
      else
        redirect_to initiative_path(@initiative) , alert: @initiative.errors.full_messages.join(', ')
      end
    else
      @user = User.find(params[:initiative][:user_id])
      if @type == 'add_admin'
        add_admin(@user, @initiative)
      elsif @type == 'remove_admin'
        @user.add_role :member, @initiative
        @user.remove_role :admin_initiative, @initiative
        if @user.has_role? :member, @initiative
          redirect_to initiative_path(@initiative), notice: 'El usuario ya no es administrador.'
        else
          render :edit
        end
      elsif @type == 'remove_member'
        @user.remove_role :member, @initiative
        @user.remove_role :admin_initiative, @initiative

        if !@user.has_role?(:member, @initiative) && !@user.has_role?(:admin_initiative, @initiative)
          redirect_to initiative_path(@initiative), notice: 'El usuario fue expulsado de la iniciativa.'
        else
          render :edit
        end
      else
        redirect_to initiative_path(@initiative), alert: 'No se pudo realizar la acción solicitada.'

      end
    end
  end

  # Busca usuario por email
  # @return [User] el usuario
  def search_users
    @users = User.where("email LIKE ?", "%#{params[:query]}%")
  end

  # Recarga la vista de chat
  def chat_reload
    @initiative = Initiative.find(params[:id])
    @chat = @initiative.messages
    render partial: 'chat', locals: { initiative: @initiative, chat: @chat }
  end

  # Acción para buscar fotos en la API de Unsplash
  def search_photos
    @initiative = Initiative.find(params[:id])
    if params[:query].present?
      @photos = Unsplash::Photo.search(params[:query], 1, 20)
    else
      @photos = []
    end
  end

  private
  # Agrega un usuario como administrador de una iniciativa y redirige a la vista de la iniciativa
  # @param user [User] el usuario
  # @param initiative [Initiative] la iniciativa
  def add_admin(user, initiative)
    # user = User.find(params[:initiative][:user_id])
    user.remove_role :member, initiative
    events = @initiative.events
    events.each do |event|
      user.remove_role :attendant, event
    end
    user.add_role :admin_initiative, initiative


    if @user.has_role? :admin_initiative, @initiative
      redirect_to initiative_path(@initiative), notice: 'El usuario ahora es administrador.'
    else
      render :edit
    end
  end

  # Retorna true si el usuario es administrador de la iniciativa, false en caso contrario
  def current_user_is_admin?()
    @initiative = Initiative.find(params[:id])
    check =current_user.has_role? :admin_initiative, @initiative
    if !check
      redirect_to root_path, alert: 'No tienes permisos para realizar esta acción.'
    end
  end

  # Retorna los parametros de la iniciativa
  def initiative_params
    params.require(:initiative).permit(:name, :topic, :description, :image)
  end

  # Retorna los parametros de la nueva iniciativa
  def new_initiative_params
    params.permit(:name, :topic, :description, :image)
  end

  # Maneja los errores de creacion de la iniciativa

  def handle_initiative_creation_error
    error1 = "No se ha podido crear la iniciativa, por favor revise que los datos esten bien ingresados."

      if @initiative.errors[:name].include?("has already been taken")
        error1 = "El nombre de la iniciativa ya existe. Por favor, elige un nombre diferente."
      end
      if @initiative.errors[:image].include?("Imagen debe ser menor a 10MB.")
        error1= "La imagen debe ser menor a 10MB."
      end
        redirect_to root_path, alert: error1
  end
end
