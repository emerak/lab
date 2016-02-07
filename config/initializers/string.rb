require 'openssl'

class String
  def encrypt(key)
    pass_phrase = key
    salt = '8 octets'
    encrypter = OpenSSL::Cipher.new 'AES-128-CBC'
    encrypter.encrypt
    encrypter.pkcs5_keyivgen pass_phrase, salt
    encrypted = encrypter.update self
    encrypted << encrypter.final
    encrypted
  end

  def decrypt(key)
    pass_phrase = key
    salt = '8 octets'
    decrypter = OpenSSL::Cipher.new 'AES-128-CBC'
    decrypter.decrypt
    decrypter.pkcs5_keyivgen pass_phrase, salt
    plain = decrypter.update self
    plain << decrypter.final
  end
end
