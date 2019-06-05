class Address < ApplicationRecord
  #validations
    validates_presence_of :street, :city, :state, :zip, :nickname

  #relationships
    belongs_to :user
    has_many :orders, dependent: :destroy

  #helper_methods
  def restricted?
    !orders.where(status: "pending").any? if orders != []
  end
end
