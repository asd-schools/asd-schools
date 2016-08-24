class CreateSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :schools do |t|
      # TODO: What is this?
      # calendar_years                      2013

      # TODO: What is this?
      # acara_sml_id                        40000

      # acara_sml_school_name               Corpus Christi Catholic School
      t.string :name, null: false

      # suburb                              BELLERIVE
      # address                             10 ALMA ST
      # post_code                           7018
      # state                               TAS
      t.string :suburb, null: false
      t.string :address, null: false
      t.string :post_code, null: false
      t.string :state, null: false

      # TODO: What is this?
      # school_sector_code_desc             C

      # school_type_code_desc               Primary
      t.string :school_type, null: false

      # year_range                          " U, Prep-6"
      t.string :year_range, null: false

      t.integer :total_enrollments, null: false
      t.integer :fulltime_equivalent_enrollments, null: false
      t.integer :female_enrollments, null: false
      t.integer :male_enrollments, null: false

      # TODO: What is this?
      # campus_type_code                    G

      # school_url                          http://www.corpuschristi.tas.edu.au
      t.string :url, null: false

      # latitude                            -42.871148
      # longitude                           147.372475
      t.point :location, null: false

      # Skipped
      # street_lat                          -42.871627
      # street_lon                          147.372386
      # geo_formatted_address               "10 ALMA ST, BELLERIVE, TAS 7018"
      # geo_suburb                          BELLERIVE
      # geo_reliability                     2
      # geo_supplier                        Sensis
      t.string :geo_supplier, null: false
    end
  end
end

