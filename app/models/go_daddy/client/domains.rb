module GoDaddy
  class Client
    module Domains
      def domains(*args)
        get('domains', *args)
      end

      def domain(name, *args)
        get("domains/#{name}", *args)
      end

      def update_domain(name, *args)
        patch("domains/#{name}", *args)
      end

      def delete_domain(name)
        delete("domains/#{name}")
      end

      def available?(*names)
        if names.one?
          get("domains/available", domain: names.first)
        else
          post("domains/available", names.to_json)
        end
      end

      def suggest(name)
        get('domains/suggest', query: name)
      end

      def tlds
        get('domains/tlds')
      end

      def validate_purchase(*args)
        post('domains/purchase/validate', *args)
      end

      # Request body to buy a domain
      # {
      #   "domain": "name",
      #   "consent": {
      #     "agreementKeys": [
      #       " "
      #     ],
      #     "agreedBy": " ",
      #     "agreedAt": " "
      #   },
      #   "period": 1,
      #   "nameServers": [
      #     " "
      #   ],
      #   "renewAuto": true,
      #   "privacy": false,
      #   "contactRegistrant": {
      #     "nameFirst": " ", #our own info if our clients are anonymous
      #     "nameMiddle": " ",
      #     "nameLast": " ",
      #     "organization": " ",
      #     "jobTitle": " ",
      #     "email": " ",
      #     "phone": " ",
      #     "fax": " ",
      #     "addressMailing": {
      #       "address1": " ",
      #       "address2": " ",
      #       "city": " ",
      #       "state": " ",
      #       "postalCode": " ",
      #       "country": "US"
      #     }
      #   },
      #   "contactAdmin": {
      #     "nameFirst": " ",
      #     "nameMiddle": " ",
      #     "nameLast": " ",
      #     "organization": " ",
      #     "jobTitle": " ",
      #     "email": " ",
      #     "phone": " ",
      #     "fax": " ",
      #     "addressMailing": {
      #       "address1": " ",
      #       "address2": " ",
      #       "city": " ",
      #       "state": " ",
      #       "postalCode": " ",
      #       "country": "US"
      #     }
      #   },
      #   "contactTech": {
      #     "nameFirst": " ",
      #     "nameMiddle": " ",
      #     "nameLast": " ",
      #     "organization": " ",
      #     "jobTitle": " ",
      #     "email": " ",
      #     "phone": " ",
      #     "fax": " ",
      #     "addressMailing": {
      #       "address1": " ",
      #       "address2": " ",
      #       "city": " ",
      #       "state": " ",
      #       "postalCode": " ",
      #       "country": "US"
      #     }
      #   },
      #   "contactBilling": {
      #     "nameFirst": " ",
      #     "nameMiddle": " ",
      #     "nameLast": " ",
      #     "organization": " ",
      #     "jobTitle": " ",
      #     "email": " ",
      #     "phone": " ",
      #     "fax": " ",
      #     "addressMailing": {
      #       "address1": " ",
      #       "address2": " ",
      #       "city": " ",
      #       "state": " ",
      #       "postalCode": " ",
      #       "country": "US"
      #     }
      #   }
      # }
      def purchase(name, *args)
        #TODO: research arguments
        post("domains/purchase", args)
      end
    end
  end
end
