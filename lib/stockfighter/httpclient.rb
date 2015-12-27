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
        default_options[:headers] ||= {}
        default_options[:headers].merge!(headers)
      end

      def default_options
        @default_options ||= {}
      end

      def get(uri, options={})
        Typhoeus.get(@base_uri + uri, default_options.merge(options))
      end
    end
  end
end
