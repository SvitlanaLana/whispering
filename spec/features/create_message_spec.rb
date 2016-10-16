require 'spec_helper'

RSpec.describe 'create message spec', js: true do
  it 'create message with encrypted text' do
    visit '/'
    fill_in 'message_text', with: 'some message'
    fill_in 'message_password', with: 'pass'
    click_button 'save'
    expect(page).to have_content('Link to your message')
    expect(Message.last.text).not_to eq('some message')
  end
end
