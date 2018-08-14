# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint(8)        not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("pending")
#

class CatRentalRequest < ApplicationRecord
  belongs_to :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: "Cat"

  before_validation :upcase_status

  validate :overlapping_approved_requests
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }

  def upcase_status
    self.status.upcase!
  end

  def overlapping_approved_requests

    crr = CatRentalRequest.where(cat_id: self.cat_id)
      .where.not("start_date > ? OR ? > end_date", self.end_date, self.start_date)
      .where(status: "APPROVED")
      .where.not(id: self.id)


    unless self.id
      errors[:dates] << 'Overlapping rental request.  Change your dates.' unless crr.empty?
    end

  end

  def overlapping_requests
    crr = CatRentalRequest.where(cat_id: self.cat_id)
      .where.not("start_date > ? OR ? > end_date", self.end_date, self.start_date)
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: "PENDING").where.not(id: self.id)
  end

  def approve!
    crr = CatRentalRequest.where(cat_id: self.cat_id)
      .where.not("start_date > ? OR ? > end_date", self.end_date, self.start_date)
      .where(status: "APPROVED")
      .where.not(id: self.id)

    if crr.empty?
      self.status = "APPROVED"
      self.save
      deny_conflicting_pending_requests
    end
  end

  def deny!
    self.status = "DENIED"
    # debugger
    self.save
  end

  def deny_conflicting_pending_requests
    # debugger
    overlapping_pending_requests.each do |crr|
      crr.deny!
    end
  end
end
