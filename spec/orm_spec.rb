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

  describe '.column_names' do
    it 'returns an array of SQL column names' do
      expect(Sample.column_names).to eq(['id', 'name', 'description', 'location'])
    end
  end

  describe '.table_name' do
    it 'creates a downcased, plural table name based on Class name' do
      expect(Sample.table_name).to eq('samples')
    end
  end

  describe '.attribute_names_for_insert' do
    it 'creates a string of attribute names delimted by commas' do
      expect(Sample.attribute_names_for_insert).to eq("name,description,location")
    end
  end

  describe '.create_table' do
    it ''
  end
end
