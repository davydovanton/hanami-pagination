require "hanami/repository"

Hanami::Repository.class_eval do
  def self.enable_pagination!
    container.relation(relation).class.use(:pagination)
  end
end
