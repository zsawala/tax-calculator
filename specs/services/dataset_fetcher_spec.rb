# frozen_string_literal: true

require_relative '../../services/dataset_fetcher'

describe DatasetFetcher do
  context '#call' do
    subject(:service) { described_class.call }

    it 'returns all data from wordlists' do
      result = service
      expect(result.count).to eq(4134)
      expect(result.first).to eq('abiyuch')
    end
  end
end
