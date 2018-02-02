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
          type: record.kind,
          name: record.name,
          ttl: record.ttl,
          data: record.value
        }.to_json
      end
    end
  end
end
