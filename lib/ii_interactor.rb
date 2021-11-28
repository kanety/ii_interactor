require 'active_support'
require 'coactive'

require 'ii_interactor/version'
require 'ii_interactor/errors'
require 'ii_interactor/config'
require 'ii_interactor/base'
require 'ii_interactor/log_subscriber'

module IIInteractor
  class << self
    def configure
      yield Config
    end

    def config
      Config
    end
  end
end
