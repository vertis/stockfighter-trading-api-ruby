require 'websocket-eventmachine-client'
require 'json'
require 'faraday'
require 'faraday_middleware'
require 'typhoeus/adapters/faraday'

module Stockfighter
  class Client
    def initialize(options={})
      #self.class.headers options['headers'] if options['headers']
      @connection = Faraday.new 'https://api.stockfighter.io/ob/api' do |conn|
        conn.request :json

        if options['headers']
          conn.headers.merge!(options['headers'])
        end

        #conn.response :xml,  :content_type => /\bxml$/
        conn.response :json #, :content_type => /\bjson$/

        conn.adapter :typhoeus
      end
    end

    def heartbeat
      @connection.get('heartbeat').body
    end

    def venue_heartbeat(venue)
      @connection.get("venues/#{venue}/heartbeat").body
    end

    def stocks(venue)
      @connection.get("venues/#{venue}/stocks").body
    end

    def orderbook(venue, stock)
      @connection.get("venues/#{venue}/stocks/#{stock}").body
    end

    def quote(venue, stock)
      @connection.get("venues/#{venue}/stocks/#{stock}/quote").body
    end

    def new_order(venue, stock, order_details)
      @connection.post("venues/#{venue}/stocks/#{stock}/orders", order_details).body
    end

    def order_status(venue, stock, order_id)
      @connection.get("venues/#{venue}/stocks/#{stock}/orders/#{order_id}").body
    end

    def orders_status(venue, account_id)
      @connection.get("venues/#{venue}/accounts/#{account_id}/orders").body
    end

    def orders_stock_status(venue, account_id, stock)
      @connection.get("venues/#{venue}/accounts/#{account_id}/stocks/#{stock}/orders").body
    end

    def cancel_order(venue, stock, order_id)
      @connection.delete("venues/#{venue}/stocks/#{stock}/orders/#{order_id}").body
    end

    def tickertape(account_id, venue_id, &callback)
      t = -> () {
        wsoptions = { :uri => "wss://api.stockfighter.io/ob/api/ws/#{account_id}/venues/#{venue_id}/tickertape" }
        ws = WebSocket::EventMachine::Client.connect(wsoptions)

        ws.onmessage do |msg, type|
          #puts "Received message: #{msg}"
          callback.call JSON.parse(msg)
        end
        ws.onclose do |code, reason|
          puts "Disconnected with status code: #{code}" if ENV['WEBSOCKET_DEBUG']
          #callback.call "{code} #{reason}"
          #EM.stop
          ws.class.connect(wsoptions)
        end
      }
      if EM.reactor_running?
        t.call()
      else
        EM.run(&t)
      end
    end

    def tickertape_stock(account_id, venue_id, stock, &callback)
      t = -> () {
        wsoptions = { :uri => "wss://api.stockfighter.io/ob/api/ws/#{account_id}/venues/#{venue_id}/tickertape/stocks/#{stock}" }
        ws = WebSocket::EventMachine::Client.connect(wsoptions)

        ws.onmessage do |msg, type|
          #puts "Received message: #{msg}"
          callback.call JSON.parse(msg)
        end
        ws.onclose do |code, reason|
          puts "Disconnected with status code: #{code}" if ENV['WEBSOCKET_DEBUG']
          #EM.stop
          ws.class.connect(wsoptions)
        end
      }
      if EM.reactor_running?
        t.call()
      else
        EM.run(&t)
      end
    end

    def executions(account_id, venue_id, &callback)
      t = -> () {
        wsoptions = { :uri => "wss://api.stockfighter.io/ob/api/ws/#{account_id}/venues/#{venue_id}/executions" }
        ws = WebSocket::EventMachine::Client.connect(wsoptions)

        ws.onmessage do |msg, type|
          #puts "Received message: #{msg}"
          callback.call JSON.parse(msg)
        end
        ws.onclose do |code, reason|
          puts "Disconnected with status code: #{code}" if ENV['WEBSOCKET_DEBUG']
          #EM.stop
          ws.class.connect(wsoptions)
        end
      }
      if EM.reactor_running?
        t.call()
      else
        EM.run(&t)
      end
    end

    def executions_stock(account_id, venue_id, stock, &callback)
      t = -> () {
        wsoptions = { :uri => "wss://api.stockfighter.io/ob/api/ws/#{account_id}/venues/#{venue_id}/executions/stocks/#{stock}" }
        ws = WebSocket::EventMachine::Client.connect(wsoptions)

        ws.onmessage do |msg, type|
          #puts "Received message: #{msg}"
          callback.call JSON.parse(msg)
        end
        ws.onclose do |code, reason|
          puts "Disconnected with status code: #{code}" if ENV['WEBSOCKET_DEBUG']
          #EM.stop
          sleep 1
          ws.class.connect(wsoptions)
        end
      }
      if EM.reactor_running?
        t.call()
      else
        EM.run(&t)
      end
    end
  end
end
