require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe 'validations' do
    it { should validate_presence_of :amount_off }
    it { should validate_numericality_of(:amount_off).only_integer }
    it { should validate_numericality_of(:amount_off).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of :min_subtotal_required }
    it { should validate_numericality_of(:min_subtotal_required).only_integer }
    it { should validate_numericality_of(:min_subtotal_required).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of :quantity }
  end 

  describe 'relationships' do
    it { should belong_to :user }
  end 
end 