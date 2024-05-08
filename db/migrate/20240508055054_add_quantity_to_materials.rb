class AddQuantityToMaterials < ActiveRecord::Migration[7.1]
  def change
    add_column :materials, :quantity, :integer
  end
end
