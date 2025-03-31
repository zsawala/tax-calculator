# frozen_string_literal: true

class DatasetFetcher
  WORDLISTS_PATH = './wordlists/*'

  def self.call
    data = Set.new
    Dir.glob(WORDLISTS_PATH).each do |filename|
      next if File.directory?(filename)

      data = data.merge(File.read(filename).split("\n").to_set)
    end

    data
  end
end
