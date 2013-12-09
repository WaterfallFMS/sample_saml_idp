# SAML IdP

This is a simple reference implementation of a SAML IdP.

## Setup

### 1. Change the valid user

Modify `User.valid_user` to build the user that is to be auto-logged in.

### 2. Add the SP to the IdP config

Update the `config/initializers/saml.rb` file to include your SP (if it isn't already configured).

You may need to configure other settings like `base` depending on your setup.

### 3. Configure your SP

1. Target URL:   http://<saml-idp.dev>/saml/auth
2. Fingerprint:  74:51:A0:EE:40:A5:B3:D9:6F:1C:23:8D:59:04:81:8A:4B:12:F5:FF
3. Name formate: urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress