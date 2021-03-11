class DepartmentDecorator < Draper::Decorator
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
    h.link_to 'Destroy', h.superadmin_company_department_path(id:object), method: :delete, data: { confirm: 'Are you sure?'}, class:'btn btn-outline-danger btn-sm'
  end

  def edit_link
    h.link_to 'Edit', h.edit_superadmin_company_department_path(id:object), class:'btn btn-outline-secondary btn-sm'
  end

  def show_link
    h.link_to 'Show', h.superadmin_company_department_path(id:object), class:'btn btn-outline-primary btn-sm'
  end
  
end