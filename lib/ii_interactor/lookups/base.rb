# frozen_string_literal: true

module IIInteractor
  module Lookups
    class Base
      def initialize(klass, interaction)
        @klass = klass
        @interaction = interaction
      end

      def call
      end

      class << self
        def call?(interaction)
        end
      end
    end
  end
end
