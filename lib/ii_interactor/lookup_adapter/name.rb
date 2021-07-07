# frozen_string_literal: true

module IIInteractor
  module LookupAdapter
    class Name < Base
      def call
        IIInteractor.load
        IIInteractor::Base.descendants.select do |interactor|
          interactor._interactions.any? { |interaction| interaction == @interaction }
        end
      end

      class << self
        def call?(interaction)
          interaction.is_a?(Symbol)
        end
      end
    end
  end
end
