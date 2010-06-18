# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_quickdownload_session',
  :secret      => 'f336b44fc47547fdc76912906ec6e7335268e53e1af359e22dde60b81ff664b8a570aa3dcfc000e42dedd9be85ea6337a05d0b5c84cd67e4354010c5737d43fe'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
