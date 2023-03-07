class ChangeEndUsersToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_table :end_users, :users
  end
end
