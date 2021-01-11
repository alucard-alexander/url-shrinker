FactoryBot.define do
  factory :url do
    original_url { 'https://www.google.com' }
    new_short_url { 'mystring' }

    trait :missing_url do
      original_url {}
    end

    trait :invalidate_original_url_empty_string do
      original_url { '' }
    end

    trait :invalidate_original_url_if_it_contain_space do
      original_url { 'https://www.flip kart.com/' }
    end

    trait :missing_new_short_url do
      new_short_url {}
    end

    trait :invalidate_new_short_url_if_it_is_empty_string do
      new_short_url { '' }
    end

  end
end
