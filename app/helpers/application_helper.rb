# frozen_string_literal: true

# This helper used to display bootstrap messages
module ApplicationHelper
  def boostrap_class(alert)
    { success: 'alert-success', error: 'alert-danger', notice: 'alert-success', warning: 'alert-warning',
      danger: 'alert-danger', alert: 'alert-danger' }[alert.to_sym]
  end

  def flash_messages(_opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{boostrap_class(msg_type.to_sym)} fade in") do
        concat(content_tag(:button, id: 'close-button', class: 'close', type: :button, data: { dismiss: 'alert' },
                                    'aria-label' => :Close) do
                 concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
               end)
        concat message
      end)
    end
    nil
  end

  def link_to_add_new(name, f, association, **args)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize, f: builder)
    end
    link_to(name, '#', class: (args[:class]).to_s, data: { id: id, fields: fields.gsub("\n", '') })
  end
end
