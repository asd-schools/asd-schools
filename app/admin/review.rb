ActiveAdmin.register Review do
  permit_params :published, :comments

  preserve_default_filters!
  remove_filter :school
  limit_length = lambda do |str|
    if str.length > 30
      str[0..30] + "..."
    else
      str
    end
  end

  index do
    selectable_column
    id_column
    column :school
    column :review_type
    column :published
    column :created_at
    column :pros do |review|
      limit_length.call(review.pros)
    end
    column :cons do |review|
      limit_length.call(review.cons)
    end
    column :comments do |review|
      limit_length.call(review.comments)
    end
    column :score
    column :child_characteristics
    actions
  end

end

