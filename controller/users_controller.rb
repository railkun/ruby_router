class UsersController
  def initialize(params)
    @params   = params

    @params['token'] ? decoded_token : raise_error
  end

  def index
    template  = File.read(File.join("views/users/index.haml"))

    users

    Haml::Engine.new(template).render(binding)
  end

  def usersshow(params)
    template  = File.read(File.join("views/users/show.haml"))

    user_name = all_users[params[":id"].to_i - 1]

    Haml::Engine.new(template).render(binding)
  end

  def new
    template  = File.read(File.join("views/users/new.haml"))

    Haml::Engine.new(template).render(binding)
  end

  def create
    add_users(@params['name'])
    index
  end

  def edit(params)
    "Edit user id:#{params[":id"]}"
  end

  def update(params)
    "Update user id:#{params[":id"]}"
  end

  def destroy(params)
    "Delete user id:#{params[":id"]}"
  end

  private

  def decoded_token
    decoded_token = JWT.decode @params['token'], 'my$ecretK3y', true, { algorithm: 'HS256' }

  rescue JWT::DecodeError
    raise Error_401.new 'A token must be passed.'
  rescue JWT::ExpiredSignature
    raise Error_403.new 'The token has expired.'
  rescue JWT::InvalidIssuerError
    raise Error_403.new 'The token does not have a valid issuer.'
  rescue JWT::InvalidIatError
    raise Error_403.new 'The token does not have a valid "issued at" time.'
  end

  def raise_error
    raise Error_401.new 'A token must be passed.'
  end

  def users
    File.read("users.txt").split("\n")
  end

  def add_users(name)
    File.open("users.txt", "a+") do |file|
      file.puts(name)
    end
  end
end
