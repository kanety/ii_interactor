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

    def call_all(&block)
      interactors = lookup.map { |interactor| interactor.new(@context) } + [self]
      called = []
      interactors.each do |interactor|
        interactor.call_self(&block)
        called << interactor
        break if @context.stopped?
      end
    rescue UnprogressableError
      called.reverse.each do |interactor|
        interactor.rollback
      end
    end

    def call_self(&block)
      call_block(block, :befoe)
      run_callbacks :call do
        call
      end
      call_block(block, :after)
    end

    def call_block(block, checkpoint)
      block.call(self, @context, checkpoint) if block
    end

    def call
    end

    def rollback
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
        interactor = new(context)
        interactor.call_all(&block)
        interactor.context
      end
    end
  end
end
