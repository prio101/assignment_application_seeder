class Api::V1::UsersController < ApplicationController
  # THIS API IS CREATED only for crud operation and easily creating the users.

  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    render json: { data: @users }, status: :ok

  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def show
    if @user.present?
      render json: { data: @user }, status: :ok
    else
      render json: { error: "User not found" }, status: :not_found
    end
  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      render json: { data: @user }, status: :created
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def update
    if @user.update(params[:user])
      render json: { data: @user }, status: :redirected
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def delete
    if @user.destroy
      render json: { data: 'User has been deleted' }, status: :redirected
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
