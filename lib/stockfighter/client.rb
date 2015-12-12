require 'httparty'

module Stockfighter
  class Client
    include HTTParty

    base_uri "https://api.stockfighter.io/ob/api"

    def initialize(options={})
      self.class.headers options['headers'] if options['headers']
    end

    def heartbeat
      self.class.get('/heartbeat').parsed_response
    end

    def venue_heartbeat(venue)
      self.class.get("/venues/#{venue}/heartbeat").parsed_response
    end

    def stocks(venue)
      self.class.get("/venues/#{venue}/stocks").parsed_response
    end

    def orderbook(venue, stock)
      self.class.get("/venues/#{venue}/stocks/#{stock}").parsed_response
    end

    def quote(venue, stock)
      self.class.get("/venues/#{venue}/stocks/#{stock}/quote").parsed_response
    end

    def new_order(venue, stock, order_details)
      self.class.post("/venues/#{venue}/stocks/#{stock}", :body => order_details).parsed_response
    end

    def order_status(venue, stock, order_id)
      self.class.get("/venues/#{venue}/stocks/#{stock}/orders/#{order_id}").parsed_response
    end

    def cancel_order(venue, stock, order_id)
      self.class.delete("/venues/#{venue}/stocks/#{stock}/orders/#{order_id}").parsed_response
    end
  end
end
