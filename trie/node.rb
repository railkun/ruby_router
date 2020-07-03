class Node
  DYNAMIC = 1
  STATIC = 0

  attr_reader :value, :children

  attr_accessor :name, :type, :dynamic_value

  def initialize(value)
    @dynamic_value = {}
    @children      = []
    @value         = value
    @name          = ''
    @type          = STATIC
    @type          = DYNAMIC if value[0] == ':'
  end
end
