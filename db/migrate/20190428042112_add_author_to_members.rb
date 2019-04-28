class AddAuthorToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :user_is_author, :boolean, default: false
  end
end
