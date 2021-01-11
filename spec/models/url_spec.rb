require 'rails_helper'

RSpec.describe Url, type: :model do
  describe '#new create' do
    it 'should create an url with valid original URL' do
      url = build(:url)
      url.valid?
      expect(url.errors[:original_url]).to match_array([])
    end

    it 'should not create an url with invalid original URL' do
      url = build(:url, :invalidate_original_url_if_it_contain_space)
      url.valid?
      expect(url.errors[:original_url]).to include('You provided invalid URL')
    end

    it 'should not create an url with invalid original URL' do
      url = build(:url, :invalidate_original_url_empty_string)
      url.valid?
      expect(url.errors[:original_url]).to include('You provided invalid URL')
    end

    it 'should not create an url with invalid original URL' do
      url = build(:url, :missing_url)
      url.valid?
      expect(url.errors[:original_url]).to include('You provided invalid URL')
    end

    it 'should not create an url with invalid new short URL' do
      url = build(:url, :missing_new_short_url)
      url.valid?
      expect(url.errors[:new_short_url]).to include("can't be blank")
    end

    it 'should not create an url with invalid new short URL' do
      url = build(:url, :invalidate_new_short_url_if_it_is_empty_string)
      url.valid?
      expect(url.errors[:new_short_url]).to include("can't be blank")
    end

    it 'should not create an url with repeating new short URL' do
      url_obj_1 = build(:url)
      url_obj_1.save
      url_obj_2 = build(:url)
      url_obj_2.new_short_url = url_obj_1.new_short_url
      url_obj_2.valid?
      expect(url_obj_2.errors[:new_short_url]).to include('has already been taken')
    end
  end
end
