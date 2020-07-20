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
      token(username)
    else
      'Wrong password or user name'
    end
  end

  private

  def token(username)
    JWT.encode payload(username), 'my$ecretK3y', 'HS256'
  end

  def payload(username)
    {
      exp: Time.now.to_i + 60 * 60,
      iat: Time.now.to_i,
      user: {
        username: username
      }
    }
  end

  def template(action)
    File.read(File.join("views/logins/#{action}.haml"))
  end
end
