require 'digest/md5'

def gravatar_hash(email)
  email = email.strip.downcase
  return Digest::MD5.hexdigest(email)
end