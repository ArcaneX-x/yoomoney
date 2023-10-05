# frozen_string_literal: true

module Providers
  module Yoomoney
    module Superhash
      refine Hash do
        def define_accessors
          each do |key, value|
            if value.is_a?(Hash)
              define_singleton_method(key) { value.define_accessors }
            else
              define_singleton_method(key) { value }
            end
          end
        end
      end
    end
  end
end
