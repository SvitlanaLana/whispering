# whispering
This Ruby test task from Kottans
# whispering

Used: Sinatra, Rspec, Sidekiq, Sqlite (for development), Postgresql (for production).

User should be able to choose destruction option:

- destroy message after the first link visit.

- destroy after 1 hour.

Bonus points for implementing:

- message should be encrypted on frontend side using password and should be sent to backend in encrypted format (to view message user should enter a right password).

- self-destruction of messages after given number of link visits or after given number of hours.

All the messages stored on the server side should be encrypted using AES algorithm.

- Here is link my application to Heroku: https://whisperring.herokuapp.com/
