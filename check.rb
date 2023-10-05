# frozen_string_literal: true
module Providers
  module Yoomoney
    class Check
      attr_reader :parsed_body

      def self.call(request_body)
        yoomoney_service = new(request_body)
        yoomoney_service.process_webhook
      end

      def initialize(request_body)
        @parsed_body = Oj.load(request_body)
      end

      def process_webhook
        payment_id = parsed_body['object']['metadata']['payment_id']
        key = parsed_body['object']['metadata']['key']
        status = parsed_body['event']
        payment = Payment.find(payment_id)

        return unless payment.present? && payment.key == key

        if status == 'payment.succeeded'
          payment.update(status: 'succeeded')
        elsif status == 'payment.canceled'
          payment.update(status: 'canceled')
        end
      end
    end
  end
end
