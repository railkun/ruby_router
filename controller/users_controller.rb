require_relative '../service/template'

class UsersController

  include Template

  def initialize(params)
    @params   = params

    @params['token'] ? JwtAuth.decoded_token(@params['token']) : raise_error
  end

  def index
    users

    template.render(binding)
  end

  def show(params)
    user_name = users[params[":id"].to_i - 1]

    template.render(binding)
  end

  def new
    template.render(binding)
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
