# Sample Object Class
class Sample
  ATTRIBUTES = {
    id: 'INTEGER PRIMARY KEY',
    name: 'TEXT',
    description: 'TEXT',
    location: 'TEXT'
  }.freeze

  include Persistable::InstanceMethods
  extend  Persistable::ClassMethods
end
