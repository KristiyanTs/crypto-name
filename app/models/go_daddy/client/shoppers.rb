# frozen_string_literal: true

module GoDaddy
  class Client
    module Shoppers
      # {
      #   "email": " ",
      #   "password": " ",
      #   "nameFirst": " ",
      #   "nameLast": " ",
      #   "externalId": 1,
      #   "marketId": "en-US"
      # }
      def get_shopper(id, *args)
        get("shoppers/#{id}", *args)
      end

      def update_shopper(id, *args)
        post("shoppers/#{id}", *args)
      end

      def create_subaccount(*args)
        post('shoppers/subaccount', *args)
      end
    end
  end
end
