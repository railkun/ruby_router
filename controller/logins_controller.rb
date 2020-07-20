require_relative '../service/jwt_auth'

class LoginsController

  def initialize(params)
    @params = params
    @logins = {
      Alex:  '1234',
      Steve: '4321',
    }
  end

  def new
    Haml::Engine.new(template(__method__.to_s)).render(binding)
  end

  def create
    username = @params['user_name']
    password = @params['password']

    if @logins[username.to_sym] == password
      JwtAuth.new.token(username)
    else
      'Wrong password or user name'
    end
  end

  private

  def template(action)
    File.read(File.join("views/logins/#{action}.haml"))
  end
end
