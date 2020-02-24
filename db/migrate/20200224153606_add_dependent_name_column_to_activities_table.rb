class AddDependentNameColumnToActivitiesTable < ActiveRecord::Migration
  def change
    add_column :activities, :dependent_name, :string
  end
end
