module Stockfighter
  module GM
    class Client
      include HTTParty
      
      base_uri "https://api.stockfighter.io/gm"

      def initialize(options={})
        self.class.headers options['headers'] if options['headers']
      end

      def start_level(name)
        self.class.post("/levels/#{name}").parsed_response
      end
    end
  end
end
