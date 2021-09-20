# frozen_string_literal: true

module IIInteractor
  class Variable < Struct.new(:name, :options)
    def default
      options[:default] if options
    end

    def required?
      options[:required] if options
    end

    def from_return?
      options[:from_return] if options
    end
  end

  module Variables
    extend ActiveSupport::Concern

    def initialize(*args, &block)
      super
      (self.class.context_ins + self.class.context_outs).each do |var|
        if var.required? && !@context.respond_to?(var.name)
          raise RequiredContextError.new("missing required context: #{var.name}")
        end
        if var.default && !@context.respond_to?(var.name)
          @context[var.name] = Variables.resolve(self, var.default)
        end
        instance_variable_set("@#{var.name}", @context[var.name])
      end
    end

    def call_self
      super.tap do |return_value|
        self.class.context_outs.each do |var|
          @context[var.name] = if var.from_return?
              return_value
            else
              instance_variable_get("@#{var.name}")
            end
        end
      end
    end

    class << self
      def resolve(interactor, value)
        if value.respond_to?(:call)
          interactor.instance_exec(&value)
        elsif value.is_a?(Symbol) && interactor.respond_to?(value, true)
          interactor.send(value)
        else
          value
        end
      end
    end

    included do
      class_attribute :context_ins, :context_outs
      self.context_ins = []
      self.context_outs = []
    end

    class_methods do
      def context_in(*names, **options)
        self.context_ins = self.context_ins + names.map { |name| Variable.new(name, options) }
      end

      def context_out(*names, **options)
        self.context_outs = self.context_outs + names.map { |name| Variable.new(name, options) }
      end
    end
  end
end
