class CompanyDecorator < Draper::Decorator
  delegate_all
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def delete_link
    # h is used for accessing the view helper_methods like link_to,url_paths etc.....
    h.link_to 'Destroy', h.superadmin_company_path(object), method: :delete, data: { confirm: 'Are you sure?'}, class:'btn btn-outline-danger btn-sm'
  end

  def edit_link
    h.link_to 'Edit', h.edit_superadmin_company_path(object), class:'btn btn-outline-secondary btn-sm'
  end

  def show_link
    h.link_to 'Show', h.superadmin_company_path(object), class:'btn btn-outline-primary btn-sm'
  end

  def add_department
    h.link_to 'Add department',h.new_superadmin_company_department_path(object), class:'btn btn-outline-info btn-sm', style: 'font-size:smaller'
  end
  
  def show_department
    h.link_to 'Show department',h.superadmin_company_departments_path(object), class:'btn btn-outline-dark btn-sm', style: 'font-size:smaller'
  end
  
end