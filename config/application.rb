require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JumpstartApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # supports :s3, :s3_multipart, or :app
    config.autoload_paths += %w[lib]
    config.upload_server = if ENV["UPLOAD_SERVER"].present?
      ENV["UPLOAD_SERVER"].to_sym
    elsif Rails.env.production?
      :s3
    else
      :app
    end

    config.exceptions_app = routes

    # Where the I18n library should search for translation files
    # Search nested folders in config/locales for better organization
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]

    # Permitted locales available for the application
    config.i18n.available_locales = [:en]

    # Set default locale
    config.i18n.default_locale = :en

    # Use default language as fallback if translation is missing
    config.i18n.fallbacks = true
  end
end
