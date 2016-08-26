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
    :autism_characteristics

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
      f.input :school_type
      f.input :state
      f.input :suburb
      f.input :url
      f.input :year_range
      f.input :autism_characteristics,
        as: :select,
        collection: Search::AutismClassifications,
        include_blank: false
    end

    f.actions
  end
end
