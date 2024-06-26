# frozen_string_literal: true

module IIInteractor
  class LogSubscriber < ActiveSupport::LogSubscriber
    def start_call_all(event)
      debug do
        interactor = event.payload[:interactor]
        "  Calling #{interactor.class} with #{interactor.context}"
      end
    end

    def process_call_self(event)
      debug do
        interactor = event.payload[:interactor]
        "  Called #{interactor.class} (#{additional_log(event)})"
      end
    end

    private

    def additional_log(event)
      additions = ["Duration: %.1fms" % event.duration]
      additions << "Allocations: %d" % event.allocations if event.respond_to?(:allocations)
      additions.join(', ')
    end
  end
end
