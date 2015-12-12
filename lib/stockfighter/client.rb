require 'httparty'

module Stockfighter
  class Client
    include HTTParty

    base_uri "https://api.stockfighter.io/ob/api"

    def heartbeat
      self.class.get('/heartbeat').parsed_response
    end

    def venue_heartbeat(venue)
      self.class.get("/venues/#{venue}/heartbeat").parsed_response
    end

    def venue_stocks(venue)
      self.class.get("/venues/#{venue}/stocks").parsed_response
    end

    def venue_stock_orderbook(venue, stock)
      self.class.get("/venues/#{venue}/stocks/#{stock}").parsed_response
    end

    def venue_stock_new_order(venue, stock, order_details)
      self.class.post("/venues/#{venue}/stocks/#{stock}", :body => order_details).parsed_response
    end
  end
end
