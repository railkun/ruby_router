require 'pry'

require_relative 'node'

class Trie
  def initialize
    @root = Node.new("/")
  end

  def add_route(route)
    levels = route.split('/').reject { |e| e.to_s.empty? }
    base    = @root
    levels.each { |level| base = add_attributes(level, base.children) }
    base.name = route
  end

  def add_attributes(attributes, trie)
    trie.find { |n| n.value == attributes } || add_node(attributes, trie)
  end

  def add_node(attributes, trie)
    Node.new(attributes).tap do |new_node|
      new_node.type = 'dynamic' if attributes[0] == ':'
      trie << new_node
    end
  end
end
