require_relative 'spec_helper'

describe Sample do
  before :each do
    DB[:conn].execute('DROP TABLE IF EXISTS samples')

    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS samples (
        id INTEGER PRIMARY KEY,
        name TEXT,
        description TEXT,
        location TEXT
      )
    SQL

    DB[:conn].execute(sql)
    DB[:conn].results_as_hash = true
  end
end
