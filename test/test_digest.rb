#! /usr/bin/env ruby

require ::File.expand_path('../../config/environment',  __FILE__)

class User
  attr_accessor :email

  def initialize
    @email = 'you@example.com'
  end

  def persistent
    # fake a UUID
    '43010c00-3f22-0131-9c01-482a14030d65'
  end
end

response_id       = 'be0f5e70-3e8e-0131-5e32-482a14030d65'
in_response_to_id = 'b78b0cf0-3e8e-0131-5e31-482a14030d65'
issuer            = 'http://ruby-saml-idp-rails3-example.dev/saml/auth'
principal         = User.new
audience          = 'http://ruby-saml-to-example-idp.dev/'
recipient         = 'http://ruby-saml-to-example-idp.dev/saml/consume'
algorithm         = 'sha1'

class SamlIdp::AssertionBuilder
  public :digest, :fresh

  def now
    # force set a constanst time
    @now = Time.parse('2013-12-03T21:21:05Z').utc
  end

  def digest
    p '-'*20
    # Make it check for inclusive at some point (https://github.com/onelogin/ruby-saml/blob/master/lib/xml_security.rb#L159)
    inclusive_namespaces = []
    # Also make customizable
    canon_algorithm = Nokogiri::XML::XML_C14N_EXCLUSIVE_1_0
    canon_hashed_element = noko_raw.canonicalize(canon_algorithm, inclusive_namespaces)
    digest_algorithm = get_algorithm

    p hash                          = digest_algorithm.digest(canon_hashed_element)
    Base64.encode64(hash).gsub(/\n/, '')
  end
end

assertion = SamlIdp::AssertionBuilder.new response_id, issuer, principal, audience, in_response_to_id, recipient, algorithm
digest    = Base64.encode64(OpenSSL::Digest::SHA1.digest(assertion.fresh)).gsub(/\n/, '')

p assertion.fresh
p "Digest:                  #{digest}"
p "AssertionBuilder.digest: #{assertion.digest}"

# ---- Test our XMLSecurity code -----
#p '-'*20
#DSIG = "http://www.w3.org/2000/09/xmldsig#"
#signed        = assertion.signed
#document      = Nokogiri.parse(signed)
#@working_copy ||= REXML::Document.new(signed).root
#inclusive_namespaces = []
#
#@sig_element ||= begin
#  element = REXML::XPath.first(@working_copy, "//ds:Signature", {"ds"=>DSIG})
#  element.remove
#end
#
#
#verify signature
#def canon_algorithm(element)
#  p algorithm = element.attribute('Algorithm').value if element
#  case algorithm
#    when "http://www.w3.org/2001/10/xml-exc-c14n#"         then Nokogiri::XML::XML_C14N_EXCLUSIVE_1_0
#    when "http://www.w3.org/TR/2001/REC-xml-c14n-20010315" then Nokogiri::XML::XML_C14N_1_0
#    when "http://www.w3.org/2006/12/xml-c14n11"            then Nokogiri::XML::XML_C14N_1_1
#    else                                                        Nokogiri::XML::XML_C14N_EXCLUSIVE_1_0
#  end
#end
#def algorithm(element)
#  algorithm = element.attribute("Algorithm").value if element
#  algorithm = algorithm && algorithm =~ /sha(.*?)$/i && $1.to_i
#  case algorithm
#  when 256 then OpenSSL::Digest::SHA256
#  when 384 then OpenSSL::Digest::SHA384
#  when 512 then OpenSSL::Digest::SHA512
#  else
#    OpenSSL::Digest::SHA1
#  end
#end
#
#signed_info_element     = REXML::XPath.first(@sig_element, "//ds:SignedInfo", {"ds"=>DSIG})
#noko_sig_element          = document.at_xpath('//ds:Signature', 'ds' => DSIG)
#noko_signed_info_element  = noko_sig_element.at_xpath('./ds:SignedInfo', 'ds' => DSIG)
#canon_algorithm = canon_algorithm REXML::XPath.first(@sig_element, '//ds:CanonicalizationMethod', 'ds' => DSIG)
#canon_string = noko_signed_info_element.canonicalize(canon_algorithm)
#noko_sig_element.remove
#
# check digests
#REXML::XPath.each(@sig_element, "//ds:Reference", {"ds"=>DSIG}) do |ref|
#  uri                           = ref.attributes.get_attribute("URI").value
#
#  hashed_element                = document.at_xpath("//*[@ID='#{uri[1..-1]}']")
#  canon_algorithm               = canon_algorithm REXML::XPath.first(ref, '//ds:CanonicalizationMethod', 'ds' => DSIG)
#  canon_hashed_element          = hashed_element.canonicalize(canon_algorithm, inclusive_namespaces)
#
#  digest_algorithm              = algorithm(REXML::XPath.first(ref, "//ds:DigestMethod"))
#
#  p hash                          = digest_algorithm.digest(canon_hashed_element)
#  p digest_value                  = Base64.decode64(REXML::XPath.first(ref, "//ds:DigestValue", {"ds"=>DSIG}).text)
#
#  unless hash == digest_value
#    raise Onelogin::Saml::ValidationError.new("Digest mismatch")
#  end
#end

# ----- Test ruby-saml code ----
signed   = assertion.signed
document = REXML::Document.new(signed)

inclusive_namespaces            = []
inclusive_namespace_element     = REXML::XPath.first(document, "//ec:InclusiveNamespaces")

if inclusive_namespace_element
  prefix_list                   = inclusive_namespace_element.attributes.get_attribute('PrefixList').value
  inclusive_namespaces          = prefix_list.split(" ")
end

sig_element = REXML::XPath.first(document, "//ds:Signature", {"ds"=>"http://www.w3.org/2000/09/xmldsig#"})
sig_element.remove

# check digests
require "xmlcanonicalizer"
REXML::XPath.each(sig_element, "//ds:Reference", {"ds"=>"http://www.w3.org/2000/09/xmldsig#"}) do |ref|
  uri                           = ref.attributes.get_attribute("URI").value
  hashed_element                = REXML::XPath.first(document, "//[@ID='#{uri[1,uri.size]}']")
  canoner                       = Nokogiri::XML::Util::XmlCanonicalizer.new(false, true)
  canoner.inclusive_namespaces  = inclusive_namespaces if canoner.respond_to?(:inclusive_namespaces) && !inclusive_namespaces.empty?
  canon_hashed_element          = canoner.canonicalize(hashed_element).gsub('&', '&amp;')
  hash                          = Base64.encode64(Digest::SHA1.digest(canon_hashed_element)).chomp
  digest_value                  = REXML::XPath.first(ref, "//ds:DigestValue", {"ds"=>"http://www.w3.org/2000/09/xmldsig#"}).text

  unless hash == digest_value
    raise Onelogin::Saml::ValidationError.new("Digest mismatch")
  end
end