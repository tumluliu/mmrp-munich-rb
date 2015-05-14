# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_multimodalrouting_session',
  :secret      => '5e3b8dae269e25ae184f0417268b7590dc10671e9303d9e395d5af5ce82c111060cab8008432bef3a8615087dec268ab6a1539e9e17e904caf0509d34ccfeb1b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
