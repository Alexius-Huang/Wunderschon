class OrderItem < ApplicationRecord
  acts_as_paranoid
  belongs_to :order
  belongs_to :product

  validates :quantity, :price, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :price,    numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def total_price
    quantity * price
  end

  def increase(increase_quantity = 1)
    raise_negative_or_zero_quantity_error if increase_quantity < 1
    self.quantity += increase_quantity
  end

  def increase!(increase_quantity = 1)
    raise_negative_or_zero_quantity_error if increase_quantity < 1
    raise_record_already_deleted_error    if self.deleted?
    increase increase_quantity
    self.save!
  end

  def decrease(decrease_quantity = 1)
    raise_negative_or_zero_quantity_error if decrease_quantity < 1
    self.quantity -= decrease_quantity
  end

  def decrease!(decrease_quantity = 1)
    raise_negative_or_zero_quantity_error if decrease_quantity < 1
    raise_record_already_deleted_error    if self.deleted?
    if self.quantity == decrease_quantity
      self.destroy!
    else
      decrease decrease_quantity
      self.save!
    end
  end

  private

  def raise_record_already_deleted_error
    raise ActiveRecord::Rollback, 'record already being deleted'
  end

  def raise_negative_or_zero_quantity_error
    raise ActiveRecord::Rollback, 'should pass in quantity larger than zero'
  end
end
