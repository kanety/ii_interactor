# frozen_string_literal: true

module IIInteractor
  class Context < OpenStruct
    def failed?
      self[:failed] == true
    end
  end
end
