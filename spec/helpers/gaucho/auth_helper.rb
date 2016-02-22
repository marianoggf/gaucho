module AuthHelper  
  def authWithUser (user, password)
    if user and user.valid_password?(password)
      @client_id = SecureRandom.urlsafe_base64(nil, false)
      @token     = SecureRandom.urlsafe_base64(nil, false)
      @token_bcrypt = BCrypt::Password.create(@token)
      @expiry = (Time.now + DeviseTokenAuth.token_lifespan).to_i
      user.tokens[@client_id] = {
        token: @token_bcrypt,
        expiry: @expiry
      }
      user.sign_in_count = 1
      user.last_sign_in_at = DateTime.now
      user.last_sign_in_ip = '127.0.0.1'
      user.current_sign_in_at = DateTime.now
      user.current_sign_in_ip = '127.0.0.1'
      user.save
      request.headers["HTTP_ACCESS_TOKEN"] = @token
      request.headers["HTTP_TOKEN_TYPE"] = "Bearer"
      request.headers["HTTP_CLIENT"] = @client_id
      request.headers["HTTP_EXPIRY"] = @expiry
      request.headers["HTTP_UID"] = user.uid
    end
  end

  def clearToken
    request.headers["HTTP_ACCESS_TOKEN"] = nil
    request.headers["HTTP_TOKEN_TYPE"] = nil
    request.headers["HTTP_CLIENT"] = nil
    request.headers["HTTP_EXPIRY"] = nil
    request.headers["HTTP_UID"] = nil
  end
end