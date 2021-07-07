# frozen_string_literal: true

module IIInteractor
  module Callbacks
    extend ActiveSupport::Concern
    include ActiveSupport::Callbacks

    included do
      define_callbacks :call
    end

    class_methods do
      def before_call(*args, &block)
        set_callback(:call, :before, *args, &block)
      end

      def after_call(*args, &block)
        set_callback(:call, :after, *args, &block)
      end

      def around_call(*args, &block)
        set_callback(:call, :around, *args, &block)
      end
    end
  end
end
