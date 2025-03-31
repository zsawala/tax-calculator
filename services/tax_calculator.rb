# frozen_string_literal: true

class TaxCalculator
  IMPORT_TAX = 5
  SELL_TAX = 10

  def initialize(products, data)
    @products = products
    @data = data
  end

  def call
    products.map do |product|
      tax = calculate_tax(product)
      product.full_price = (product.price + tax) * product.amount
      product.full_tax = tax * product.amount
      product
    end
  end

  private

  attr_accessor :products
  attr_reader :data

  def calculate_tax(product)
    import_tax = product.imported ? IMPORT_TAX : 0
    sell_tax = exemption_product?(product.name) ? 0 : SELL_TAX

    (((product.price * (import_tax + sell_tax)) / 100) * 20).ceil / 20.0
  end

  def exemption_product?(name)
    data.intersect?(name) || name.include?('book')
  end
end
