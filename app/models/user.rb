class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  as_enum :role, :user => 1, :admin => 0
end
