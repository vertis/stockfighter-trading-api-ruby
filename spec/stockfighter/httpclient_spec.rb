require 'spec_helper'

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
end
