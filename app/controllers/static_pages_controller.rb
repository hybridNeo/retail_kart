class StaticPagesController < ApplicationController
	before_action :setInv, only: [:inventory]
	def home
		render :layout => false
	end
	def kart
		@path=request.base_url
	end
	def inventory
	end

	private

	def setInv
		if shop_signed_in?
			@inventory=ProductSellers.where(:shopId => current_shop.id)
		else
			@inventory=nil
		end
	end
end
