class ::SamlIdpController < SamlIdp::IdpController
private
  def idp_authenticate(email, password) # not using params intentionally
    logger.debug '-'*80
    logger.debug 'idp_authenticate'
    logger.debug email.inspect
    logger.debug password.inspect

    user = User.by_email(email).first
    user && user.valid_password?(password) ? user : nil
  end

  def idp_make_saml_response(found_user) # not using params intentionally
    logger.debug '-'*80
    logger.debug 'ipd_make_saml'
    logger.debug found_user.inspect
    
    encode_response found_user
  end
end