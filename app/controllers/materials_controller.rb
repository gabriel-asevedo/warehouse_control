class MaterialsController < ApplicationController

  def index
    @materials = Material.paginate(page: params[:page], per_page: 10)
  end

  def new
    @material = Material.new
  end

  def create
    @material = Material.new(material_params)

    if @material.save
      redirect_to materials_path, notice: "Item created successfully!"
    else
      render: :new :unprocessable_entity
    end
  end

  def edit
    @material = Material.find(params[:id])

  def update
    @material = Material.find(params[:id])

    if @material.update(material_params)
      redirect_to materials_path, notice: "Item updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @material = Material.find(params[:id])
    @material.destroy

    redirect_to materials_path, notice: "item deleted successfully!"
  end

  private
  def material_params
    params.require(:material).permit(:name)
  end
end
