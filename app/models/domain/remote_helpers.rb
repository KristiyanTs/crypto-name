# frozen_string_literal: true

class Domain
  module RemoteHelpers
    def unlocked?
      # GoDaddy.domain(name).response.body['status'] == 'UNLOCKED'
      false
    end
  end
end
