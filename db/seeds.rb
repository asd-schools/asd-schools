
unless School.any?
  require 'csv'
  CSV.foreach("db/acara-schools-geocoded-data.csv", headers: true) do |row|
    School.create!(
      name: row[2],
      suburb: row[3],
      address: row[4],
      post_code: row[5],
      state: row[6],
      school_type: row[8],
      year_range: row[9],
      total_enrollments: row[10],
      fulltime_equivalent_enrollments: row[11],
      female_enrollments: row[12] || 0,
      male_enrollments: row[13] || 0,
      url: row[15],
      location: ActiveRecord::Point.new(row[16].to_f, row[17].to_f),
      geo_supplier: row[23],
    )
  end
end
