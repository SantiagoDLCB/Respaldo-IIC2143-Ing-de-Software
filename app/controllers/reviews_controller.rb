class ReviewsController < ApplicationController
  before_action :authenticate_user!
  def index
    @event = Event.find(params[:event_id])
    @reviews = @event.reviews.order(created_at: :asc)
  end
  def create
    if get_user_event_review(params[:event_id]).nil?
      @review = Review.new(review_params)
      @review.user = current_user
      @review.event = Event.find(params[:event_id])

      if @review.save
        redirect_to event_path(@review.event), notice: 'Reseña creada exitosamente.'
      else
        redirect_to event_path(@review.event), alert: 'No se ha podido crear la reseña. Intente nuevamente.'
      end
    else
      redirect_to event_path(@review.event), alert: 'No puedes crear dos reseñas para un mismo evento.'
    end
  end

  private

  def review_params
    params.require(:review).permit(:calification, :content, :user_id, :event_id)
  end
  def get_user_event_review(event_id)
    @review = Review.find_by(user_id: current_user.id, event_id: event_id)
  end
end
