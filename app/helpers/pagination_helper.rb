# frozen_string_literal: true

module PaginationHelper
  def pagiantion_bar(entries, views_prefix = 'shared/tailwind')
    tag.div class: 'flex items-center justify-between border-t border-gray-200 bg-white px-4 py-3 sm:px-6' do
      safe_join [
        page_entries_info(entries),
        paginate(entries, views_prefix:)
      ]
    end
  end
end
