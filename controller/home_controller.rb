require 'haml'

class HomeController
  def index
    template = File.read(File.join("views/home/index.haml"))

    Haml::Engine.new(template).render(binding)
  end
end
