module Persistable
  # Class methods for ORM persistence
  module ClassMethods
    def self.extended(base) # Hook
      puts "#{base} has been extended by #{self}"
      base.attributes.keys.each do |attribute_name|
        attr_accessor attribute_name
      end
    end

    def attributes
      self::ATTRIBUTES
    end
  end
  # Instance methods for ORM persistence
  module InstanceMethods
    def self.included(base) # Hook
      puts "#{base} has mixed in #{self}"
    end
  end
end
