class TitleizeSchoolNames < ActiveRecord::Migration[5.0]
  def change
    School.find_each do |school|
      school.name = school.name.titleize
      school.save!
    end
  end
end
