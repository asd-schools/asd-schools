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

end
