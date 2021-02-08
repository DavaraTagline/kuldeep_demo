# frozen_string_literal: true

# This controller is help to render home page
class HomeController < ApplicationController
  def index
    @cities = if params[:state_id].present?
                State.find(params[:state_id]).cities
              else
                []
              end
    if request.xhr?
      respond_to do |format|
        format.json do
          render json: { cities: @cities }
        end
      end
    end
  end
end
