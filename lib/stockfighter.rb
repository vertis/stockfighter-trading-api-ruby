require "stockfighter/version"
require "stockfighter/client"

module Stockfighter
  def self.heartbeat
    client.heartbeat
  end

  private
  def self.client
    @client ||= Stockfighter::Client.new
  end
end
