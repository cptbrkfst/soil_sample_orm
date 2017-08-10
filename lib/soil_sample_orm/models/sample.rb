# Sample Object Class
class Sample
  ATTRIBUTES = {
    :id => 'INTEGER PRIMARY KEY',
    :name => 'TEXT',
    :description => 'TEXT',
    :location => 'TEXT'
  }

  include Persistable::InstanceMethods
  extend  Persistable::ClassMethods
end
