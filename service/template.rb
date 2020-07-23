module Template
  def template
    action   = caller[0].split("`").pop.gsub("'", "")

    controller = self.class.to_s.split(/(?=[A-Z])/)[0].downcase

    template = File.read(File.join("views/#{controller}/#{action}.haml"))

    Haml::Engine.new(template)
  end
end
