require 'websocket-eventmachine-client'
require 'json'
require 'stockfighter/httpclient'

module Stockfighter
  class Client
    # base_uri "https://api.stockfighter.io/ob/api"
    # format :json
    #
    # def initialize(options={})
    #   self.class.headers options['headers'] if options['headers']
    # end
    #
    # Typhoeus.get("www.example.com")
    #
    # def heartbeat
    #   self.class.get('/heartbeat').parsed_response
    # end
    #
    # def venue_heartbeat(venue)
    #   self.class.get("/venues/#{venue}/heartbeat").parsed_response
    # end
    #
    # def stocks(venue)
    #   self.class.get("/venues/#{venue}/stocks").parsed_response
    # end
    #
    # def orderbook(venue, stock)
    #   self.class.get("/venues/#{venue}/stocks/#{stock}").parsed_response
    # end
    #
    # def quote(venue, stock)
    #   self.class.get("/venues/#{venue}/stocks/#{stock}/quote").parsed_response
    # end
    #
    # def new_order(venue, stock, order_details)
    #   self.class.post("/venues/#{venue}/stocks/#{stock}/orders", :body => JSON.dump(order_details)).parsed_response
    # end
    #
    # def order_status(venue, stock, order_id)
    #   self.class.get("/venues/#{venue}/stocks/#{stock}/orders/#{order_id}").parsed_response
    # end
    #
    # def orders_status(venue, account_id)
    #   self.class.get("/venues/#{venue}/accounts/#{account_id}/orders").parsed_response
    # end
    #
    # def orders_stock_status(venue, account_id, stock)
    #   self.class.get("/venues/#{venue}/accounts/#{account_id}/stocks/#{stock}/orders").parsed_response
    # end
    #
    # def cancel_order(venue, stock, order_id)
    #   self.class.delete("/venues/#{venue}/stocks/#{stock}/orders/#{order_id}").parsed_response
    # end
    #
    # def tickertape(account_id, venue_id, &callback)
    #   t = -> () {
    #     wsoptions = { :uri => "wss://api.stockfighter.io/ob/api/ws/#{account_id}/venues/#{venue_id}/tickertape" }
    #     ws = WebSocket::EventMachine::Client.connect(wsoptions)
    #
    #     ws.onmessage do |msg, type|
    #       #puts "Received message: #{msg}"
    #       callback.call JSON.parse(msg)
    #     end
    #     ws.onclose do |code, reason|
    #       puts "Disconnected with status code: #{code}"
    #       #callback.call "{code} #{reason}"
    #       #EM.stop
    #       ws.class.connect(wsoptions)
    #     end
    #   }
    #   if EM.reactor_running?
    #     t.call()
    #   else
    #     EM.run(&t)
    #   end
    # end
    #
    # def tickertape_stock(account_id, venue_id, stock, &callback)
    #   t = -> () {
    #     wsoptions = { :uri => "wss://api.stockfighter.io/ob/api/ws/#{account_id}/venues/#{venue_id}/tickertape/stocks/#{stock}" }
    #     ws = WebSocket::EventMachine::Client.connect(wsoptions)
    #
    #     ws.onmessage do |msg, type|
    #       #puts "Received message: #{msg}"
    #       callback.call JSON.parse(msg)
    #     end
    #     ws.onclose do |code, reason|
    #       puts "Disconnected with status code: #{code}"
    #       #EM.stop
    #       ws.class.connect(wsoptions)
    #     end
    #   }
    #   if EM.reactor_running?
    #     t.call()
    #   else
    #     EM.run(&t)
    #   end
    # end
    #
    # def executions(account_id, venue_id, &callback)
    #   t = -> () {
    #     wsoptions = { :uri => "wss://api.stockfighter.io/ob/api/ws/#{account_id}/venues/#{venue_id}/executions" }
    #     ws = WebSocket::EventMachine::Client.connect(wsoptions)
    #
    #     ws.onmessage do |msg, type|
    #       #puts "Received message: #{msg}"
    #       callback.call JSON.parse(msg)
    #     end
    #     ws.onclose do |code, reason|
    #       puts "Disconnected with status code: #{code}"
    #       #EM.stop
    #       ws.class.connect(wsoptions)
    #     end
    #   }
    #   if EM.reactor_running?
    #     t.call()
    #   else
    #     EM.run(&t)
    #   end
    # end
    #
    # def executions_stock(account_id, venue_id, stock, &callback)
    #   t = -> () {
    #     wsoptions = { :uri => "wss://api.stockfighter.io/ob/api/ws/#{account_id}/venues/#{venue_id}/executions/stocks/#{stock}" }
    #     ws = WebSocket::EventMachine::Client.connect(wsoptions)
    #
    #     ws.onmessage do |msg, type|
    #       #puts "Received message: #{msg}"
    #       callback.call JSON.parse(msg)
    #     end
    #     ws.onclose do |code, reason|
    #       puts "Disconnected with status code: #{code}"
    #       #EM.stop
    #       sleep 1
    #       ws.class.connect(wsoptions)
    #     end
    #   }
    #   if EM.reactor_running?
    #     t.call()
    #   else
    #     EM.run(&t)
    #   end
    # end
  end
end
