# frozen_string_literal: true

module Providers
  module Yoomoney
    class Client
      using Providers::Yoomoney::Superhash
      attr_reader :return_url, :course_title, :payment_id, :price, :course_id, :yookassa

      def self.call(obj)
        yoo_object = new(obj)
        yoo_object.create_payment
      end

      def initialize(obj)
        @course_title = obj.payment.title
        @return_url = obj.return_url
        @payment_id = obj.payment.id
        @price = obj.price
        @course_id = obj.payment.payable_id
      end

      def create_payment
        @yookassa = Providers::Yoomoney::Request.post(payload)
        @yookassa.define_accessors
      end

      def method_missing(method_name)
        if yookassa.respond_to?(method_name)
          yookassa.send(method_name)
        else
          super
        end
      end

      def respond_to_missing?(method_name, include_private = false)
        yookassa.respond_to?(method_name, include_private) || super
      end

      private

      def payload
        {
          amount: {
            value: price,
            currency: 'RUB'
          },
          capture: true,
          title: course_title,
          metadata: {
            object_id: course_id,
            payment_id:,
            key: SecureRandom.hex(16)
          },
          confirmation: {
            type: 'redirect',
            return_url:
          }
        }
      end
    end
  end
end
