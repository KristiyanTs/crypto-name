module GoDaddy
  class Client
    module Subscriptions
      def subscriptions(*args)
        get('subscriptions', *args)
      end

      def get_subscription(id, *args)
        get("subscriptions/#{id}", *args)
      end

      def update_subscription(id, *args)
        patch("subscriptions/#{id}", *args)
      end

      def delete_sbuscription(id, *args)
        delete("subscriptions/#{id}", *args)
      end

      def product_groups
        get('subscriptions/productGroups')
      end
    end
  end
end
