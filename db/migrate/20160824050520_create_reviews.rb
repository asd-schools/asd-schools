class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :school_id, null: false
      # review_type is to represent the different types of reviews, eg: "My kid went here", "I heard about it..", etc
      t.string :review_type, null: false
      # Characteristics of my child, what I am looking for in a school to support.
      t.string :child_characteristics, array: true
      # net promoter type score 0-10.  "Would you recommend this school to someone"
      t.integer :score
      t.string  :pros, null: false
      t.string  :cons, null: false
      t.string :comments, null: false
      t.boolean :published, null: false, default: false
      t.timestamps
    end
  end
end
