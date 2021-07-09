# frozen_string_literal: true

module IIInteractor
  module Lookups
    class Name < Base
      def call
        IIInteractor.load
        IIInteractor::Base.descendants.select do |interactor|
          interactor._reactions.any? { |reaction| reaction == @interaction }
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
