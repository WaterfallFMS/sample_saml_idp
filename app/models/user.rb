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