require 'set'
# Dir["../wordlists/*.txt"].each { |file| require file }

class DatasetFetcher
  def self.call
    data = Set.new
    Dir.glob('./wordlists/*').each do |filename|
      next if File.directory?(filename)

      data = data.merge(File.read(filename).split.to_set)
    end

    data
  end

  private

  # def load_file(filename)
  #   data = File.read("/wordlists/#{filename}.txt")

  # end
end