class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :destroy]
  before_filter :authenticate_shop!
  respond_to :html

  def index
    @transactions = Transaction.where(:shopId => current_shop.id)
    respond_with(@transactions)
  end

  def show
    details=@transaction.content.split(";")
    @prods=details[0].split(",")
    @shops=details[1].split(",")
    @counts=details[2].split(",")
    @costs=details[3].split(",")
    respond_with(@transaction, @prods, @shops, @counts, @costs)
  end

  def destroy
    @transaction.destroy
    respond_with(@transaction)
  end

  private
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def transaction_params
      params.require(:transaction).permit(:shopId, :content, :totalCost, :dueDate)
    end
end
