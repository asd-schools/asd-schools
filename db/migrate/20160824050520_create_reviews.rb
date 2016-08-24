class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :school_id, null: false
      # review_type is to represent the different types of reviews, eg: "My kid went here", "I heard about it..", etc
      t.string :review_type, null: false
      t.integer :score
      t.string  :whatisgood, null: false
      t.string  :whatisbad, null: false
      t.string :othercomment, null: false
      t.timestamps
    end
  end
end
