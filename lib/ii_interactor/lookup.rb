# frozen_string_literal: true

require_relative 'lookups/base'
require_relative 'lookups/name'
require_relative 'lookups/object'

module IIInteractor
  module Lookup
    extend ActiveSupport::Concern

    def lookup
      _interactions.map do |interaction|
        if interaction.is_a?(Symbol) && respond_to?(interaction, true)
          send(interaction)
        elsif interaction.is_a?(Proc)
          instance_exec(&interaction)
        else
          interaction
        end
      end.flatten.compact.map do |interaction|
        if interaction.is_a?(Class) && interaction < IIInteractor::Base
          interaction
        else
          self.class.lookup(self.class, interaction)
        end
      end.flatten.compact - [self.class]
    end

    class_methods do
      def lookup(klass, interaction)
        Lookup.call(klass, interaction)
      end
    end

    class << self
      class_attribute :lookups
      self.lookups = [Lookups::Name, Lookups::Object]

      class_attribute :_cache
      self._cache = {}

      def call(klass, interaction)
        cache(klass, interaction) do
          lookup = lookups.detect { |lookup| lookup.call?(interaction) }
          lookup.new(klass, interaction).call if lookup
        end
      end

      private

      def cache(klass, interaction)
        if Config.lookup_cache
          self._cache ||= {}
          self._cache[klass] ||= {}
          self._cache[klass][interaction] ||= yield
        else
          yield
        end
      end
    end
  end
end
