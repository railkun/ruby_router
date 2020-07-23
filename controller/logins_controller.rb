require_relative '../service/template'

class LoginsController

  include Template

  def initialize(params)
    @params = params
    @logins = {
      Alex:  '1234',
      Steve: '4321',
    }
  end

  def new
    template.render(binding)
  end

  def create
    username = @params['user_name']
    password = @params['password']

    if @logins[username.to_sym] == password
      JwtAuth.token(username)
    else
      'Wrong password or user name'
    end
  end
end
