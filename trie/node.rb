class Node
  attr_reader   :value, :children

  attr_accessor :name

  def initialize(value)
    @value = value
    @name = ''
    @children  = []
  end
end
