class School < ApplicationRecord
  attribute :location, :point

  scope :near, lambda { |lat, lng|
    point = "point '(#{connection.quote(Float(lng))},#{Float(lat)})'"
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
