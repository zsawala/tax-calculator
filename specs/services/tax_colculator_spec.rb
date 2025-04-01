# frozen_string_literal: true

require_relative '../../services/tax_calculator'
require_relative '../../services/dataset_fetcher'
require 'ostruct'

describe TaxCalculator do
  context '#call' do
    subject(:service) { described_class.new(products, data).call }

    let(:data) { ::DatasetFetcher.call }

    context 'without excluded product' do
      context 'with imported product' do
        # 15% tax
        context 'with multiple amount' do
          let(:products) do
            [::OpenStruct.new(amount: 2, imported: true, name: ['perfume'], price: 10.0)]
          end

          it 'calculate correct tax' do
            result = service
            product = result[0]
            puts product
            expect(product.full_price).to eq(23.0)
            expect(product.full_tax).to eq(3.0)
          end
        end

        # 15% tax
        context 'with single product' do
          let(:products) do
            [::OpenStruct.new(amount: 1, imported: true, name: ['perfume'], price: 10.0)]
          end

          it 'calculate correct tax' do
            result = service
            product = result[0]

            expect(product.full_price).to eq(11.5)
            expect(product.full_tax).to eq(1.5)
          end
        end
      end

      context 'without imported product' do
        # 10% tax
        context 'with multiple amount' do
          let(:products) do
            [::OpenStruct.new(amount: 2, imported: false, name: ['perfume'], price: 17.99)]
          end

          it 'calculate correct tax' do
            result = service
            product = result[0]

            expect(product.full_price).to eq(39.58)
            expect(product.full_tax).to eq(3.6)
          end
        end

        # 10% tax
        context 'with single product' do
          let(:products) do
            [::OpenStruct.new(amount: 1, imported: false, name: ['perfume'], price: 17.99)]
          end

          it 'calculate correct tax' do
            result = service
            product = result[0]

            expect(product.full_price).to eq(19.79)
            expect(product.full_tax).to eq(1.8)
          end
        end
      end
    end

    context 'with excluded product' do
      context 'with imported product' do
        # 5% tax
        context 'with multiple amount' do
          let(:products) do
            [::OpenStruct.new(amount: 2, imported: true, name: ['book'], price: 20.99)]
          end

          it 'calculate correct tax' do
            result = service
            product = result[0]

            expect(product.full_price).to eq(44.08)
            expect(product.full_tax).to eq(2.1)
          end
        end

        # 5% tax
        context 'with single product' do
          let(:products) do
            [::OpenStruct.new(amount: 1, imported: true, name: ['book'], price: 20.99)]
          end

          it 'calculate correct tax' do
            result = service
            product = result[0]

            expect(product.full_price).to eq(22.04)
            expect(product.full_tax).to eq(1.05)
          end
        end
      end

      context 'without imported product' do
        # 0% tax
        context 'with multiple amount' do
          let(:products) do
            [::OpenStruct.new(amount: 2, imported: false, name: ['book'], price: 20.99)]
          end

          it 'calculate correct tax' do
            result = service
            product = result[0]

            expect(product.full_price).to eq(41.98)
            expect(product.full_tax).to eq(0.0)
          end
        end

        # 0% tax
        context 'with single product' do
          let(:products) do
            [::OpenStruct.new(amount: 1, imported: false, name: ['book'], price: 20.99)]
          end

          it 'calculate correct tax' do
            result = service
            product = result[0]

            expect(product.full_price).to eq(20.99)
            expect(product.full_tax).to eq(0.0)
          end
        end
      end
    end
  end
end
