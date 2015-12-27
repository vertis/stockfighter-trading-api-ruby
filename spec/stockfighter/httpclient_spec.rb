require 'spec_helper'
require 'pry'

describe Stockfighter::HTTPClient do
  subject do
    class MyClient
      include Stockfighter::HTTPClient
    end
    MyClient.new
  end

  describe '#base_uri' do
    it 'should set the base_uri' do
      expect { subject.class.base_uri 'hello' }.not_to raise_error
    end
  end

  describe '#format' do
    it 'should set the format of the API' do
      expect { subject.class.format :json }.not_to raise_error
    end
  end

  describe '#headers' do
    it 'should set the given headers' do
      expect { subject.class.headers({ 'Accept' => 'anything' }) }.not_to raise_error
    end

    it 'should not clobber the existing headers' do
      subject.class.headers({ 'Accept' => 'anything' })
      subject.class.headers({ 'X-Api-Key' => '123' })
      expect(subject.class.default_options[:headers]).to eq({ 'Accept' => 'anything', 'X-Api-Key' => '123' })
    end
  end

  describe '#default_options' do
    it 'should expose a hash' do
      expect(subject.class.default_options).to be_a(Hash)
    end
  end

  describe '#get' do
    subject do
      class MyClient
        include Stockfighter::HTTPClient

        base_uri 'https://api.stockfighter.io/ob/api'
        format :json
        headers({ 'X-Api-Key' => '1234' })
      end
      MyClient.new
    end

    it 'should return a response object' do
      VCR.use_cassette("heartbeat") do
        res = subject.class.get('/heartbeat')
        expect(res).to be_a(Typhoeus::Response)
      end
    end

    it 'should use the base_uri as a part of the request' do
      VCR.use_cassette("heartbeat") do
        res = subject.class.get('/heartbeat')
        expect(res.request.base_url).to eq("https://api.stockfighter.io/ob/api/heartbeat")
      end
    end

    it 'should include the default headers' do
      VCR.use_cassette("heartbeat") do
        res = subject.class.get('/heartbeat')
        expect(res.request.options[:headers]).to have_key('X-Api-Key')
      end
    end
  end
end
