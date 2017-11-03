class RemoveDefaultFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :Default, :string
  end
end
