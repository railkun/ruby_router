require 'pry'

require_relative 'node'

class Trie
  def initialize
    @root = Node.new("/")
  end

  def add_route(route)
    levels = route.split('/').reject { |e| e.to_s.empty? }
    base   = @root
    levels.each { |level| base = add_attributes(level, base.children) }
    base.name = route
  end

  def add_attributes(value, trie)
    trie.find { |n| n.value == value } || add_node(value, trie)
  end

  def add_node(value, trie)
    Node.new(value).tap do |new_node|
      new_node.type = 'dynamic' if value[0] == ':'
      trie << new_node
    end
  end

  def find_route(route)
    levels = route.split('/').reject { |e| e.to_s.empty? }
    base   = @root
    route_found =
    levels.all? { |level| base = find_attributes(level, base.children) }

    yield route_found, base if block_given?
    base
  end

  def find_attributes(value, trie)
    trie.find { |n| n.value == value }
  end

  def find(route)
    find_route(route) do |found, base|
      return 'This route not exist' unless found && base.name.empty? == false
    end
  end
end
