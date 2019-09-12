class User < ApplicationRecord
  after_create :welcome_send
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :phone_number,
            format: { with: /\A((\+)33|0)[1-9](\d{2}){4}\Z/ },
            allow_blank: true


  belongs_to :city, optional: true
  has_many :full_simulations, dependent: :destroy

  def has_city
    city_id.nil? || city_id.zero? ? false : true
  end
  private

  def welcome_send
    UserMailer.welcome_email(self).deliver.now
  end
end
