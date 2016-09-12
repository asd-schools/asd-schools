class TitleizeAddresses < ActiveRecord::Migration[5.0]
  def change
    School.find_each do |school|
      school.suburb = school.suburb.titleize
      school.address = school.address.titleize
      school.save!
    end
  end
end
