# frozen_string_literal: true

module IIInteractor
  module Core
    extend ActiveSupport::Concern
    include Coactive::Initializer

    included do
      self.context_class = IIInteractor::Context
    end

    def initialize(*)
      super
    end

    def call_all
      planned = case IIInteractor.config.traversal
        when :preorder
          [self] + coactors
        when :postorder
          coactors + [self]
        when :inorder
          planned = coactors.in_groups(2, false)
          planned[0] + [self] + planned[1]
        end

      planned.each do |interactor|
        if interactor == self
          call_self
        else
          interactor.new(@context).call_all
        end
        break if @context.stopped?
      end
    end

    def call_self
      call.tap do
        @context.called!(self)
      end
    end

    def call
    end

    def rollback
    end

    def inform(*args)
      @context.call_block!(*([self] + args))
    end

    def fail!(data = {})
      @context.fail!(data)
      raise UnprogressableError.new(@context)
    end

    def stop!(data = {})
      @context.stop!(data)
    end

    class_methods do
      def call(args = {}, &block)
        interactor = new(args, &block)
        interactor.call_all
        interactor.context
      rescue UnprogressableError
        interactor.context[:_called].reverse.each do |called|
          called.rollback
        end
        interactor.context
      end
    end
  end
end
