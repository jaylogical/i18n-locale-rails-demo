# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LocaleDemo
  AVAILABLE_LOCALES = %w[en cs da de et fi fr it es lv nl pl pt ro ru sv tr].freeze

  USER_SELECTABLE_LOCALES = AVAILABLE_LOCALES

  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    config.i18n.load_path = Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s] + config.i18n.load_path
    config.i18n.default_locale = 'en'
    config.i18n.available_locales = LocaleDemo::AVAILABLE_LOCALES

    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
