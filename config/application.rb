require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SpAssignment
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # TODO: ideally only appid and maybe locale would be here
    sp_params = {
      appid: 157,
      device_id: '2b6f0cc904d137be2e1730235f5664094b831186',
      locale: :de,
      ip: '109.235.143.113',
      offer_types: 112
    }
    config.sp_shared_params = sp_params
    config.sp_api_key = ENV["SP_API_KEY"]
    # TODO: store format in it's own config variable?
    config.sp_offers_api_endpoint = 'http://api.sponsorpay.com/feed/v1/offers.json'
  end
end
