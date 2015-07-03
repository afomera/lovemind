class AddPhoneNumberToResources < ActiveRecord::Migration
  def change
    add_column :resources, :phone_number, :string
  end
end
