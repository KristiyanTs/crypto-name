class Domain
  class RecordCreator
    attr_reader :record

    def initialize(record)
      @record = record
    end

    def call
      debugger
      GoDaddy.update_records(record.domain.name, serialized_record)
    end

    def serialized_record
      all_records = []
      record.domain.records.each do |r|
        all_records <<
          {
            type: record.kind,
            name: record.name,
            ttl: record.ttl,
            data: record.value
          }.to_json
      end
      all_records
    end
  end
end
