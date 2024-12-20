# frozen_string_literal: true

module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
    when :success
      'success'
    when :error
      'danger'
    when :alert
      'warning'
    when :notice
      'info'
    else
      flash_type.to_s
    end
  end

  def attr_or_dash(attr)
    attr.presence || '-'
  end
end
