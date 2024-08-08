class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :gender, null: false
      t.integer :age
      t.string :entry_term
      t.string :avatar
      t.string :favorite_type
      t.string :favorite_body_part
      t.string :programming_fun_moment, limit: 50

      t.timestamps
    end
  end
end
