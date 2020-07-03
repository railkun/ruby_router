class Response

  attr_reader :route, :dynamic_value

  def initialize(route, dynamic_value)
    @dynamic_value = dynamic_value
    @route         = route
  end
end
