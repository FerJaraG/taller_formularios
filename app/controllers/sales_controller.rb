class SalesController < ApplicationController
  def new
  	@venta = Sale.new
  end

  def create
  	codigo = Sale.last.cod + 1
  	detalle = params[:sale][:detail]
  	categoria = params[:sale][:category]
  	descuento = params[:sale][:discount].to_i
  	valor = params[:sale][:value].to_f 
  	iva = (params[:sale][:tax] == '1')
  	total = 0

  	total = valor * (1 - descuento / 100.0)
  	
  	sale = Sale.new

  	if !iva
  		sale.tax = 19
  		total *= 1.19
  	else
  		sale.tax = 0
  	end

  	sale.discount = descuento
  	sale.value = valor 
  	sale.total = total
	sale.category = categoria
	sale.cod = codigo 
	sale.detail = detalle

	
  	#Sale.create(cod: codigo, detail: detalle, category: categoria, value: valor, discount: descuento, tax: iva, total: total  )
  	
  	if sale.save
  		redirect_to sales_done_path, notice: 'El registro fue guardado con exito' 
  	else
  		redirect_to root_path, notice: 'El registro falló :(' #sale.errors
  	end


  end

  def done
  	@sale = Sale.last
  end
end
