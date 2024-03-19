source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 3.3.0'

gem 'rails'

# Deployment
gem 'puma', '~> 6.4'

# Assets
gem 'importmap-rails'
gem 'sprockets-rails'

# Hotwire
gem 'stimulus-rails'
gem 'turbo-rails', github: 'hotwired/turbo-rails'

# Drivers
gem 'redis'
gem 'sqlite3'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Sass to process CSS
# gem "sassc-rails"

# Media handling
gem 'image_processing', '~> 1.2'

# Other
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'acts_as_list', '~> 1.1'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', require: false
gem 'cancancan', '~> 3.5'
gem 'jbuilder'
gem 'kaminari'
gem 'letter_avatar'
gem 'litestack', '~> 0.4.2'
gem 'net-http-persistent'
gem 'prawn', '~> 2.5'
gem 'ransack'
gem 'requestjs-rails', '~> 0.0.11'
gem 'tailwindcss-rails', '~> 2.0.33'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'web-push'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  gem 'authentication-zero', '~> 3.0', group: :development

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # Code style tools
  gem 'erb_lint'
  gem 'foreman'
  gem 'htmlbeautifier'
  gem 'listen', '~> 3.3'

  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false

  gem 'faker', '>= 3.2.3'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
end
