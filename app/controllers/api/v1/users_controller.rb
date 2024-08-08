class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index show]

  # それぞれアプリ要件に従って設定
  def index; end
  def show; end
  def update; end
  def destroy; end

  # カレントユーザーを返す
  def current
    if @current_user
      render json: { user: @current_user }
    else
      render json: { error: '認証情報を取得できません' }, status: :unauthorized
    end
  end
end
