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

  def icon(key, options={})
    name = case key
           when 'edit'   then 'pencil'
           when 'delete' then 'remove'
           when 'scout'  then 'eye-open'
           when 'raid'   then 'tower'
           end
    if !options[:title] && I18n.exists?("icon_title.#{key}")
      options[:title] = I18n.t("icon_title.#{key}")
    end
    options[:title] ||= key.humanize

    render partial: 'shared/icon', locals: {name: name, key: key, title: options[:title]}
  end

  def time_ago(time)
    seconds_ago = Time.now.to_i - time.to_i

    if seconds_ago < 1.hour
      pluralize(seconds_ago / 1.minute, 'minute')
    elsif seconds_ago < 1.day
      pluralize(seconds_ago / 1.hour, 'hour')
    else
      days_ago = seconds_ago / 1.day
      hours_ago = seconds_ago % 1.day / 1.hour
      "#{pluralize(days_ago, 'day')} #{pluralize(hours_ago, 'hour')}"
    end
  end
end
