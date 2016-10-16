require 'spec_helper'

RSpec.describe Message do
  let(:count_message) { Message.create(text: 'some text', left_shows: 2) }
  let(:time_message) { Message.create(text: 'some text', deadline: 2) }

  describe 'fetch' do
    it 'decrease number if allowed visits' do
      expect { Message.fetch(count_message.key) }.to change { count_message.reload.left_shows }.by(-1)
    end

    it 'do nothing if chose time deadline' do
      expect { Message.fetch(time_message.key) }.not_to change { time_message.reload.left_shows }
    end
  end

  describe 'launch_worker' do
    it 'launch worker for time messages' do
      expect(MessageCleanWorker).to receive(:perform_in)
      Message.new(text: 'asd', deadline: 1).send(:launch_worker)
    end

    it 'does not launch worker for count messages' do
      expect(MessageCleanWorker).not_to receive(:perform_in)
      Message.new(text: 'asd', left_shows: 1).send(:launch_worker)
    end
  end

  describe 'delete_if_expired' do
    it 'destroy expired message' do
      expect(count_message).to receive(:destroy)
      count_message.left_shows = 0
      count_message.send(:delete_if_expired)
    end
  end

  describe 'validate_expiration' do
    it 'adds error if both deadline type is less then 1' do
      message = Message.new
      message.send(:validate_expiration)
      expect(message.errors).not_to be_empty
    end
  end
end
