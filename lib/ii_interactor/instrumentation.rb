# frozen_string_literal: true

module IIInteractor
  module Instrumentation
    extend ActiveSupport::Concern

    def call_all
      ActiveSupport::Notifications.instrument 'start_call_all.ii_interactor', interactor: self
      super
    end

    def call_self
      ActiveSupport::Notifications.instrument 'process_call_self.ii_interactor', interactor: self do
        super
      end
    end
  end
end
