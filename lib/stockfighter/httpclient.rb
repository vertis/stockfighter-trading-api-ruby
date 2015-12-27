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
    end
  end
end
