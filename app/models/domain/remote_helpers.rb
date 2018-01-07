class Domain
  module RemoteHelpers
    def unlocked?
      GoDaddy.domain(name).response.body['status'] == 'UNLOCKED'
    end
  end
end
