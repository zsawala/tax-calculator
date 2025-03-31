# frozen_string_literal: true

Dir["./services/*.rb"].each { |file| require file }
require 'bigdecimal'
require 'bigdecimal/util'
require 'ostruct'
require 'pry'

class Calculator
  def call
    fetch_products
    calculate_products_tax
    display_results
  end

  private

  attr_accessor :products

  def data
    ::DatasetFetcher.call
  end

  def fetch_products
    @products = ::ProductsCollector.call
  end

  def calculate_products_tax
    @products = ::TaxCalculator.new(products, data).call
  end

  def display_results
    ::ResultDisplayer.new(products).call
  end
end

Calculator.new.call
