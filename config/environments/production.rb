# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

# Uncomment the line below if you want to use the gateway in test mode while deployed in production
#ActiveMerchant::Billing::Base.gateway_mode = :test
ActionController::Base.asset_host = Proc.new {|source, request|
  if request.ssl?
    # don't send SSL requests to asset hosts, or we'll get a certificate warning
    "#{ request.protocol }#{ request.host_with_port }"
  else
    # route to assets0 through assets3
    "#{ request.protocol }assets#{ source.hash % 4 }.loveandtoast.com"
  end
}
