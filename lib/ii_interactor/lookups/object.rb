# frozen_string_literal: true

module IIInteractor
  module Lookups
    class Object < Base
      def call
        return if terminate?

        if @interaction.name.present? && (interactor = resolve)
          interactor
        elsif @interaction.superclass
          self.class.new(@klass, @interaction.superclass).call
        end
      end

      private

      def terminate?
        @interaction.name.to_s.in?(['Object', 'ActiveRecord::Base', 'ActiveModel::Base'])
      end

      def resolve
        name = resolve_name
        interactor = name.safe_constantize
        return interactor if interactor && name == interactor.name
      end

      def resolve_name
        namespace = @klass.name.to_s.sub(/Interactor$/, '').to_s
        [namespace, "#{@interaction.name}Interactor"].join('::')
      end

      class << self
        def call?(interaction)
          interaction.is_a?(Module)
        end
      end
    end
  end
end
