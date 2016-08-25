class School < ApplicationRecord
  attribute :location, :point

  scope :near, lambda { |point|
    point = "point '#{point}'"
    order <<-SQL
      location <-> #{point}
    SQL
  }

  has_many :reviews

  def display_sector
    {
      "G" => "Government school",
      "C" => "Catholic school",
      "I" => "Independant school"
    }[sector]
  end
  def display_address
    [
      address.titleize,
      suburb.titleize,
      post_code,
      state,
    ].join(", ")
  end
end

class ActiveRecord::Point
  def to_s
    "(#{Float(x)},#{Float(y)})"
  end
end
