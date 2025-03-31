# frozen_string_literal: true

class ResultDisplayer
  def initialize(products)
    @products = products
  end

  def call
    display_receipt
    display_summary
  end

  private

  attr_accessor :products

  def display_receipt
    products.each do |product|
      puts "#{product.amount.to_i} #{product.name.join(' ')}: #{format('%.2f', product.full_price.to_f)}"
    end
  end

  def display_summary
    formatted_tax_sum = format('%.2f', products.sum(&:full_tax))
    formatted_full_price_sum = format('%.2f', products.sum(&:full_price).to_f)

    puts(
      "Sales Taxes: #{formatted_tax_sum} \nTotal: #{formatted_full_price_sum}"
    )
  end
end
