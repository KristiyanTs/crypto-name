%w[abuse agreements domains orders shoppers subscriptions].each do |f|
  require_relative "./client/#{f}"
end

module GoDaddy
  class Client
    # include ::GoDaddy::Client::*
    attr_accessor :key, :secret, :url, :shopper_id

    def initialize(key: ENV.fetch('GODADDY_KEY'), secret: ENV.fetch('GODADDY_SECRET'), url: ENV['GODADDY_URL'], shopper_id: nil)

      @key = key
      @secret = secret
      @url = url || 'https://api.godaddy.com/v1/'.freeze
      @shopper_id = shopper_id
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
        'X-Shopper-Id' => shopper_id
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

    include GoDaddy::Client::Domains
    include GoDaddy::Client::Abuse
    include GoDaddy::Client::Orders
    include GoDaddy::Client::Shoppers
    include GoDaddy::Client::Subscriptions
    include GoDaddy::Client::Agreements
    include GoDaddy::Errors
  end
end
