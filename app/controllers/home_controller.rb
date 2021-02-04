# frozen_string_literal: true

# This controller is help to render home page
class HomeController < ApplicationController
  def index 
    if params[:state].present?
      @cities = State.find(params[:state]).cities
    else
      @cities = []
    end
    if request.xhr?
      respond_to do |format|
        format.json {
          render json: {cities: @cities}
        }
      end
    end
  end
end
