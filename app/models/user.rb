class User
  attr_accessor :email

  def self.by_email(email)
    u = User.new
    u.email = email
    [u]
  end

  def valid_password?(password)
    true
  end

  def persistent
    #@persistent ||= UUID.generate
    email
  end
end