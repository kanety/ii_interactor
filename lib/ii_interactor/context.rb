# frozen_string_literal: true

module IIInteractor
  class Context < Coactive::Context
    def initialize(data = {}, &block)
      super
      @_data[:_block] ||= block
      @_data[:_failed] ||= false
      @_data[:_stopped] ||= false
      @_data[:_called] ||= []
    end

    def to_s
      "#<#{self.class} #{self.class.inspect(@_data)}>"
    end

    def call_block!(*args)
      @_data[:_block].call(*args) if @_data[:_block]
    end

    def success?
      !failure?
    end

    def failure?
      @_data[:_failed] == true
    end

    def stopped?
      @_data[:_stopped] == true
    end

    def fail!(data = {})
      @_data[:_failed] = true
      data.each { |k, v| @_data[k] = v }
      define_accessors!(data.keys)
    end

    def stop!(data = {})
      @_data[:_stopped] = true
      data.each { |k, v| @_data[k] = v }
      define_accessors!(data.keys)
    end

    def called!(interactor)
      @_data[:_called] << interactor
    end
  end
end
