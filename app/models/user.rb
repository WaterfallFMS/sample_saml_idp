class User
  attr_accessor :email, :first_name, :last_name

  def self.valid_user
    u            = User.new
    u.email      = 'user@example.com'
    u.first_name = 'Test'
    u.last_name  = 'User'
    u
  end

  def valid_password?(password)
    true
  end

  def persistent
    #@persistent ||= UUID.generate
    email
  end

  def account_count
    # I am a member of 3 different accounts
    3
  end

  def selected_account
    {
        id:   4,
        name: 'Demo account'
    }.to_json.to_s
  end

  def modules_enabled
    ['cms','crm','university','login'].to_json.to_s
  end
end