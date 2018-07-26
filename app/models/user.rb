class User < ApplicationRecord
   has_many :posts, dependent: :destroy

  before_save { self.email = email.downcase if email.present? }
  before_save :format_name
  before_save { self.role ||= :member }

  # Could also have done this (below) instead of 'format_name'
  # before_save { self.name = name.downcase.gsub(/\b\w/, &:upcase) if name.present? }

    validates :name, length: { minimum: 1, maximum: 100 }, presence: true
    
    validates :email,
             presence: true,
             uniqueness: { case_sensitive: false },
             length: { minimum: 3, maximum: 254 }

    validates :password, presence: true, length: { minimum: 6 }, if: -> { "password_digest.nil?" }
    validates :password, length: { minimum: 6 }, allow_blank: true

    has_secure_password

    enum role: [:member, :admin]

    def format_name
      if name 
        name_array = []
        name.split.each do |name_part|
          name_array << name_part.capitalize
        end
        self.name = name_array.join(" ")
      end
    end

end
