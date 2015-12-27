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

  describe '#headers' do
    it 'should set the given headers' do
      expect { subject.class.headers({ 'Accept' => 'anything' }) }.not_to raise_error
    end

    it 'should not clobber the existing headers' do
      subject.class.headers({ 'Accept' => 'anything' })
      subject.class.headers({ 'X-Api-Key' => '123' })
      expect(subject.class.instance_variable_get('@headers')).to eq({ 'Accept' => 'anything', 'X-Api-Key' => '123' })
    end
  end
end
