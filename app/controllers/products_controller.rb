class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_sellers, only: [:show]
  before_action :set_seller, only: [:addProductSeller]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
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
end
