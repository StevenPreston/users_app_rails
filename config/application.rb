require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UsersApp
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('lib')
    config.browserify_rails.commandline_options = "-t [ babelify --presets [ es2015 react ] ] -t [ reactify ] --extension='.js.es6' --extension='.js.jsx'"
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
