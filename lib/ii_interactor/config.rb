# frozen_string_literal: true

module IIInteractor
  class Config
    class_attribute :data

    self.data = {
      lookup_cache: true
    }

    data.keys.each do |key|
      define_singleton_method "#{key}" do
        data[key]
      end

      define_singleton_method "#{key}=" do |val|
        data[key] = val
      end
    end
  end
end
