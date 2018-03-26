class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.string :wp_id
      t.integer :active

      t.timestamps
    end
  end
end
