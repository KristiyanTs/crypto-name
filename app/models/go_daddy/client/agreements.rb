module GoDaddy
  class Client
    module Agreements
      def get_agreements(*keys)
        get('agreements', keys: keys)
      end
    end
  end
end
