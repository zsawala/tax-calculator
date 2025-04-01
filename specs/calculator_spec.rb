# frozen_string_literal: true

ENV['test'] = 'true'
require_relative '../calculator'

describe Calculator do
  context '#call' do
    subject(:service) { described_class.new.call }

    before do
      allow_any_instance_of(Kernel).to receive(:gets).and_return(*input)
    end

    context 'input 1' do
      let(:input) { ['2 book at 12.49', '1 music CD at 14.99', '1 chocolate bar at 0.85', 'q'] }

      it 'display result' do
        expect { service }.to output(
          a_string_including("2 book: 24.98\n1 music CD: 16.49\n1 chocolate bar: 0.85\nSales Taxes: 1.50 \nTotal: 42.32")
        ).to_stdout
      end
    end

    context 'input 2' do
      let(:input) { ['1 imported box of chocolates at 10.00', '1 imported bottle of perfume at 47.50', 'q'] }

      it 'display result' do
        expect { service }.to output(
          a_string_including("1 imported box of chocolates: 10.50\n1 imported bottle of perfume: 54.65\nSales Taxes: 7.65 \nTotal: 65.15")
        ).to_stdout
      end
    end

    context 'input 3' do
      let(:input) do
        [
          '1 imported bottle of perfume at 27.99',
          '1 bottle of perfume at 18.99',
          '1 packet of headache pills at 9.75',
          '3 imported boxes of chocolates at 11.25',
          'q'
        ]
      end

      it 'display result' do
        expect { service }.to output(
          a_string_including("1 imported bottle of perfume: 32.19\n1 bottle of perfume: 20.89\n1 packet of headache pills: 9.75\n3 imported boxes of chocolates: 35.55\nSales Taxes: 7.90 \nTotal: 98.38")
        ).to_stdout
      end
    end
  end
end
