ApiCore.configure do |config|
  config.organization = 'UMICO inc.'
  config.delivered_at = Time.current

  config.jwt_validation = ENV.fetch('JWT_VALIDATION') { false }
  config.jwt_algo = ENV.fetch('JWT_ALGO') { 'HS256' }
  config.jwt_secret = ENV.fetch('JWT_SECRET') { nil }
  config.jwt_public_key = ENV.fetch('JWT_PUBLIC_KEY') { nil }
  config.jwt_private_key = ENV.fetch('JWT_PRIVATE_KEY') { nil }
  config.jwt_password = ENV.fetch('JWT_PASSWORD') { nil }
end
