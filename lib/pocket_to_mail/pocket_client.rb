module PocketToMail
  class PocketClient
    def initialize(consumer_key, access_token)
      @client = Pocket.client(
        :consumer_key => consumer_key,
        :access_token => access_token
      )
    end

    def older_items
      @client.retrieve(
        :sort => :oldest,
        :detailType => :simple,
        :count => 5
      )
    end

    def delete_older_items!(info)
      actions = []
      info['list'].each do |key, item|
        actions << {
          action: 'delete',
          item_id: item['item_id'].to_i
        }
      end

      @client.modify(actions)
    end
  end
end