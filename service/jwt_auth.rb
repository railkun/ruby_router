class JwtAuth
  def token(username)
    JWT.encode payload(username), ENV['JWT_SECRET'], 'HS256'
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

  def decoded_token(token)
    decoded_token = JWT.decode token, ENV['JWT_SECRET'], true, { algorithm: 'HS256' }

  rescue JWT::DecodeError
    raise Error_401.new 'A token must be passed.'
  rescue JWT::ExpiredSignature
    raise Error_403.new 'The token has expired.'
  rescue JWT::InvalidIssuerError
    raise Error_403.new 'The token does not have a valid issuer.'
  rescue JWT::InvalidIatError
    raise Error_403.new 'The token does not have a valid "issued at" time.'
  end
end
