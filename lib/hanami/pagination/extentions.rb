module Hanami
  class Repository
    def self.enable_pagination!
      container.relation(relation).class.use(:pagination)
    end
  end
end
