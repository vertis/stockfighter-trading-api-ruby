require 'spec_helper'

describe Stockfighter::Client do
  describe '#heartbeat' do
    it 'get the status of the API' do
      VCR.use_cassette("heartbeat") do
        expect(subject.heartbeat).to eq({'ok' => true, 'error' => ''})
      end
    end
  end

  describe '#venue_heartbeat' do
    it 'should get the status of the venue' do
      VCR.use_cassette("venue_heartbeat") do
        expect(subject.venue_heartbeat('TESTEX')).to eq({'ok' => true, 'venue' => 'TESTEX'})
      end
    end
  end

  describe '#venue_stocks' do
    it 'should get the stocks available on the venue' do
      VCR.use_cassette("venue_stocks") do
        expect(subject.venue_stocks('TESTEX')).to eq({ 'ok' => true, 'symbols' => [{'name'=>'Foreign Owned Occluded Bridge Architecture Resources', 'symbol'=>'FOOBAR'}] })
      end
    end
  end

  describe '#venue_stock_orderbook' do
    it 'should get the orderbook for the given stock on the given venue' do
      VCR.use_cassette("venue_stock_orderbook") do
        res = subject.venue_stock_orderbook('TESTEX', 'FOOBAR')
        expect(res['ok']).to eq(true)
        expect(res.keys).to eq(["ok", "venue", "symbol", "ts", "bids", "asks"])
      end
    end
  end

  describe '#venue_stock_quote' do
    it 'should get the quote for the given stock on the given venue' do
      VCR.use_cassette("venue_stock_quote") do
        res = subject.venue_stock_quote('TESTEX', 'FOOBAR')
        expect(res['ok']).to eq(true)
        expect(res.keys).to eq(["ok", "symbol", "venue", "bid", "bidSize", "askSize", "bidDepth", "askDepth", "last", "lastSize", "lastTrade", "quoteTime"])
      end
    end
  end

  describe '#venue_stock_new_order' do
    context 'without authorization header' do
      it 'should fail to create an order' do
        VCR.use_cassette("venue_stock_new_order_without_auth") do
          order_details = {
            "account" => "EXB123456",
            "venue" => "TESTEX",
            "stock" => "FOOBAR",
            "qty" => 100,
            "direction" => "buy",
            "orderType" => "market"
          }
          res = subject.venue_stock_new_order('TESTEX', 'FOOBAR', order_details)
          expect(res).to eq({"ok"=>false, "error"=>"Deployment error: need X-Starfighter-Authorization on internal requests. Also, set SF_SYSTEM_AUTH_TOKEN env variable."})
        end
      end
    end

    context 'with authorization header' do
      subject { Stockfighter::Client.new({ 'headers' => { 'X-Starfighter-Authorization' => 'fakeKey' } })}
      it 'should create an order' do
        VCR.use_cassette("venue_stock_new_order_with_auth") do
          order_details = {
            "account" => "EXB123456",
            "venue" => "TESTEX",
            "stock" => "FOOBAR",
            "qty" => 100,
            "direction" => "buy",
            "orderType" => "market"
          }
          pending "We don't have an API key to test with yet"
          res = subject.venue_stock_new_order('TESTEX', 'FOOBAR', order_details)
          expect(res).to eq({ "ok" => true })
        end
      end
    end
  end
end
