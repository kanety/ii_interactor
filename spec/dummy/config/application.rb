require_relative 'boot'

require 'action_controller/railtie'
require 'active_model/railtie'

Bundler.require(*Rails.groups)
require "ii_interactor"

module Dummy
  class Application < Rails::Application
    config.after_initialize do
      IIInteractor::LogSubscriber.attach_to(:ii_interactor)
    end
  end
end
