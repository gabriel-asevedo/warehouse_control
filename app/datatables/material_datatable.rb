class MaterialDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    @view_columns ||= {
      id: { source: 'Material.id' },
      name: { source: 'Material.name', cond: :like, searchable: true },
      quantity: { source: 'Material.quantity', searchable: false }
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        name: record.name,
        quantity: record.quantity
      }
    end
  end

  def get_raw_records
    Material.paginate(page: params[:page], per_page: 10)
  end

end
