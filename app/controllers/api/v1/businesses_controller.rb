class Api::V1::BusinessesController < ApplicationController
  before_action :set_business, only: [:show, :update, :destroy]

  def index
    @businesses = Business.all
    render json: { data: @businesses }, status: :ok

  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def show
    if @business.present?
      render json: { data: @business }, status: :ok
    else
      render json: { error: "Business not found" }, status: :not_found
    end
  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def create
    @business = Business.new(params[:business])
    if @business.save
      render json: { data: @business }, status: :created
    else
      render json: { error: @business.errors.full_messages }, status: :unprocessable_entity
    end
  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def update
    if @business.update(params[:business])
      render json: { data: @business }, status: :ok
    else
      render json: { error: @business.errors.full_messages }, status: :unprocessable_entity
    end
  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def delete
    if @business.destroy
      render json: { data: 'Business has been deleted' }, status: :no_content
    else
      render json: { error: @business.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_business
    @business = Business.find(params[:id])
  end
end
