# frozen_string_literal: true

require 'rails/generators'

class IconGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def create_icon_partial
    template 'icon_template.html.erb', File.join('app/views/shared/icons', "_#{file_name}.html.erb")
  end

  def post_generation_message
    say 'Icon successfully created!', :green
    say "\nTo use your new icon, render the partial in your view with:"
    say "  <%= render 'shared/icons/#{file_name}' %>", :yellow
    say "\nYou can customize the icon's size, color, or add additional classes as needed.", :green
  end
end
