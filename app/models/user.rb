class User
  attr_accessor :email, :name

  def self.valid_user(email)
    u        = User.new
    u.email  = email
    u.name   = email.split('@').first.capitalize
    u
  end

  def valid_password?(password)
    true
  end

  ##### IMPORTANT SAML BEHAVIOR #####

  # returns the email address
  def persistent
    email
  end

  # returns a count of the number of account the user is a member of
  #
  # this can be used by an SP to show a link to allow the user to jump accounts
  def account_count
    3
  end

  # returns a hash of the currently selected account
  # MUST include
  #  uuid: a globally unique ID for the account
  #  name: the name of the account
  def selected_account
    {
        uuid: '6888dce0-43d1-0131-9c64-482a14030d65',
        name: 'Demo account'
    }.to_json.to_s
  end

  # returns an array of the modules that a user was given access to
  #
  # this is used by an SP to reject a login attempt from a user that does not
  # have access to the module
  def modules_enabled
    ['account','cms','crm','forum','university',].to_json.to_s
  end
  

  # returns of the user is the account owner: "superadmin"
  def is_account_owner
    # only waterfall-admin
    email == 'waterfall-admin@waterfallsoftware.com'
  end
  
  # return a hash of permissions
  def permissions
    # super admins do not need account access
    return {}.to_json.to_s if is_account_owner
    
    everyone = {
      'Forum' => %w(index show),
      'Topic' => %w(index show create),
      'Post'  => %w(index show create update destroy)
    }
    
    if email == 'admin@waterfallsoftware.com'
      everyone['Forum'].concat %w(create update destroy)
      everyone['Topic'].concat %w(update destroy)
    end
    
    everyone.to_json.to_s
  end
  
  def uda
    uda = {
      'key' => 'value'
    }
    uda.to_json.to_s
  end
end