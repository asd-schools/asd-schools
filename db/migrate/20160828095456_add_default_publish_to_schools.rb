class AddDefaultPublishToSchools < ActiveRecord::Migration[5.0]
  def change
    change_table :schools do |t|
      t.boolean :publish_new_reviews_by_default, null: false, default: true
    end
  end
end
