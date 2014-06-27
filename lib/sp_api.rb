require 'json'
require 'net/http'
require 'digest/sha1'

class SpApi

  class << self
    def fetch_offers uid, pub0, page
      params = { uid: uid, pub0: pub0, page: page, timestamp: Time.now.to_i }
      endpoint = Rails.application.config.sp_offers_api_endpoint
      uri = create_uri endpoint, params
      json = fetch_response uri
      # TODO: return whole json object here or just the offers array?
      json['offers']
    end

    protected

      def fetch_response uri
        http = Net::HTTP.new uri.host, uri.port
        # http.set_debug_output $stderr
        request = Net::HTTP::Get.new uri.request_uri
        request.add_field 'Accept', 'application/json'
        request.add_field 'Connection', 'Keep-Alive'
        request.add_field 'Accept-Encoding', 'gzip'
        response = http.request request
        # raise "Request failed[#{response.code}]: #{response.message}" if not response.kind_of? Net::HTTPSuccess
        raise "Request failed[#{response.code}]: #{response.message}" if not response.code.to_i === 200
        raise "Response signature verification failed" if not verify_response_signature(response)
        JSON.parse(response.body)
      end

      def verify_response_signature response
        received_signature = response['x-sponsorpay-response-signature']
        regenerated_signature = Digest::SHA1.hexdigest(response.body + api_key)
        received_signature == regenerated_signature
      end

      def create_uri endpoint, params
        params = shared_params.merge params
        hashkey = create_hashkey params
        params = params.merge hashkey: hashkey
        query_string = create_query_string params
        URI("#{endpoint}?#{query_string}")
      end

      def create_hashkey params
        q = create_query_string params.sort
        q += "&#{api_key}"
        Digest::SHA1.hexdigest q
      end

      def create_query_string hash
        URI.encode_www_form hash
      end

      def shared_params
        Rails.application.config.sp_shared_params
      end

      def api_key
        Rails.application.config.sp_api_key
      end
  end

end