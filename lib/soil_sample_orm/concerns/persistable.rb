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

    def attribute_names_for_insert
      self.attributes.keys[1..-1].join(',')
    end

    def question_marks_for_insert
      (self.attributes.keys.size - 1).times.collect { '?' }.join(',')
    end

    def sql_for_update
      self.attributes.keys[1..-1].collect{ |attr_name| "#{attr_name} = ?" }.join(',')
    end

    def table_name
      "#{self.to_s.downcase}s"
    end

    def create_sql
      self.attributes.collect do |attr_name, schema|
        "#{attr_name} #{schema}"
      end.join(',')
    end

    def create_table
      sql = <<-SQL
        CREATE TABLE IF NOT EXISTS #{self.table_name} (
          #{self.create_sql}
        )
      SQL
      DB[:conn].execute(sql)
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

    def attribute_values
      self.class.attributes.keys[1..-1].collect do |attr_name|
        self.send(attr_name)
      end
    end

    def insert
      sql = <<-SQL
        INSERT INTO #{self.class.table_name} (#{self.class.attribute_names_for_insert})
        VALUES (#{self.class.question_marks_for_insert})
      SQL
      DB[:conn].execute(sql, *attribute_values)
      self.id = DB[:conn].execute('SELECT last_insert_rowid();')[0][0]
    end

    def destroy
      sql = <<-SQL
        DELETE FROM #{self.class.table_name} WHERE id = ?
      SQL

      DB[:conn].execute(sql, self.id)
    end

    def update
      sql = <<-SQL
        UPDATE #{self.class.table_name}
        SET #{self.class.sql_for_update} WHERE id = ?
      SQL

      DB[:conn].execute(sql, *attribute_values, self.id)
    end
  end
end
