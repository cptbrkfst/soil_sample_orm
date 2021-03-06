require_relative 'spec_helper'

describe Sample do
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
end
