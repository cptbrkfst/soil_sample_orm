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

  let(:attributes) {
    {
      id:           nil,
      name:         'test_sample',
      description:  'test_sample_description',
      location:     'test_sample_location'
    }
  }

  let(:new_sample) { Sample.new(attributes) }

  describe '.table_name' do
    it 'creates a downcased, plural table name based on Class name' do
      expect(Sample.table_name).to eq('samples')
    end
  end

  
end
