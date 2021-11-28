# frozen_string_literal: true

require_relative 'context'
require_relative 'core'
require_relative 'variables'
require_relative 'callbacks'
require_relative 'instrumentation'
require_relative 'coactors'

module IIInteractor
  class Base
    include Core
    include Callbacks
    include Instrumentation
    include Variables
    include Coactors
  end
end
