class Domain
  class Record
    attr_reader :record

    def initialize(record)
      @record = record
    end

    def call
      GoDaddy.update_record(serialized_record)
    end

    def serialized_record
      [
        {
          type: record.kind,
          name: record.name,
          ttl: record.ttl,
          data: record.value
        }
      ]
    end
  end
end
