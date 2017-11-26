module GoDaddy
  class Client
    module Orders
      def orders(*args)
        get('orders', *args)
      end

      def get_order(id, *args)
        get("orders/#{id}", args)
      end
    end
  end
end
