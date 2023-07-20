# frozen_string_literal: true

module IIInteractor
  class LogSubscriber < ActiveSupport::LogSubscriber
    def calling(event)
      debug do
        interactor = event.payload[:interactor]
        "  Calling #{interactor.class} with #{interactor.context}"
      end
    end

    def call(event)
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
