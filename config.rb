# frozen_string_literal: true

module Providers
  module Yoomoney
    class Config
      class << self
        def configure
          yield(base) if block_given?
          base.update_configuration
          base
        end

        def base
          @base ||= Providers::Yoomoney::Configurator.new
        end
      end
    end
  end
end
