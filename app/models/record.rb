class Record < ApplicationRecord
  belongs_to :domain

  enum kind: ['A', 'AAAA', 'CNAME', 'MX', 'NS', 'SOA', 'SRV', 'TXT']
end
