class NoticesController < ApplicationController
    before_action :authenticate_user!
    def index
      @event = Event.find(params[:event_id])
      @notice = @event.notice.order(created_at: :asc)
    end
    def create
      @notice = Notice.new(notice_params)
      @notice.event = Event.find(params[:event_id])
  
      if @notice.save!
        redirect_to event_path(@notice.event), notice: 'Anuncio creado exitosamente.'
      else
        render :new
      end
    end
  
    private
  
    def notice_params
      params.permit(:title,:content, :event_id)
    end
  end
  