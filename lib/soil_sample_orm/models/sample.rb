# Sample Object Class
class Sample
  ATTRIBUTES = {
    id: 'INTEGER PRIMARY KEY',
    name: 'TEXT',
    description: 'TEXT',
    location: 'TEXT'
  }

  include Persistable::InstanceMethods
  extend  Persistable::ClassMethods

  self.column_names.each do |col_name|
    attr_accessor col_name.to_sym
  end
end
