ActiveAdmin.register School do
  permit_params :female_enrollments,
    :fulltime_equivalent_enrollments,
    :male_enrollments,
    :total_enrollments,
    :location,
    :address,
    :geo_supplier,
    :name,
    :post_code,
    :school_type,
    :state,
    :suburb,
    :url,
    :year_range,
    :sector,
    :autism_characteristics

  preserve_default_filters!
  remove_filter :reviews
  remove_filter :published_reviews

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :female_enrollments
      f.input :fulltime_equivalent_enrollments
      f.input :male_enrollments
      f.input :total_enrollments
      f.input :location
      f.input :address
      f.input :geo_supplier
      f.input :name
      f.input :post_code
      f.input :state
      f.input :suburb
      f.input :url
      f.input :year_range
      f.input :school_type,
        as: :select,
        collection: Search::SchoolTypes,
        include_blank: false

      f.input :sector,
        as: :select,
        collection: School::SECTORS.invert,
        include_blank: false

      f.input :autism_characteristics,
        as: :select,
        collection: Search::AutismClassifications,
        include_blank: false
    end

    f.actions
  end
end
