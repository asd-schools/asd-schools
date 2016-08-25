class School < ApplicationRecord
  attribute :location, :point

  scope :near, lambda { |point|
    point = "point '#{point}'"
    order <<-SQL
      location <-> #{point}
    SQL
  }
end

class ActiveRecord::Point
  def to_s
    "(#{Float(x)},#{Float(y)})"
  end
end
