require 'haml'

class HomeController

  def initialize(params)
    @params  = params
  end

  def index
    template = File.read(File.join("views/home/index.haml"))

    Haml::Engine.new(template).render(binding)
  end
end
