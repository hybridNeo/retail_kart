class Product < ActiveRecord::Base
	validates :product_name, presence: true, uniqueness: {case_sensitive: false}
end
