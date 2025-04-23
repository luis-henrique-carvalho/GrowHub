# frozen_string_literal: true

User.find_or_create_by!(email: 't@t.com') do |user|
  user.password = '123456'
  user.full_name = 'Teste'
end
