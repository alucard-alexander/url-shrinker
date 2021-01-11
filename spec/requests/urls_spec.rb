require 'rails_helper'

RSpec.describe '/urls', type: :request do
  let(:valid_attributes) do
    {
      original_url: 'https://www.google.com',
      new_short_url: 'mystring'
    }
  end

  let(:invalid_attributes) do
    {
      original_url: 'https//www.google.com',
      new_short_url: 'mystring'
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Url.create! valid_attributes
      get urls_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      url = Url.create! valid_attributes
      get url_url(url)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_url_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      url = Url.create! valid_attributes
      get edit_url_url(url)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Url' do
        expect do
          post urls_url, params: { url: valid_attributes }
        end.to change(Url, :count).by(1)
      end

      it 'redirects to the created url' do
        post urls_url, params: { url: valid_attributes }
        expect(response).to redirect_to(urls_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Url' do
        expect do
          post urls_url, params: { url: invalid_attributes }
        end.to change(Url, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post urls_url, params: { url: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          original_url: 'https://www.duckduckgo.com'
        }
      end

      it 'updates the requested url' do
        url = Url.create! valid_attributes
        patch url_url(url), params: { url: new_attributes }
        url.reload
      end

      it 'redirects to the url' do
        url = Url.create! valid_attributes
        patch url_url(url), params: { url: new_attributes }
        expect(response).to redirect_to(urls_url)
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        url = Url.create! valid_attributes
        patch url_url(url), params: { url: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested url' do
      url = Url.create! valid_attributes
      expect do
        delete url_url(url)
      end.to change(Url, :count).by(-1)
    end

    it 'redirects to the urls list' do
      url = Url.create! valid_attributes
      delete url_url(url)
      expect(response).to redirect_to(urls_url)
    end
  end

end