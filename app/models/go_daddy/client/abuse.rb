# frozen_string_literal: true

module GoDaddy
  class Client
    module Abuse
      def abuses(*args)
        get('abuse/tickets', args)
      end

      def create_abuse(*args)
        post('abuse/tickets', *args)
      end

      def get_abuse(id, *args)
        get("abuse/tickets/#{id}", *args)
      end
    end
  end
end
