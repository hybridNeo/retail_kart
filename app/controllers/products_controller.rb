class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_sellers, only: [:show]
  before_action :set_seller, only: [:addProductSeller]
  before_action :set_sel_par, only: [:getSellerCost]
  before_action :set_sel_cur, only: [:show]

  # GET /products
  # GET /products.json
  def index
    if(params['query'] != nil)
      @products = Product.where("lower(product_name) = ?", params['query'].downcase)
      # @products = Product.where(:product_name =>  params['query'])
      # raise 'err'

    else
      @products = Product.all
    end
    
    
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def addProductSeller
    if(@f==0)
      @seller.prodId=params[:id]
      @seller.shopId=current_shop.id
      @seller.unitSize=params[:unitSize]
      @seller.unitCost=params[:unitCost]
      @seller.stockCur=params[:stockCur]
      @seller.save
    else
      @seller.update_attributes(:unitSize => params[:unitSize], :unitCost => params[:unitCost], :stockCur => params[:stockCur])
      @seller.save
    end
  end

  def getSellerCost
    respond_to do |format|
      format.json { render json: @sellers }
    end
  end

  def createReceipt
    prods=params[:prods].split(",")
    shops=params[:shops].split(",")
    counts=params[:counts].split(",")
    recs=[]
    costs=[]
    nId=""
    res="Success"
    totalCost=0
    (0...prods.length).each do |i|
      rec=ProductSellers.find_by(:prodId => prods[i], :shopId => shops[i])
      if rec.stockCur>=counts[i].to_i
        rec.stockCur-=counts[i].to_i
        costs.push counts[i].to_i*rec.unitCost
        totalCost+=counts[i].to_i*rec.unitCost
        recs.push rec
      else
        res="Failure"
        break
      end
    end
    if res=="Success"
      recs.each do |r|
        r.save
      end
      receipt=Transaction.new
      nId=receipt.id
      receipt.totalCost=totalCost
      receipt.shopId=current_shop.id
      receipt.content=params[:prods]+";"+params[:shops]+";"+params[:counts]+";"+costs.join(",")
      receipt.save
    end
    respond_to do |format|
      format.json { render json: {:msg => res, :nId => nId} }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:product_name, :desc, :category, :rating)
    end

    def set_sellers
      @sellers=ProductSellers.where(:prodId => params[:id])
    end

    def set_seller
      @f=1
      @seller=ProductSellers.find_by(:prodId => params[:id], :shopId => current_shop.id)
      if !@seller.present?
        @seller=ProductSellers.new(params.permit(:prodId, :shopId, :unitSize, :unitCost, :stockCur))
        @f=0
      end
      @seller
    end

    def set_sel_cur
      @seller=ProductSellers.find_by(:prodId => params[:id], :shopId => current_shop.id)
    end

    def set_sel_par
      pid=params[:pid].split('_')
      uid=params[:uid].split('_')
      @sellers=[]
      (0...pid.length).each do |i|
        @sellers.push ProductSellers.find_by(:prodId => pid[i], :shopId => uid[i])
      end
    end
end
