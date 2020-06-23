class Node
  attr_reader   :value, :children

  def initialize(value)
    @value = value
    @children  = []
  end
end
