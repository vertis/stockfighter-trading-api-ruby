module Stockfighter
  module HTTPClient
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def base_uri(uri)
        @base_uri = uri
      end

      def format(api_format)
        @api_format = api_format
      end

      def headers(headers)
        @headers ||= {}
        @headers.merge!(headers)
      end
    end
  end
end
