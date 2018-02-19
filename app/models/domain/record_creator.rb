# frozen_string_literal: true

class Domain
  class RecordCreator
    attr_reader :domain

    def initialize(domain)
      @domain = domain
    end

    def call
      ::GoDaddy.update_records(domain.name, serialized_records)
    end

    def serialized_records
      @serialized ||= domain.records.map do |r|
        {
          type: r.kind.to_s,
          name: r.name,
          ttl: r.ttl,
          data: r.value
        }
      end
    end
  end
end
