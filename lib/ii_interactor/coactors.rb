# frozen_string_literal: true

module IIInteractor
  module Coactors
    extend ActiveSupport::Concern

    included do
      include Coactive::Base

      configure_coactive do |config|
        config.load_paths = ['app/interactors']
        config.class_suffix = 'Interactor'
        config.use_cache = true
        config.lookup_superclass_until = ['ActiveRecord::Base', 'ActiveModel::Base']
      end

      class << self
        alias_method :interact, :coact
        alias_method :react, :coaction
      end
    end
  end
end
