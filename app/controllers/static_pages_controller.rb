class StaticPagesController < ApplicationController
	def home
		render :layout => false
	end
	def kart
		@path=request.base_url
	end
end
