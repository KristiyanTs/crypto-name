user = User.find_or_create_by(email: 'test@example.com').tap do |user|
  user.password = 'password'
  user.confirmed_at = Time.current
  user.save!
end

user.domains.create!(name: 'test.com')
