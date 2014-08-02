# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_books_session',
  :secret      => 'a205ede522d4532e7842e7f2ed4e009211396eaec1922d5077d7ab7bea772e5d2d4fc04e84f51e41e4de57ca05618fafe323630edae468cf3951dcfb20020512'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
