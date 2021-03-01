# frozen_string_literal: true

# This controller is help to render home page
class HomeController < ApplicationController
  
  def getcities
    @cities = if params[:state_id].present?
                State.find_by(id:params[:state_id])&.cities || []
              end
    if request.xhr?
      respond_to do |format|
        format.json do
          render json: { cities: @cities }
        end
      end
    end
  end

  def getdepartments
    @departments = if params[:company_id].present?
                    Company.find_by(id:params[:company_id])&.departments || []
                  end
    if request.xhr?
      respond_to do |format|
        format.json do
          render json: { departments: @departments }
        end
      end
    end
  end

end