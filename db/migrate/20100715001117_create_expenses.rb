class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.column :user_id, :integer
      t.column :expense_number, :integer
      t.column :filename, :string
      t.column :content_type, :string
      t.column :file_data, :binary
      
      t.timestamps
    end
  end

  def self.down
    drop_table :expenses
  end
end
