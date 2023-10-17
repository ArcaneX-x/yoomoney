# frozen_string_literal: true

module Providers
  module Yoomoney
    class Configurator
      attr_accessor :shop_id, :secret_key
      attr_reader :auth

      def initialize
        @shop_id = Rails.application.credentials.dig(:yookassa, :shop_id)
        @secret_key = Rails.application.credentials.dig(:yookassa, :api_key)
        set_auth
      end

      def set_auth
        @auth = "Basic #{Base64.strict_encode64("#{@shop_id}:#{@secret_key}")}"
      end
    end
  end
end
