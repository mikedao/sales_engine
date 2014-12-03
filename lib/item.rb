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
    @created_at  = Date.parse(data[:created_at]).to_s
    @updated_at  = Date.parse(data[:updated_at]).to_s
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
    selected_invoices = invoice_items.map do |invoice_item|
      invoice_item.invoice
    end

    selected_invoices.uniq!

    selected_transactions = selected_invoices.map do |invoice|
      invoice.transactions
    end.flatten

    good_transactions = selected_transactions.select do |transaction|
      transaction.result == "success"
    end

    good_invoices = good_transactions.map do |transaction|
      transaction.invoice
    end

    good_invoice_items = good_invoices.map do |invoice|
      invoice.invoice_items
    end.flatten

    final_invoice_items = good_invoice_items.select do |invoice_item|
      invoice_item.item_id == id
    end

    final = final_invoice_items.map do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end

    final.flatten.flatten.reduce(:+)
  end

  def quantity_sold
    selected_invoices = invoice_items.map do |invoice_item|
      invoice_item.nil? ? [] : invoice_item.invoice
    end

    selected_invoices.uniq!

    selected_transactions = selected_invoices.map do |invoice|
      invoice.transactions
    end.flatten

    good_transactions = selected_transactions.select do |transaction|
      transaction.result == "success"
    end

    good_invoices = good_transactions.map do |transaction|
      transaction.invoice
    end.uniq

    good_invoice_items = good_invoices.map do |invoice|
      invoice.invoice_items
    end.flatten

    final_invoice_items = good_invoice_items.select do |invoice_item|
      invoice_item.item_id == id
    end

    final_invoice_items.flatten.map do |invoice_item|
      invoice_item.quantity
    end.reduce(:+)
  end
end
