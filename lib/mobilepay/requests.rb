require 'net/http'

module Mobilepay
    module Requests

        private

        def http_request(req, address, args = {})
            uri = generate_uri(address)
            req = generate_request(req, uri)
            req = generate_headers(req, args[:body])
            Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
        end

        def generate_uri(address = '')
            URI("#{base_uri}#{address}")
        end

        def generate_request(req, uri)
            case req
                when :get then Net::HTTP::Get.new(uri)
                when :put then Net::HTTP::Put.new(uri)
                when :delete then Net::HTTP::Delete.new(uri)
            end
        end

        def generate_headers(req, body)
            req.body = body
            req['Content-Type'] = 'application/json'
            req['Ocp-Apim-Subscription-Key'] = subscription_key
            req['Test-mode'] = test_mode if test_mode == true
            req['AuthenticationSignature'] = generate_signature(req)
            req
        end

    end
end