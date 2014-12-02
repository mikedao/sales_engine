require 'bigdecimal'

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
    @id          = data[:id].to_i
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = BigDecimal.new(data[:unit_price])/100
    @merchant_id = data[:merchant_id].to_i
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

  def invoices
    invoice_items.map do |invitem|
      invitem.invoice
    end
  end

  def best_day
    matching_transactions = invoices.map do |inv|
      inv.transactions
    end.flatten

    successful_transactions = matching_transactions.select do |trans|
      trans.result == "success"
    end

    successful_invoices = successful_transactions.map do |trans|
      trans.invoice
    end

    succhash = successful_invoices.group_by { |inv| inv.created_at[0..9] }

    result = {}

    succhash.map do |date, invoy|
      invoice_items = invoy.map(&:invoice_items).flatten
      items = invoice_items.select { |inv_item| inv_item.item_id == id }
      result[date] = items.map { |item| item.quantity.to_i }.reduce(:+)

    end

    Date.parse(result.sort_by { |k, v| v }.last.first)

  end

  def revenue
    item_transactions = invoices.map { |inv| inv.transactions }.flatten

    successful_transactions = item_transactions.select do |trans|
      trans.result == 'success'
    end

    successful_invoices = successful_transactions.map do |trans|
      trans.invoice
    end

    successful_invoice_items = successful_invoices.map do |suc_inv|
      suc_inv.invoice_items
    end.flatten

    good_invoice_items = successful_invoice_items.select do |inv|
      inv.item_id == id
    end

    good_invoice_items.map do |inv_item|
      inv_item.revenue
    end.reduce(0, :+)
  end

  def quantity_sold
    unit_price != 0 ? revenue / unit_price : 0
  end
end
