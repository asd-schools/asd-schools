require 'picky'

class SuburbsIndex
  include Singleton
  attr_reader :index

  def initialize
    shortest_first = Picky::Weights::Dynamic.new do |word|
      30 - word.length
    end

    @index = Picky::Index.new :suburbs do
      category :name, weight: shortest_first
      category :postcode, partial: Picky::Partial::None.new
      category :state
      category :long_state
    end
    load_index()
  end

  def search(query)
    query = query.split(" ").map(&method(:to_term)).join(" ")
    srch = Picky::Search.new(index).search(query)
    srch.sort_by { |sub| sub.name.length }
    srch.ids
  end

  POSTCODE_REGEX = /\b(\d\d\d\d?)\b/

  private

  def load_index()
    Suburb.all.each {|s| @index.add s }
  end

  def to_term(word)
    return word if word =~ POSTCODE_REGEX
    word.downcase + "*"
  end

end
