# frozen_string_literal: true

class Nameserver < ApplicationRecord
  serialize :ip_address, Array
end
