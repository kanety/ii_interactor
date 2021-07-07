# frozen_string_literal: true

module IIInteractor
  module Loader
    class << self
      def call
        return unless defined?(Rails)
        return if Rails.env.production?

        engines = [Rails] + Rails::Engine.subclasses.map(&:instance)
        engines.each do |engine|
          Dir["#{engine.root}/app/interactors/**/*.rb"].each do |file|
            require file
          end
        end
      end
    end
  end
end
