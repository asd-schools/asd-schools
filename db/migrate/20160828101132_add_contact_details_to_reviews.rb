class AddContactDetailsToReviews < ActiveRecord::Migration[5.0]
  def change
    change_table :reviews do |t|
      t.string :contact, null: false, default: ""
    end
  end
end
