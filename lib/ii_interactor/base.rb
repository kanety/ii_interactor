# frozen_string_literal: true

require_relative 'core'
require_relative 'callbacks'
require_relative 'instrumentation'
require_relative 'context'
require_relative 'contextualizer'
require_relative 'coactors'

module IIInteractor
  class Base
    include Core
    include Callbacks
    include Instrumentation
    include Contextualizer
    include Coactors
  end
end
