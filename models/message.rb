require 'securerandom'

class Message < ActiveRecord::Base
  self.primary_key = :key

  before_create :create_key

  private

  def create_key
    new_key = nil
    new_key = SecureRandom.hex(8) while new_key.nil? || Message.exists?(new_key)
    binding.pry
    self.key = new_key
  end
end
