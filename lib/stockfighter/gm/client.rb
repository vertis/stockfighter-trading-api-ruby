module Stockfighter
  module GM
    class Client
      def initialize(options={})
        @connection = Faraday.new 'https://api.stockfighter.io/gm' do |conn|
          conn.request :json

          if options['headers']
            conn.headers.merge!(options['headers'])
          end

          #conn.response :xml,  :content_type => /\bxml$/
          conn.response :json #, :content_type => /\bjson$/

          conn.adapter :typhoeus
        end
      end

      def start_level(name)
        @connection.post("levels/#{name}").body
      end

      def restart_level(instance_id)
        @connection.post("instances/#{instance_id}/restart").body
      end

      def stop_level(instance_id)
        @connection.post("instances/#{instance_id}/stop").body
      end

      def resume_level(instance_id)
        @connection.post("instances/#{instance_id}/resume").body
      end

      def level_status(instance_id)
        @connection.get("instances/#{instance_id}").body
      end
    end
  end
end
