class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  def datetime_picker(field, options={})
    @template.render partial: 'shared/datetime_picker', locals: {f: self, field: field}
  end
end
