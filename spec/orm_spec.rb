require_relative 'spec_helper'

describe Sample do
  before :each do
    DB[:conn].execute('DROP TABLE IF EXISTS samples')
    Sample.create_table
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

  describe '.create_table' do
    it 'creates a table based on class name' do
      expect{ DB[:conn].execute('SELECT name FROM samples') }.to_not raise_exception
    end
  end

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

  describe '.insert' do
    it 'inserts an instance of an object into its corresponding table' do
      new_sample.insert
      expect{ DB[:conn].execute('SELECT name FROM samples WHERE id = 1') }.to_not raise_exception
    end
  end

  describe '.destroy' do
    it 'destroys an instance of an object from its corresponding table' do
      new_sample.insert
      new_sample.destroy
      expect(DB[:conn].execute('SELECT name FROM samples')).to eq([])
    end
  end

  describe '.update' do
    it 'updates an instance of an object from its corresponding table' do
      new_sample.insert
      new_sample.name = 'test_sample_new'
      new_sample.update

      expect(DB[:conn].execute('SELECT name FROM samples;')[0][0]).to eq('test_sample_new')
    end
  end

  describe '.save' do
    it 'inserts an instance if not persisted' do
      new_sample.save
      expect(new_sample.id).to eq(1)
    end

    it 'updates an instance if persisted' do
      new_sample.save
      new_sample.name = 'test_sample_new'
      new_sample.save

      expect(new_sample.name).to eq('test_sample_new')
      expect(new_sample.id).to eq(1)
    end
  end

  describe '.find' do
    it 'finds a database row by id and returns its corresponding instance' do
      new_sample.save
      expect(Sample.find(1).name).to eq('test_sample')
    end

    it 'returns nil when no item is found' do
      expect(Sample.find(2)).to eq(nil)
    end
  end
end
