module Persistable
  DB = { :conn => SQLite3::Database.new('db/soil_sample.db') }.freeze
  # Class methods for ORM persistence
  module ClassMethods
    def self.extended(base) # Hook
      puts "#{base} has been extended by #{self}"
    end

    def column_names
      DB[:conn].results_as_hash = true

      sql = "pragma table_info('#{table_name}')"

      table_info = DB[:conn].execute(sql)
      column_names = []
      table_info.each do |row|
        column_names << row['name']
      end
      column_names.compact
    end

    def attributes
      self::ATTRIBUTES
    end

    def table_name
      "#{self.to_s.downcase}s"
    end
  end
  # Instance methods for ORM persistence
  module InstanceMethods
    def self.included(base) # Hook
      puts "#{base} has mixed in #{self}"
    end

    def initialize(options = {})
      options.each do |key, value|
        self.send("#{key}=", value)
      end
    end
  end
end
