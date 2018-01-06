user = User.find_or_create_by(email: 'test@example.com').tap do |user|
  user.password = 'password'
  user.confirmed_at = Time.current
  user.save!
end

user.domains.create!(name: 'test.com')

Detail.new.create(
  first_name: 'Kristiyan',
  last_name: 'Tsvetanov',
  organization: 'Moonhythe',
  job_title: 'CEO',
  email: 'kris@example.com',
  phone: '0812345678',
  address1: 'Svobada str.',
  city: 'Sofia',
  user: user
)
