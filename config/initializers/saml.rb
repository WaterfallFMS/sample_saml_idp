SamlIdp.configure do |config|
  base = "http://saml-idp.dev"

  config.x509_certificate = <<-CERT
-----BEGIN CERTIFICATE-----
MIICxzCCAjACCQC0xircGnUAzzANBgkqhkiG9w0BAQUFADCBpzELMAkGA1UEBhMC
VVMxETAPBgNVBAgTCE1hcnlsYW5kMRQwEgYDVQQHEwtHbGVuIEJ1cm5pZTEbMBkG
A1UEChMSV2F0ZXJmYWxsIFNvZnR3YXJlMQswCQYDVQQLEwJJVDEVMBMGA1UEAxMM
Sm9obiBLYW1lbmlrMS4wLAYJKoZIhvcNAQkBFh9qa2FtZW5pa0B3YXRlcmZhbGx3
c29mdHdhcmUuY29tMB4XDTEzMTIwMzIwMjc0OVoXDTQxMDQxOTIwMjc0OVowgacx
CzAJBgNVBAYTAlVTMREwDwYDVQQIEwhNYXJ5bGFuZDEUMBIGA1UEBxMLR2xlbiBC
dXJuaWUxGzAZBgNVBAoTEldhdGVyZmFsbCBTb2Z0d2FyZTELMAkGA1UECxMCSVQx
FTATBgNVBAMTDEpvaG4gS2FtZW5pazEuMCwGCSqGSIb3DQEJARYfamthbWVuaWtA
d2F0ZXJmYWxsd3NvZnR3YXJlLmNvbTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkC
gYEAvm+QYwIbuihkUx7yezKCGqirz6K6S1FujJoRxWFzFLiU71auqUGdfHH+b/Z3
4rJnIdHUWFY2jvtFIlZknyG5kReVtMpNUdmoNBwqG5nS7TpkLzSYzpYRdaNwq97m
7JXMICHSUzQz/mHIZretWblN5A1e6sRQrfDmH5qKL1WPIq0CAwEAATANBgkqhkiG
9w0BAQUFAAOBgQAium4/61wL9zfXepvfLUU54dNtuEqTBmGMwt+DQ3kSNSWSihS8
e4ppQSCoQWCeEVMJRC9tcoPK2r203OUrl9VA8LinNA8JF0C7hzB7Zmnda3Vg0Tl9
S35XFLWzpc16ilGxYhksdhWjikmNsG9/OAyyWW0JTkzUaeU6l4f7GDG4EQ==
-----END CERTIFICATE-----
CERT

  config.secret_key = <<-CERT
-----BEGIN RSA PRIVATE KEY-----
MIICXQIBAAKBgQC+b5BjAhu6KGRTHvJ7MoIaqKvPorpLUW6MmhHFYXMUuJTvVq6p
QZ18cf5v9nfismch0dRYVjaO+0UiVmSfIbmRF5W0yk1R2ag0HCobmdLtOmQvNJjO
lhF1o3Cr3ubslcwgIdJTNDP+Ychmt61ZuU3kDV7qxFCt8OYfmoovVY8irQIDAQAB
AoGBAK3Fa8GMuPRjyzg18xoL+sCMzUqIuOnlgrT2GeU8iSCNVgoX1QVJhIV8F6rf
AoJwPL+VkuiQsvRBwNIWd3bl9Uclem2N3LQuPxJTey6ESM0tZp5rv/DMPG8MAl0T
anppKAAQlEY7RY2Zv8dkrVKd9m6GwQfNNq3jc+yYtBVHdvkBAkEA9B8SY4vJq8D7
FWYDCcedUDOsDnHSFwIOIHwwHEBxJHd7kw4wFckBEzENtHr7hNVIK4aRKWSqapMP
xTh9rHm54QJBAMezwEnkzjWCVKBqEiTN/xNPyd28ocbpjE6uNI35CKRWvDPKDu67
FoPqWO74obUjg2HnFQabhYX1BWtxkZ/9ek0CQG0Ylbc2+WFwVMUzWZg9ROhar0Gl
TCZMHNQXq8h0ZBvP6cHGTWbu9TQGcAGAFHdAeYg6ExVUj3QhVKLmpAM4QwECQFjC
A4zULPKLYqGJg1boV551r/rlg+Gsm7e8pY8USEsCYdOC0vA4JuGqnqxXxUeE6Tfy
RN4S8V2AcVA3wcmiF2ECQQDqn6UWqNynLqOWTvhrefNUI+7JsCw4SjX57U5wEPAx
OyC7DylcE/ur6SHOVMWkPh4bjUWllKvSk4ARAN/+/Hvh
-----END RSA PRIVATE KEY-----
CERT


  config.organization_name = "Waterfall Software Inc."
  config.organization_url = "http://waterfallsoftware.com"
  config.base_saml_location = "#{base}/saml"
  config.single_service_post_location = "#{base}/saml/auth"

  config.technical_contact.company = "Waterfall Software Inc."
  config.technical_contact.given_name = "Support"
  config.technical_contact.sur_name = "User"
  config.technical_contact.telephone = "55555555555"
  config.technical_contact.email_address = "support@waterfallsoftware.com"

  config.attributes = {
    email:            nil,
    first_name:       nil,
    last_name:        nil,
    account_count:    nil,  # if the user is a member of more then one account
    selected_account: nil,  # the info for the current account
    modules_enabled:  nil,
    account_type:     nil
  }

  service_providers = {
    "some-issuer-url.com/saml" => {
      fingerprint: "9E:65:2E:03:06:8D:80:F2:86:C7:6C:77:A1:D9:14:97:0A:4D:F4:4D",
      metadata_url: "http://some-issuer-url.com/saml/metadata"
    },
    'waterfall-saml-client' => {
      #metadata_url: 'http://saml-client.dev/saml/metadata' # testing ruby-saml directly
      metadata_url: 'http://saml-client.dev/auth/saml/metadata' # testing omni-auth-saml
    },
    'ruby-saml-rails3-example' => {
      metadata_url: 'http://ruby-saml-rails3-example.dev/saml/metadata'
    }
  }

  # `identifier` is the entity_id or issuer of the Service Provider,
  # settings is an IncomingMetadata object which has a to_h method that needs to be persisted
  config.service_provider.metadata_persister = ->(identifier, settings) {
    fname = identifier.to_s.gsub(/\/|:/,"_")
    `mkdir -p #{Rails.root.join("cache/saml/metadata")}`
    File.open Rails.root.join("cache/saml/metadata/#{fname}"), "r+b" do |f|
      Marshal.dump settings.to_h, f
    end
  }

  # `identifier` is the entity_id or issuer of the Service Provider,
  # `service_provider` is a ServiceProvider object. Based on the `identifier` or the
  # `service_provider` you should return the settings.to_h from above
  config.service_provider.persisted_metadata_getter = ->(identifier, service_provider){
    fname = identifier.to_s.gsub(/\/|:/,"_")
    `mkdir -p #{Rails.root.join("cache/saml/metadata")}`
    file = Rails.root.join("cache/saml/metadata/#{fname}")

    File.open file, "rb" do |f|
      Marshal.load f
    end if File.exists? file
  }

  # Find ServiceProvider metadata_url and fingerprint based on our settings
  config.service_provider.finder = ->(issuer_or_entity_id) do
    Rails.logger.debug "Auth request from SP #{issuer_or_entity_id}"
    service_providers[issuer_or_entity_id]
  end
end
