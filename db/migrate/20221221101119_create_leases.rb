class CreateLeases < ActiveRecord::Migration[6.1]
  def change
    create_table :leases do |t|
      t.integer "rent"
      t.belongs_to :tenant
      t.belongs_to :apartment
      t.timestamps
    end
  end
end
