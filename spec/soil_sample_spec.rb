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

  describe '.attributes' do
    it 'returns hash of class attributes' do
      expect(Sample.attributes).to eq(
        {
          :id => "INTEGER PRIMARY KEY",
          :name => "TEXT",
          :description => "TEXT",
          :location => "TEXT"
        }
      )
    end
  end

  describe 'initialize' do
    it 'creates an new instance of a sample' do
      expect(Sample.new).to be_a Sample
    end

    it 'creates a new sample with attributes' do
      expect(new_sample.name).to eq('test_sample')
    end
  end

  describe 'attr_accessor' do
    it 'creates attr_accessors for each column name' do
      old_name = new_sample.name
      new_name = new_sample.name = 'new_test_sample'
      old_description = new_sample.description
      new_description = new_sample.description = 'new_test_sample_description'
      expect(old_name).to eq('test_sample')
      expect(new_name).to eq('new_test_sample')
      expect(old_description).to eq('test_sample_description')
      expect(new_description).to eq('new_test_sample_description')
    end
  end

  describe '.table_name' do
    it 'creates a downcased, plural table name based on Class name' do
      expect(Sample.table_name).to eq('samples')
    end
  end
end
