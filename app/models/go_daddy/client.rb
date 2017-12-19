module GoDaddy
  class Client
    # include ::GoDaddy::Client::*
    include GoDaddy::Client::Domains
    include GoDaddy::Client::Abuse
    include GoDaddy::Client::Orders
    include GoDaddy::Client::Shoppers
    include GoDaddy::Client::Subscriptions
    include GoDaddy::Errors

    attr_accessor :key, :secret, :url

    def initialize(key: ENV.fetch('GODADDY_KEY'), secret: ENV.fetch('GODADDY_SECRET'), url: ENV['GODADDY_URL'])

      @key = key
      @secret = secret
      @url = url || 'https://api.godaddy.com/v1/'.freeze
    end

    [:get, :post, :patch, :head, :delete].each do |method|
      define_method(method) do |*args|
        response = client.send(method, *args)
        fail_on_error(response) || response
      end
    end

    def self.method_missing(method, *args)
      if client.respond_to?(method)
        client.send(method, *args)
      else
        super
      end
    end

    private

    def client
      @client ||= Faraday.new(url: url, headers: headers, ssl: { verify: true }) do |faraday|
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter Faraday.default_adapter
      end
    end

    def headers
      {
        'Accept': 'application/json',
        'Authorization' => "sso-key #{key}:#{secret}",
      }.reject { |_, v| v.nil? }
    end

    def fail_on_error(response)
      return if response.success?

      klass = case response.status
              when 404 then NotFound
              else Error
              end
      raise klass, response.body
    end
  end
end
