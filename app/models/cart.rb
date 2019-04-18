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

    merchant_id = item.merchant_id
    merchant = User.find(merchant_id)
    discounts = merchant.discounts_by_type(merchant.discount_type)
    applicable_discount = discounts.where(kind: 0)[0]

    if applicable_discount && applicable_discount.quantity.include?(count_of(item.id))
    # if merchant_id == applicable_discount.merchant_id
      percent_off = ((100 - applicable_discount.amount_off.to_f)/100)
      ((count_of(item.id) * item.price ) * percent_off) if applicable_discount 
    else
      count_of(item.id) * item.price 
    end 
  end
end
