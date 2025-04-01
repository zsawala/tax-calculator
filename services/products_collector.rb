# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'
require 'ostruct'

class ProductsCollector
  class << self
    IMPORTED_KEYWORD = 'imported'

    def call
      puts "Please list your products one by one in following fashion: {number} {name of the product} at "\
          "{price for one item} \nWhen you finish please insert `q` and hit enter to calulate \n"

      [].tap do |products|
        loop do
          product = gets.split
          break puts("\n") if product == ['q']

          products << create_product(product)
        end
      end
    end

    private

    attr_accessor :products

    def create_product(product)
      ::OpenStruct.new(
        amount: product[0].to_d, imported: product[1] == IMPORTED_KEYWORD,
        name: product[1..-3], price: product[-1].to_d
      )
    end
  end
end
