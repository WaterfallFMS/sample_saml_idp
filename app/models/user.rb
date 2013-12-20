class User
  attr_accessor :email, :first_name, :last_name

  def self.valid_user(email)
    u              = User.new
    u.email        = email
    u.first_name   = email.split('@').first.capitalize
    u.last_name    = 'User'
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
        uuid: '6888dce0-43d1-0131-9c64-482a14030d65',
        name: 'Demo account'
    }.to_json.to_s
  end

  def modules_enabled
    ['account','cms','crm','forum','university',].to_json.to_s
  end
  
  def account_type
    case email
      when 'waterfall-admin@waterfallsoftware.com' then 'waterfall_admin'
      when 'admin@waterfallsoftware.com' then 'admin'
      else 'user'
    end
  end
end