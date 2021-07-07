# frozen_string_literal: true

module IIInteractor
  module Interaction
    extend ActiveSupport::Concern

    included do
      class_attribute :_interactions
      self._interactions = []
    end

    class_methods do
      def interact(*interactors, **options, &block)
        if block
          self._interactions = _interactions + [block]
        elsif options[:before]
          index = self._interactions.index { |interaction| interaction == options[:before] }
          self._interactions = self._interactions.insert(index, *interactors)
        else
          self._interactions = _interactions + interactors
        end
      end

      def interactions
        self._interactions
      end

      def clear_interactions
        self._interactions = []
      end
    end
  end
end
