# frozen_string_literal: true

module IIInteractor
  module Contextualizer
    extend ActiveSupport::Concern
    include Coactive::Contextualizer

    def call_self
      contextualize do
        super
      end
    end

    class_methods do
      def context_in(*names, **options)
        warn "DEPRECATION WARNING: 'context_in' is deprecated. Use 'context :x' instead. (#{caller[0]})"
        context(*names, **options)
      end

      def context_out(*names, **options)
        options[:output] = true
        if options.delete(:from_return)
          options[:output] = :return
          warn "DEPRECATION WARNING: 'context_out' is deprecated. Use 'context :x, output: :return' instead. (#{caller[0]})"
        else
          warn "DEPRECATION WARNING: 'context_out' is deprecated. Use 'context :x, output: true' instead. (#{caller[0]})"
        end
        context(*names, **options)
      end
    end
  end
end
