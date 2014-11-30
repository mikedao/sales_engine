class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, parent)
    @id          = data[:id]
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = data[:unit_price]
    @merchant_id = data[:merchant_id]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @repository  = parent
  end

  def invoice_items
    repository.find_invoice_items(id)
  end

  def merchant
    repository.find_merchant(merchant_id)
  end

  def best_day
    matching_invoices = invoice_items.map do |invitem|
      invitem.invoice
    end

    matching_transactions = matching_invoices.map do |inv|
      inv.transactions
    end.flatten

    successful_transactions = matching_transactions.select do |trans|
      trans.result == "success"
    end

    successful_invoices = successful_transactions.map do |trans|
      trans.invoice
    end

    succhash = successful_invoices.group_by { |inv| inv.created_at[0..10] }

    succhash.map do |date, invoy|
      succhash[date] = invoy.map do |invoy|
        invoy.invoice_items
      end.flatten.select do |inv_item|
        inv_item.item_id == id
      end.map do |good_inv_item|
        good_inv_item.quantity.to_i
      end.reduce(:+)
    end

    succhash.each do |key, value|
    end

    maximum = ""
    succhash.each { |k, v| maximum = k if v == succhash.values.max }
    maximum
  end
end
