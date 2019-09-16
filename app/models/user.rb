# frozen_string_literal: true

class User < ApplicationRecord
  after_create :welcome_send
  before_destroy :goodbye_send
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :phone_number,
            format: { with: /\A((\+)33|0)[1-9](\d{2}){4}\Z/ },
            allow_blank: true

  belongs_to :city, optional: true
  has_many :full_simulations, dependent: :destroy
  has_one :gas_simulation

  def city?
    city_id.nil? || city_id.zero? ? false : true
  end

  def last_admin?
    is_admin && User.select{ |user| user.is_admin == true }.count == 1
  end

  private

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def goodbye_send
    UserMailer.goodbye_email(self).deliver_now
  end
end
