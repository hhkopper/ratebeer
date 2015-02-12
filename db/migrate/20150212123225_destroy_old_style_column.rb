class DestroyOldStyleColumn < ActiveRecord::Migration
	def change
		remove_column :beers, :old_style
	end
end
