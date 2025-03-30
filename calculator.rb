Dir["./services/*.rb"].each { |file| require file }
require 'bigdecimal'
require 'bigdecimal/util'
require 'pry'
require 'benchmark'
require 'ostruct'

class Calculator
  IMPORTED_KEYWORD = 'imported'.freeze
  IMPORT_TAX = 5.freeze
  SELL_TAX = 10.freeze

  def initialize
    @products = []
  end

  def call
    data
    puts "Please list your products one by one in following fashion: {number} {name of the product} at "\
         "{price for one item} \nWhen you finish please insert `q` and hit enter to calulate \n"

    fetch_products
    calculate_product_tax
    display_results
  end

  private

  attr_accessor :products

  def data
    @data ||= ::DatasetFetcher.call
  end

  def fetch_products
    loop do
      product = gets.split
      break puts("\n") if product == ['q']

      products << OpenStruct.new(
        amount: product[0], imported: product[1] == IMPORTED_KEYWORD,
        name: product[1..-3], full_price: product[-1].to_d * product[0].to_d
      )
    end
  end

  def calculate_product_tax
    products.each do |product|
      import_tax = product.imported ? IMPORT_TAX : 0
      sell_tax = exemption_product?(product.name) ? 0 : SELL_TAX

      tax = (((product.full_price * (import_tax + sell_tax)) / 100) * 20).round / 20.0
      product.tax = tax
      product.full_price = product.full_price + tax
    end
  end

  def exemption_product?(name)
    data.intersect?(name) || name.include?('book')
  end

  def display_results
    products.each do |product|
      puts "#{product.amount} #{product.name.join(' ')}: #{product.full_price.to_f.to_s.rjust(2, '0')}"
    end

    puts(
      "Sales Taxes: #{format('%.2f', products.sum(&:tax))} \nTotal: #{format('%.2f', products.sum(&:full_price).to_f)}"
    )
  end
end

Calculator.new.call
