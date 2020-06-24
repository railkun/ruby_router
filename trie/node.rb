class Node
  attr_reader   :value, :children

  attr_accessor :name, :type

  def initialize(value)
    @value = value
    @name = ''
    @type = 'static'
    @children  = []
  end
end
