# frozen_string_literal: true

require_relative 'context'
require_relative 'callbacks'
require_relative 'interaction'
require_relative 'lookup'

module IIInteractor
  class Base
    include Callbacks
    include Interaction
    include Lookup

    attr_reader :context

    def initialize(context = {})
      @context = if context.is_a?(IIInteractor::Context)
          context
        else
          IIInteractor::Context.new(context)
        end
    end

    def call_all
      interactors = lookup.map { |interactor| interactor.new(@context) } + [self]
      called = []
      interactors.each do |interactor|
        interactor.call_self
        called << interactor
      end
    rescue UnprogressableError
      called.reverse.each do |interactor|
        interactor.rollback
      end
    end

    def call_self
      run_callbacks :call do
        call
      end
    end

    def call
    end

    def rollback
    end

    def fail!(message = nil)
      @context.failed = true
      @context.failed_message = message || "failed #{self.class}"
      raise UnprogressableError.new(@context)
    end

    class << self
      def call(context = {})
        interactor = new(context)
        interactor.call_all
        interactor.context
      end
    end
  end
end
