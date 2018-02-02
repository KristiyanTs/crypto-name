class Record < ApplicationRecord
  belongs_to :domain

  enum kind: %w[A AAAA CNAME MX NS SOA SRV TXT]
end
