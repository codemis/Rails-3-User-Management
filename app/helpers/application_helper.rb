module ApplicationHelper
  
  def form_error_messages(f)
    if f.object.errors.present?
      render :partial => "application/form_error_messages", :locals => {:f => f}
    end
  end
  
  def stripe
    return cycle("odd", "even")
  end
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc';
    link_to title, {:sort => column, :direction => direction, :search => params[:search]}, {:class => css_class}
  end
  
  alias :f_error_messages :form_error_messages
end
