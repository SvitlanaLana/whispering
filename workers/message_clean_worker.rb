class MessageCleanWorker
  include Sidekiq::Worker

  def perform(message_id)
    Message.destroy(message_id)
  end
end
