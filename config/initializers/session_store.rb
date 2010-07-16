# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_expenses_session',
  :secret      => '8ba9f89b89e94d0a8f542385648d65ac170d17c0c52206764f7826faf517be10b5eb38ddd25f583c983e612ff535f85e1f23c81580c81fa17adeefa9dfcf471e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
