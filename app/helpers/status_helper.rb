# frozen_string_literal: true

module StatusHelper
  def status_tag(status, text = nil)
    case status
    when 'active'
      content_tag(:span, text,
                  class: 'inline-flex items-center rounded-md bg-green-50 px-2 py-1 text-xs font-medium text-green-700 ring-1 ring-inset ring-green-600/20')
    when 'drafted'
      content_tag(:span, text || 'Drafted',
                  class: 'inline-flex items-center rounded-md bg-yello-50 px-2 py-1 text-xs font-medium text-yellow-700 ring-1 ring-inset ring-yellow-600/20')
    when 'trashed'
      content_tag(:span, text || 'Trashed',
                  class: 'inline-flex items-center rounded-md bg-red-50 px-2 py-1 text-xs font-medium text-red-700 ring-1 ring-inset ring-red-600/20')
    else
      content_tag(:span, text || status,
                  class: 'inline-flex items-center rounded-md bg-neutral-50 px-2 py-1 text-xs font-medium text-neutral-700 ring-1 ring-inset ring-neutral-600/20')
    end
  end
end
