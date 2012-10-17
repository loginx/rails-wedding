class Guest < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :rsvp

  validates_presence_of :email
  validates_format_of :email, :with => RFC822::EMAIL
  validates :attending, :inclusion => { :in => [true, false] }
  validates_presence_of :name

end
