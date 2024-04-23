# frozen_string_literal: true

class RenderController < ApplicationController
  before_action :redirect_to_initiatives, if: :user_signed_in?


  def index
    @recent_initiatives = Initiative.order(created_at: :desc).limit(3)
  end

  private
  
    def redirect_to_initiatives
      redirect_to initiatives_path
    end
end
