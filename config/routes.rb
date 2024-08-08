Rails.application.routes.draw do
  # google認証にアクセス
  get '/auth/:provider/callback', to: 'sessions#create'

  # ユーザー登録のルート(API)
  namespace :api do
    namespace :v1 do
      # カレントユーザーの呼び出し
      get 'users/current', to: 'users#current'
    end
  end
end
