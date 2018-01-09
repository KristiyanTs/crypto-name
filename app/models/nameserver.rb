class Nameserver < ApplicationRecord
  serialize :ip_address, Array
end
