class NoArrayForAutismClassifications < ActiveRecord::Migration[5.0]
  def up
    remove_column :schools, :autism_characterstics
    add_column :schools, :autism_characteristics, :string, null: false, default: ""
  end

  def down
    remove_column :schools, :autism_characteristics
    add_column :schools, :autism_characterstics, :string, null: false, default: [], array: true
  end
end
