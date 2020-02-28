class AddRelationshipColumnToDependentsTable < ActiveRecord::Migration
  def change
    add_column :dependents, :relationship, :string
  end
end
