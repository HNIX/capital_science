source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> 2.7"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.0.0"
# Use postgresql as the database for Active Record
gem "pg"
# Use Puma as the app server
gem "puma", "~> 5.0"
# Use SCSS for stylesheets
gem "sass-rails", "~> 6.0"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker", github: "rails/webpacker"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.5"
# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false

# Security update
gem "nokogiri", ">= 1.10.8"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "pry-rails"
  gem "annotate"
  gem "brakeman"
  gem "bundler-audit", github: "rubysec/bundler-audit"
  gem "letter_opener_web", "~> 1.3", ">= 1.3.4"
  gem "standard"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.2", ">= 3.2.1"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Jumpstart dependencies
gem "jumpstart", path: "lib/jumpstart"

gem "acts_as_tenant", github: "ErwinM/acts_as_tenant"
gem "administrate", github: "excid3/administrate", branch: "jumpstart" # '~> 0.10.0'
gem "administrate-field-active_storage", "~> 0.3.0"
gem "attr_encrypted", "~> 3.1"
gem "devise", ">= 4.7.1"
gem "devise-i18n", "~> 1.9"
gem "devise_masquerade", github: "excid3/devise_masquerade"
gem "image_processing", "~> 1.9", ">= 1.9.2"
gem "inline_svg", "~> 1.6"
gem "invisible_captcha", "~> 1.0"
gem "local_time", "~> 2.1"
gem "name_of_person", "~> 1.0"
gem "noticed", "~> 1.2"
gem "oj", "~> 3.8", ">= 3.8.1"
gem "pagy", "~> 3.7"
gem "pay", "~> 2.2.0"
gem "pg_search", "~> 2.3"
gem "receipts", "~> 1.0.0"
gem "ruby-oembed", "~> 0.14.0", require: "oembed"
gem "turbolinks_render", "~> 0.9.12"
gem 'aasm'
gem "pundit"
gem "shrine", "~> 3.0"
gem "aws-sdk-s3", "~> 1.14" # for AWS S3 storage 
gem 'uppy-s3_multipart', '>= 0.3.2'
gem 'marcel'
gem 'fastimage'
gem 'wicked'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'geocoder'
gem 'selectize-rails'
gem 'ahoy_matey'

# We always want the latest versions of these gems, so no version numbers
gem "omniauth", github: "omniauth/omniauth"
gem "strong_migrations"
gem "whenever", require: false

# Jumpstart manages a few gems for us, so install them from the extra Gemfile
if File.exist?("config/jumpstart/Gemfile")
  eval_gemfile "config/jumpstart/Gemfile"
end
