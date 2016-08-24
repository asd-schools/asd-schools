class School < ApplicationRecord
  attribute :location, :point

  scope :near, lambda { |lat, lng|
    point = "point '(#{connection.quote(Float(lng))},#{Float(lat)})'"
    order <<-SQL
      location <-> #{point}
    SQL
  }

end
