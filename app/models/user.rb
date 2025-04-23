class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # , :lockable,   and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable, :timeoutable
end
