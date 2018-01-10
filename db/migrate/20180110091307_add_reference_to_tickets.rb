class AddReferenceToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :reference, :string
  end
end
