class Rsvp < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :guests, :dependent => :destroy
  accepts_nested_attributes_for :guests
  validates_associated :guests

  before_create :assign_guid

  def assign_guid
    self.uuid = Guid.new.to_s
  end

  def to_param
    self.uuid
  end
end
