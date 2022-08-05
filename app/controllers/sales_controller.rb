class SalesController < ApplicationController
  before_action :authenticate_user!
  before_action :init_sale_products
  before_action :load_sale_products_from_session, only: %i[new create]
  before_action :set_sale, only: %i[show edit update destroy sale_details_pdf]

  def index
    @sales = Sale.all
  end

  def show
    prepare_sale_details
  end

  def sale_details_pdf
    prepare_sale_details
    respond_to do |format|
      format.pdf do
        render pdf: "sale_details_#{@sale.id}",
               template: 'sales/partials/_sale_products',
               encoding: 'utf8',
               formats: [:html]
      end
    end
  end

  def new
    @sale = Sale.new
  end

  def search_products
    @query = params[:query]
    @products = Sales::SearchProducts.call(params.merge({ business_id: current_business_id })).products
    respond_to do |format|
      format.html { render partial: 'sales/partials/products_found' }
    end
  end

  def add_product_to_sale
    result = Sales::AddProductToSaleOrganizer.call(params.merge({ session: session }))
    @sale_products = result.sale_products
    @sale_total = result.total

    respond_to do |format|
      format.html { render partial: 'sales/partials/sale_products' }
    end
  end

  def edit; end

  def create
    result = Sales::CreateSaleOrganizer.call({ sale_params: sale_params, session: session })
    @sale = result.sale

    respond_to do |format|
      if result.success?
        format.html { redirect_to sale_url(@sale), notice: 'Sale was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to sale_url(@sale), notice: 'Sale was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sale.destroy

    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Sale was successfully destroyed.' }
    end
  end

  private

  def init_sale_products
    session[:sale_products] ||= []
  end

  def prepare_sale_details
    sale_details = Sales::PrepareSaleDetails.call({ sale: @sale })
    @sale_products = sale_details.sale_products
    @sale_total = sale_details.sale_total
  end

  def load_sale_products_from_session
    @sale_products = Sales::LoadSaleProductsFromSession.call({ session: session }).sale_products
  end

  def set_sale
    @sale = Sale.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(:client)
  end
end
