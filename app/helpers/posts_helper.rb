# frozen_string_literal: true

module PostsHelper
  # return full url of the first presentable photo if not return hard coded image
  def cover_photo(files, size = [320, nil])
    if files.attached?
      url_for(files.first.variant(resize_to_limit: size))
    else
      'https://via.placeholder.com/720x480'
    end
  end
end
