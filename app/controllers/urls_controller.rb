class UrlsController < ApplicationController
  before_action :set_url, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token

  # GET /urls
  # GET /urls.json
  def index
    @urls = Url.all
    respond_to do |format|
      format.html
      format.json { render json: { response_status: 200, data: @urls } }
    end
  end

  # GET /urls/1
  # GET /urls/1.json
  def show
    if @url.nil?
      respond_to do |format|
        format.html { redirect_to urls_url, notice: 'Url is not in the DB' }
        format.json { render json: { response_status: 404, message: 'Url is not in the DB' } }
      end
      return
    end
    respond_to do |format|
      format.html
      format.json { render json: { response_status: 200, data: @url } }
    end
  end

  def redirect
    url = Url.find_by(new_short_url: params[:short_url])
    if url.nil?
      respond_to do |format|
        format.html { redirect_to urls_path, target: '_blank' }
        format.json { render json: { response_status: 404, message: 'Short URl not found, either deleted' } }
      end
      return
    end
    respond_to do |format|
      format.html { redirect_to url.original_url }
      url.new_short_url = "#{request.base_url}/#{url.new_short_url}"
      format.json { render json: { response_status: 200, url: url } }
    end
  end

  # GET /urls/new
  def new
    @url = Url.new
  end

  # GET /urls/1/edit
  def edit; end

  # POST /urls
  # POST /urls.json
  def create
    @url = Url.new(url_params)

    respond_to do |format|
      if @url.save
        format.html { redirect_to urls_path, notice: 'Url was successfully created.' }
        @url.new_short_url = "#{request.base_url}/#{@url.new_short_url}"
        format.json { render json: { response_status: 200, url: @url } }
      else
        format.html { render :new }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /urls/1
  # PATCH/PUT /urls/1.json
  def update
    if @url.nil?
      respond_to do |format|
        format.html { redirect_to urls_url, notice: 'Url is not in the DB' }
        format.json { render json: { response_status: 404, message: 'Url is not in the DB' } }
      end
      return
    end
    respond_to do |format|
      if @url.update(url_params)
        format.html { redirect_to urls_path, notice: 'Url was successfully updated.' }
        format.json { render :show, response_status: 200, location: @url }
      else
        format.html { render :edit }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /urls/1
  # DELETE /urls/1.json
  def destroy
    if @url.nil?
      respond_to do |format|
        format.html { redirect_to urls_url, notice: 'Url deleted previosuly' }
        format.json { render json: { response_status: 404, message: 'Url already deleted' } }
      end
      return
    end
    @url.destroy
    respond_to do |format|
      format.html { redirect_to urls_url, notice: 'Url was successfully destroyed.' }
      format.json { render json: { response_status: 200, url: @url, message: 'Url was successfully destroyed.' } }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_url
    @url = Url.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def url_params
    params.require(:url).permit(:original_url, :new_short_url)
  end
end
