FactoryBot.define do
  factory :user, class: User do
    name { 'a@a.com' }
    email { 'a@a.com' }
    password { 'a@a.com' }
  end
end
