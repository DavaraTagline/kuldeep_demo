# frozen_string_literal: true

module Superadmin
  class CompaniesController < ApplicationController
    before_action :set_company, only: %i[show edit update]
    def index
      @companies = Company.all
    end

    def show; end

    def new
      @company = Company.new
      @company.addresses.build
    end

    def create
      @company = Company.new(company_params)
      if @company.save
        redirect_to superadmin_companies_path
      else
        render :new
      end
    end

    def edit; end

    def update
      if @company.update(company_params)
        redirect_to superadmin_companies_path
      else
        render :edit
      end
    end

    private

    def company_params
      params.require(:company).permit(:name, :email, :website,
                                      addresses_attributes: %i[id company_id address _destroy])
    end

    def set_company
      @company = Company.find(params[:id])
    end
  end
end
