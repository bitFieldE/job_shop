json.extract! user, :id, :email, :name, :uid, :provider, :family_name, :family_furigana, :first_name, :first_furigana, :introduction, :created_at, :updated_at
json.url user_url(user, format: :json)
