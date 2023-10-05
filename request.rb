# frozen_string_literal: true

module Providers
  module Yoomoney
    class Request
      include Providers::Yoomoney::Connection
      attr_reader :auth, :uuid, :payload

      URL = 'https://api.yookassa.ru/v3/payments'

      def self.post(payload)
        obj = new(payload)
        obj.post
      end

      # For test mode you can provide a block inside initialize or specs
      # Providers::Yoomoney::Config.configure do |config|
      #   config.shop_id = '77777'
      #   config.secret_key = 'test_Abc'
      # end

      def initialize(payload) 
        @auth = Providers::Yoomoney::Config.base.auth
        @uuid = SecureRandom.uuid
        @payload = payload
      end

      def post
        respond_with(
          connection(URL, auth, uuid, payload)
        )
      end

      private

      def respond_with(response)
        Oj.load response.body
      end
    end
  end
end
