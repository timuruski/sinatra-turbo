class Item < Sequel::Model
  def dom_id
    "item_#{id}"
  end
end
