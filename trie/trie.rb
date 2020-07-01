require 'pry'

require_relative 'node'

class Trie
  def initialize
    @root = Node.new("/")
    @dynamic_value = {}
  end

  def levels_split(route)
    route.split('/').reject { |e| e.to_s.empty? }
  end

  def add_route(route)
    levels = levels_split(route)
    base   = @root
    levels.each { |level| base = add_attributes(level, base.children) }
    base.name = route
  end

  def add_attributes(value, trie)
    trie.find {|n| n.value == value} || add_node(value, trie)
  end

  def add_node(value, trie)
    Node.new(value).tap { |new_node| trie << new_node }
  end

  def find_route(route)
    levels = levels_split(route)
    base   = @root
    route_found = levels.all? { |level| base = find_attributes(level, base.children) }

    yield route_found, base if block_given?
    base.dynamic_value = @dynamic_value
    @dynamic_value = {}
    base
  end

  def find_attributes(value, trie)
    trie.sort_by{ |n| n.type }.find do |n|
      if n.type == Node::DYNAMIC
        @dynamic_value[n.value] = value
        true
      else
        n.value == value
      end
    end
  end

  def find(route)
    find_route(route) do |found, base|
      return 'This route not exist' unless found && base.name.empty? == false
    end
  end
end
