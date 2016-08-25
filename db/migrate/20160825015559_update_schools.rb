class UpdateSchools < ActiveRecord::Migration[5.0]
  def change
    change_table :schools do |t|
      t.string :autism_characterstics, null: false, array: true, default: []
      t.string :sector, null: false
    end

  end
end
