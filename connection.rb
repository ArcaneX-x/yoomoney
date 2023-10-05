# frozen_string_literal: true

module Providers
  module Yoomoney
    module Connection
      def connection(url, auth, uuid, payload)
        Faraday.post(url) do |req|
          req.headers['Content-Type'] = 'application/json'
          req.headers['Authorization'] = auth
          req.headers['Idempotence-Key'] = uuid
          req.body = Oj.dump(payload, mode: :compat)
        end
      end
    end
  end
end
