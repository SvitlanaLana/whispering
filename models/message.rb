require 'securerandom'

class Message < ActiveRecord::Base
  self.primary_key = :key

  before_create :create_key, :validate_expiration
  after_save :delete_if_expired
  after_create :launch_worker

  def self.fetch(id)
    message = Message.where(key: id).first
    return unless message
    return message if message.time_deadline?
    message.left_shows -= 1
    message.save
    message
  end

  def count_deadline?
    deadline == -1
  end

  def time_deadline?
    left_shows == -1
  end

  private

  def launch_worker
    return if count_deadline?
    MessageCleanWorker.perform_in(deadline.hours, key)
  end

  def delete_if_expired
    return if time_deadline? || left_shows > 0
    destroy
  end

  def validate_expiration
    if left_shows < 1 && deadline < 1
      errors[:deadline] = 'Cant both expiration type be turned off'
    end
  end

  def create_key
    new_key = nil
    new_key = SecureRandom.hex(12) while new_key.nil? || Message.exists?(new_key)
    self.key = new_key
  end
end
