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

  describe '#stocks' do
    it 'should get the stocks available on the venue' do
      VCR.use_cassette("stocks") do
        expect(subject.stocks('TESTEX')).to eq({ 'ok' => true, 'symbols' => [{'name'=>'Foreign Owned Occluded Bridge Architecture Resources', 'symbol'=>'FOOBAR'}] })
      end
    end
  end

  describe '#orderbook' do
    it 'should get the orderbook for the given stock on the given venue' do
      VCR.use_cassette("orderbook") do
        res = subject.orderbook('TESTEX', 'FOOBAR')
        expect(res['ok']).to eq(true)
        expect(res.keys).to eq(["ok", "venue", "symbol", "ts", "bids", "asks"])
      end
    end
  end

  describe '#quote' do
    it 'should get the quote for the given stock on the given venue' do
      VCR.use_cassette("quote") do
        res = subject.quote('TESTEX', 'FOOBAR')
        expect(res['ok']).to eq(true)
        expect(res.keys).to eq(["ok", "symbol", "venue", "bid", "bidSize", "askSize", "bidDepth", "askDepth", "last", "lastSize", "lastTrade", "quoteTime"])
      end
    end
  end

  describe '#new_order' do
    context 'without authorization header' do
      it 'should fail to create an order' do
        VCR.use_cassette("new_order_without_auth") do
          order_details = {
            "account" => "EXB123456",
            "venue" => "TESTEX",
            "stock" => "FOOBAR",
            "qty" => 100,
            "direction" => "buy",
            "orderType" => "market"
          }
          res = subject.new_order('TESTEX', 'FOOBAR', order_details)
          expect(res).to eq({"ok"=>false, "error"=>"Deployment error: need X-Starfighter-Authorization on internal requests. Also, set SF_SYSTEM_AUTH_TOKEN env variable."})
        end
      end
    end

    context 'with authorization header' do
      subject { Stockfighter::Client.new({ 'headers' => { 'X-Starfighter-Authorization' => 'fakeKey' } })}
      it 'should create an order' do
        VCR.use_cassette("new_order_with_auth") do
          order_details = {
            "account" => "EXB123456",
            "venue" => "TESTEX",
            "stock" => "FOOBAR",
            "qty" => 100,
            "direction" => "buy",
            "orderType" => "market"
          }
          pending "We don't have an API key to test with yet"
          res = subject.new_order('TESTEX', 'FOOBAR', order_details)
          expect(res).to eq({ "ok" => true })
        end
      end
    end
  end

  describe '#order_status' do
    context 'with authorization header' do
      subject { Stockfighter::Client.new({ 'headers' => { 'X-Starfighter-Authorization' => 'fakeKey' } })}
      it 'should return the order status' do
        VCR.use_cassette("order_status_with_auth") do
          pending "We don't have an API key to test with yet"
          res = subject.order_status('TESTEX', 'FOOBAR', 12)
          expect(res).to eq(true)
          expect(res.keys).to eq([])
        end
      end
    end
  end

  describe '#orders_status' do
    context 'with authorization header' do
      subject { Stockfighter::Client.new({ 'headers' => { 'X-Starfighter-Authorization' => 'fakeKey' } })}
      it 'should return the status of all the orders' do
        VCR.use_cassette("orders_status_with_auth") do
          pending "We don't have an API key to test with yet"
          res = subject.orders_status('TESTEX', 'ACCOUNTID')
          expect(res).to eq(true)
          expect(res.keys).to eq([])
        end
      end
    end
  end

  describe '#orders_stock_status' do
    context 'with authorization header' do
      subject { Stockfighter::Client.new({ 'headers' => { 'X-Starfighter-Authorization' => 'fakeKey' } })}
      it 'should return the status of all the orders' do
        VCR.use_cassette("orders_stock_status_with_auth") do
          pending "We don't have an API key to test with yet"
          res = subject.orders_stock_status('TESTEX', 'ACCOUNTID', 'FOOBAR')
          expect(res).to eq(true)
          expect(res.keys).to eq([])
        end
      end
    end
  end

  describe '#cancel_order' do
    context 'with authorization header' do
      subject { Stockfighter::Client.new({ 'headers' => { 'X-Starfighter-Authorization' => 'fakeKey' } })}
      it 'should cancel the order' do
        VCR.use_cassette("cancel_order_with_auth") do
          pending "We don't have an API key to test with yet"
          res = subject.cancel_order('TESTEX', 'FOOBAR', 12)
          expect(res).to eq(true)
          expect(res.keys).to eq([])
        end
      end
    end
  end

  # FIXME VCR doesn't appear to be recording/replaying
  describe '#tickertape' do
    it 'should receive a failure message if the venue can\'t be found' do
      VCR.use_cassette("tickertape_no_venue") do
        assert_and_exit = -> (msg) { expect(msg).to(eq({"ok"=>false, "error"=>"Could not find venue in path [/ob/api/ws/TAH97715708/venues/FAKE/tickertape], expecting /ws/$TRADING_ACCOUNT/venues/$VENUE/.... Check the websocket URL."})); EM.stop }
        subject.tickertape("TAH97715708", "FAKE", &assert_and_exit)
      end
    end
  end
end
