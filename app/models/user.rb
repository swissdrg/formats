# Object for devise authentication
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  # noinspection RailsParamDefResolve,RailsParamDefResolve
  validates_presence_of :email,:password, :password_confirmation

end
