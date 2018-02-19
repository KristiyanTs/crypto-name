# frozen_string_literal: true

class Domain
  class NameServers
    attr_reader :domain, :name_servers

    def initialize(domain, name_servers)
      @domain = domain
      @name_servers = name_servers
    end

    def call
      GoDaddy.update_domain(domain.name, nameServers: name_servers)
    end
  end
end
