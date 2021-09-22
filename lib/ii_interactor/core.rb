# frozen_string_literal: true

module IIInteractor
  module Core
    extend ActiveSupport::Concern

    included do
      attr_reader :context
    end

    def initialize(context = {}, &block)
      @context = if context.is_a?(IIInteractor::Context)
          context
        else
          IIInteractor::Context.new(context, &block)
        end
    end

    def call_all
      planned = lookup.map { |interactor| interactor.new(@context) } + [self]
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
      call.tap do
        @context._called << self
      end
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

    class_methods do
      def call(*args, &block)
        interactor = new(*args, &block)
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