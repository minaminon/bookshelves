class AddCodeToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :code, :string
  end
end
