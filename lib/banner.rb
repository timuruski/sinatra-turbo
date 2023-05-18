class Banner < Struct.new(:id)
  DB = {
    "123" => Banner.new(id: "123"),
    "234" => Banner.new(id: "234"),
    "345" => Banner.new(id: "345")
  }

  def self.find(id)
    DB.fetch(id)
  end

  def self.all(&block)
    DB.values
  end

  def timestamp
    Time.now.strftime("%r")
  end

  def dom_id
    "banner_#{id}"
  end
end
