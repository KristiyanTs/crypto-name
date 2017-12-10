module GoDaddy
  def self.configure
    yield(configuration)
    reset_client!
  end

  def self.client
    @client ||= GoDaddy::Client.new(**configuration)
  end

  def self.reset_client!
    @client = nil
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.method_missing(method, *args)
    if client.respond_to?(method)
      client.send(method, *args)
    else
      super
    end
  end

  def self.respond_to_missing?(method_name, include_private = false)
    client.respond_to?(method_name, include_private)
  end
end
