class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.string :original_url
      t.integer :hits
      t.string :code

      t.timestamps
    end
  end
end
