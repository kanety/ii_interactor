# frozen_string_literal: true

module IIInteractor
  module Instrumentation
    extend ActiveSupport::Concern

    def call_self
      ActiveSupport::Notifications.instrument 'call.ii_interactor', interactor: self do
        super
      end
    end
  end
end
