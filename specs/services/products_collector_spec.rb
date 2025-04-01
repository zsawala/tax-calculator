# frozen_string_literal: true

require_relative '../../services/products_collector'

describe ProductsCollector do
  context '#call' do
    subject(:service) { described_class.call }

    before do
      allow_any_instance_of(Kernel).to receive(:gets).and_return(*input)
    end

    context 'with exit' do
      let(:input) { ['q'] }

      it 'finish processing' do
        result = service
        expect(result).to be_empty
      end
    end

    context 'with imported products' do
      let(:input) { ['1 imported box of chocolates at 10.00', 'q'] }

      it 'returns one product' do
        result = service
        first_product = result[0]

        expect(result).not_to be_empty
        expect(first_product.amount).to eq(1)
        expect(first_product.imported).to be_truthy
        expect(first_product.name).to eq(%w[imported box of chocolates])
        expect(first_product.price).to eq(10.00)
      end
    end

    context 'without imported products' do
      let(:input) { ['2 book at 12.49', 'q'] }

      it 'returns one product' do
        result = service
        first_product = result[0]

        expect(result).not_to be_empty
        expect(first_product.amount).to eq(2)
        expect(first_product.imported).to be_falsey
        expect(first_product.name).to eq(%w[book])
        expect(first_product.price).to eq(12.49)
      end
    end
  end
end
