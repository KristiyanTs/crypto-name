# frozen_string_literal: true

class Detail::Null
  def self.to_details
    Detail::Null::GoDaddy.to_details
  end
end
