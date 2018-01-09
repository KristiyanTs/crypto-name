module GoDaddy
  class Client
    module Domains
      def domains(*args)
        get('domains', *args)
      end

      def domain(name)
        get("domains/#{name}")
      end

      def update_domain(name, *args)
        patch("domains/#{name}", *args)
      end

      def delete_domain(name)
        delete("domains/#{name}")
      end

      def transfer_domain(name, *args)
        post("domains/#{name}/transfer", *args)
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

      def get_tlds
        get('domains/tlds')
      end

      def get_domain_agreements(*tlds, privacy)
        get('domains/agreements', privacy: privacy, tlds: tlds)
      end

      def get_domain_purchase_schema_tld(tld)
        get("domains/purchase/schema/#{tld}")
      end

      def validate_purchase(*args)
        post('domains/purchase/validate', *args)
      end

      def purchase(*args)
        post("domains/purchase", *args)
      end
    end
  end
end
