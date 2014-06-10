module ApplicationHelper
  def form_for(resource, options={}, &block)
    options[:builder] ||= BootstrapFormBuilder
    super(resource, options, &block)
  end

  def form_wrapper(title=nil, options={}, &block)
    options[:size] ||= 'medium'

    columns, offset =
      case options[:size]
      when 'small'  then 4
      when 'medium' then 6
      when 'large'  then 8
      end

    render layout: 'shared/form_wrapper', locals: {title: title, columns: columns}, &block
  end

  def column(size, options={}, &block)
    options[:class] ||= ''
    options[:class] = [options[:class], "col-md-#{size}"]
    unless size == 12
      options[:class] << "col-md-offset-#{(12 - size)/2}"
    end
    options[:class] = options[:class].join(' ').strip
    content_tag(:div, options, &block)
  end
end
