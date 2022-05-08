# frozen_string_literal: true

module IIInteractor
  class Context < Coactive::Context
    class Status < Struct.new(:failed, :stopped, :called)
      def initialize(*)
        self.failed = false
        self.stopped = false
        self.called = []
      end
    end

    attr_reader :_status, :_block

    def initialize(data = {}, &block)
      if data.is_a?(IIInteractor::Context)
        @_block = data._block
        @_status = data._status
      else
        @_block = block
        @_status = Status.new
      end
      super
    end

    def to_s
      "#<#{self.class} #{self.class.inspect(@_data)} (#{self.class.inspect(@_status.to_h)})>"
    end

    def call_block!(*args)
      @_block.call(*args) if @_block
    end

    def success?
      !failure?
    end

    def failure?
      @_status.failed == true
    end

    def stopped?
      @_status.stopped == true
    end

    def fail!(data = {})
      @_status.failed = true
      data.each { |k, v| @_data[k] = v }
      define_accessors!(data.keys)
    end

    def stop!(data = {})
      @_status.stopped = true
      data.each { |k, v| @_data[k] = v }
      define_accessors!(data.keys)
    end

    def called!(interactor)
      @_status.called << interactor
    end
  end
end
