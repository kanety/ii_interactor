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

    def initialize(context = {}, &block)
      @context = if context.is_a?(IIInteractor::Context)
          context
        else
          IIInteractor::Context.new(context, &block)
        end
    end

    def call_all
      planned = lookup.map { |interactor| interactor.new(@context) } + [self]
      @context._planned += planned
      planned.each_with_index do |interactor, i|
        if i == planned.size - 1
          interactor.call_self
        else
          interactor.call_all
        end
        break if @context.stopped?
      end
    end

    def call_self
      run_callbacks :call do
        call
      end
      @context._called << self
    end

    def call
    end

    def rollback
    end

    def inform(*args)
      @context._block.call(*([self] + args)) if @context._block
    end

    def fail!(data = {})
      @context.fail!(data)
      raise UnprogressableError.new(@context)
    end

    def stop!(data = {})
      @context.stop!(data)
    end

    class << self
      def call(context = {}, &block)
        interactor = new(context, &block)
        interactor.call_all
        interactor.context
      rescue UnprogressableError
        interactor.context._called.reverse.each do |called|
          called.rollback
        end
        interactor.context
      end
    end
  end
end
