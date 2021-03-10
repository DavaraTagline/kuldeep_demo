module Superadmin
    class DepartmentsController < ApplicationController
        before_action :set_department, only: %i[show edit update destroy]

        def index
            @departments = Department.joins(:company).where(company: {slug: params[:company_id] } )
            @company = Company.find_by(slug: params[:company_id])
        end

        def show
        end
        
        def new 
            @department = Department.new
        end

        def create
            @department = Department.new(department_params)
            if @department.save
                redirect_to superadmin_users_path
            else
                render :new
            end
        end

        def edit; end

        def update
            if @department.update(department_params)
                redirect_to superadmin_users_path
            else
                render :edit
            end
        end
        
        def destroy
            @department.destroy
            redirect_to superadmin_users_path
        end

        private

        def department_params
            params.require(:department).permit(:name, :company_id)
        end

        def set_department
            @department = Department.find(params[:id])
        end
    end
end