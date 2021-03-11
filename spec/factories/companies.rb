FactoryBot.define do
    factory :company do
        name { 'test_company' }
        email { 'testcompany@gmail.com' }
        website { 'https://www.sample.com' }
    end
end