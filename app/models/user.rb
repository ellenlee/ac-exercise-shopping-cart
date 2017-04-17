class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :generate_authentication_token
  before_save :ensure_authentication_token

  has_many :orders

  def admin?
    self.role == "admin"
  end

  def generate_authentication_token
     self.authentication_token = Devise.friendly_token
  end

  protected

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

end
