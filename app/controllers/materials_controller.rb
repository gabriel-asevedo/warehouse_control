class MaterialsController < ApplicationController

  before_action :set_material, only: [:show, :edit, :update, :destroy, :add, :remove]

  def index
    @q = Material.ransack(params[:q])
    @materials = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
  end

  def show
    @material = Material.find(params[:id])
    @logs = @material.logs.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end

  def new
    @material = Material.new
  end

  def create
    @material = Material.new(material_params)

    if @material.save
      redirect_to materials_path, notice: "Item created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @material = Material.find(params[:id])
  end

  def update
    @material = Material.find(params[:id])

    if @material.update(material_params)
      redirect_to materials_path, notice: "Item updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @material.destroy
      redirect_to materials_path, notice: "Material deleted successfully."
    else
      redirect_to materials_path, alert: @material.errors.full_messages.to_sentence
    end
  end

  def add
    quantity = params[:quantity].to_i
    if quantity > 0
      @material.increment!(:quantity, quantity)
      Log.create(user: current_user, material: @material, quantity: quantity, action_type: 'add')
      redirect_to @material, notice: 'The item quantity has been added successfully.'
    else
      redirect_to @material, alert: 'Quantity must be greater than 0.'
    end
  end

  def remove
    quantity = params[:quantity].to_i
    if quantity <= 0 || @material.quantity < quantity
      redirect_to @material, alert: 'Invalid quantity.'
    elsif @material.valid?
      @material.decrement!(:quantity, quantity)
      Log.create(user: current_user, material: @material, quantity: quantity, action_type: 'remove')
      redirect_to @material, notice: 'The item quantity was successfully withdrawn.'
    else
      redirect_to @material, alert: @material.errors.full_messages.to_sentence
    end
  end


  def set_material
    @material = Material.find(params[:id])
  end

  private
  def material_params
    params.require(:material).permit(:name, :quantity)
  end
end
