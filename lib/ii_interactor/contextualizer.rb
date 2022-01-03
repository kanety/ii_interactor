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
        context(*names, **options)
      end

      def context_out(*names, **options)
        options[:output] = true
        if options.delete(:from_return)
          options[:output] = :return
        end
        context(*names, **options)
      end
    end
  end
end
