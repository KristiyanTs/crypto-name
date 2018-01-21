class Detail
  class Domain
    attr_reader :detail, :domain

    def initialize(detail, domain)
      @detail = detail
      @domain = domain
    end

    def call
      copy = detail.dup        
      copy.user_id = nil
      copy.domain = domain
      copy.save
    end
  end
end
