FactoryBot.define do
    factory :user do
        name { 'test' }
        email { 'test@gmail.com' }
        phone { '1234567891' }
        gender { 'male' }
        state_id { 1 }
        city_id { 1 }
        password { '12345678' }
        after(:create) { |user| user.add_role(:employee) }
    end
        
    factory :admin_user, class: 'User' do
        name { 'admin' }
        email { 'a@gmail.com' }
        phone { '1234577891' }
        gender { 'female' }
        state_id { 1 }
        city_id { 1 }
        password { '12345678' }
        after(:create) { |user| user.add_role(:admin) }
    end

    factory :superadmin_user, class: 'User'do
        name { 'superadmin' }
        email { 'super@gmail.com' }
        phone { '1234569999' }
        gender { 'male' }
        state_id { 1 }
        city_id { 1 }
        password { '12345678' }
        after(:create) { |user| user.add_role(:superadmin) }
    end

end