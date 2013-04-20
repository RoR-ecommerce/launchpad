module Devise
  module PasswordMigration

    def valid_password?(password)
      if with_authlogic_validation?
        migrate_password!(password)
      else
        super
      end
    end

    private

    def with_authlogic_validation?
      self.old_password_salt.present? && self.old_crypted_password.present?
    end

    def migrate_password!(password)
      Devise.secure_compare(authlogic_password_digest(password), self.old_crypted_password).tap do |validated|
        if validated
          self.password             = password
          self.old_crypted_password = nil
          self.old_password_salt    = nil
          self.save
        end
      end
    end

    def authlogic_password_digest(password)
      stretches = 20
      digest  = [password, self.old_password_salt].flatten.join('')
      stretches.times { digest = Digest::SHA512.hexdigest(digest) }
      digest
    end
  end
end
