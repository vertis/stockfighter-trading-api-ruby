require 'httparty'

module Stockfighter
  class Client
    include HTTParty

    base_uri "https://api.stockfighter.io/ob/api"

    def heartbeat
      self.class.get('/heartbeat').parsed_response
    end
  end
end
