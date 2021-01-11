class Url < ApplicationRecord
  before_create :set_short_url

  URL_REGEXP = %r{^(http|https)://[a-z0-9]+([\-.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(/.*)?$}ix.freeze
  validates :original_url, presence: true, length: { minimum: 10 }, format: {
    with: URL_REGEXP,
    multiline: true,
    message: 'You provided invalid URL'
  }

  validates :new_short_url, uniqueness: true, presence: true

  private

  def set_short_url
    new_url = SecureRandom.alphanumeric(5)
    new_url = SecureRandom.alphanumeric(5) until Url.find_by(new_short_url: new_url).nil?
    self.new_short_url = new_url
  end
end
