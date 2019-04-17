class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
    @contents.default = 0
  end

  def total_item_count
    @contents.values.sum
  end

  def add_item(item_id)
    @contents[item_id.to_s] += 1
  end

  def remove_item(item_id)
    @contents[item_id.to_s] -= 1
    @contents.delete(item_id.to_s) if count_of(item_id) == 0
  end

  def count_of(item_id)
    @contents[item_id.to_s]
  end

  def items
    @items ||= load_items
  end

  def load_items
    @contents.map do |item_id, quantity|
      item = Item.find(item_id)
      [item, quantity]
    end.to_h
  end

  def total
    items.sum do |item, quantity|
      item.price * quantity
    end
  end

  def subtotal(item)
    original_subtotal = count_of(item.id) * item.price
    merchant = item.user
    discounts = merchant.discounts_by_type(merchant.discount_type)
    if merchant.discount_type == 0
      applicable_discount = discounts.find do |discount|
        discount.quantity.include?(count_of(item.id))
      end 
      percent_off = ((100 - applicable_discount.amount_off.to_f)/100)
      ((original_subtotal) * percent_off) if applicable discount 
    elsif merchant.discount_type == 1
      applicable_discount = discounts.find do |discount|
        discount.item_total > count_of(item.id)
      end
      (original_subtotal - applicable_discount.amount_off) if applicable_discount
    elsif merchant.discount_type == 2
      original_subtotal
    end 
  end
end
