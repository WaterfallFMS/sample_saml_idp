class IdpController < SamlIdp::IdpController
  def new
    # override the gem provided form
  end

private
  def idp_authenticate(email, password) # not using params intentionally
    User.valid_user(email)
  end

  def idp_make_saml_response(found_user) # not using params intentionally
    encode_response found_user
  end
end