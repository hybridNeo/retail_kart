class StaticPagesController < ApplicationController
	before_action :setInv, only: [:inventory]
	before_action :setProds, only: [:review]

	def home
		render :layout => false
	end
	def kart
		@path=request.base_url
	end
	def inventory
	end
	def review
	end
	def setReviews
		ids=params[:ids].split "_"
		ratings=params[:ratings].split "_"
		contents=params[:contents].split "_"
		uid=current_shop.id
		(0...ids.length).each do |i|
			if Review.exists?(:pid => ids[i].to_i, :uid => uid)
				tmp=Product.find_by(:id => ids[i].to_i)
				val=Review.find_by(:uid => uid, :pid => ids[i].to_i)
				tmp.rating=(tmp.rating*tmp.rCount.to_i-val.rating+ratings[i].to_i)/(tmp.rCount)
				tmp.save
				val.rating=ratings[i]
				val.content=contents[i]
				val.save
			else
				tmp=Review.new
				tmp.uid=uid
				tmp.pid=ids[i]
				tmp.rating=ratings[i]
				tmp.content=contents[i]
				tmp.save
				tmp=Product.find_by(:id => ids[i].to_i)
				if(tmp.rCount==nil or tmp.rCount=="")
					tmp.rating=ratings[i]
					tmp.rCount=1
				else
					tmp.rating=(tmp.rating*tmp.rCount+ratings[i].to_i)/(tmp.rCount+1)
					tmp.rCount+=1
				end
				tmp.save
			end
		end
	end

	private

	def setInv
		if shop_signed_in?
			@inventory=ProductSellers.where(:shopId => current_shop.id)
		else
			@inventory=nil
		end
	end
	def setProds
		prLst=params[:lst].split "_"
		@products=[]
		prLst.each do |pr|
			@products.push Product.find_by(:id => pr)
		end
	end
end
