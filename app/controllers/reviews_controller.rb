class ReviewsController < ApplicationController
  before_action :authenticate_user!
  def index
    @event = Event.find(params[:event_id])
    @reviews = @event.reviews.order(created_at: :asc)
  end
  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.event = Event.find(params[:event_id])

    if @review.save!
      redirect_to event_path(@review.event), notice: 'Reseña creada exitosamente.'
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:calification, :content, :user_id, :event_id)
  end
end
