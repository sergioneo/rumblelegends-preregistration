class AddUsernameToMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :username, :string
  end
end
