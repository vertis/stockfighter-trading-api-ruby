require 'rspec'
#require 'webmock/rspec'
require 'vcr'
require './lib/stockfighter'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb
end
