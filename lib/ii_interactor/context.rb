# frozen_string_literal: true

module IIInteractor
  class Context < OpenStruct
    def initialize(hash, &block)
      super
      self[:_block] = block
      self[:_failed] = false
      self[:_stopped] = false
      self[:_planned] = []
      self[:_called] = []
    end

    def success?
      !failure?
    end

    def failure?
      self[:_failed] == true
    end

    def stopped?
      self[:_stopped] == true
    end

    def fail!(data = {})
      self[:_failed] = true
      data.each { |k, v| self[k] = v }
    end

    def stop!(data = {})
      self[:_stopped] = true
      data.each { |k, v| self[k] = v }
    end
  end
end
