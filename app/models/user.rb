class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  # 1:Nの関係において、「1」のデータが削除された場合、関連する「N」のデータも削除される設定
  #今回であれば「Userが削除された時に、そのUserが投稿したPostImageが全て削除される」という処理
  has_one_attached :profile_image

  #バリデーション
   validates :name, length: { minimum: 2, maximum: 20 },presence: true,uniqueness: true
   validates :introduction, length: {maximum: 50 }

   #validatesでは対象となる項目を指定し、入力されたデータのpresence(存在)をチェックする
   #trueと書くとデータが存在しなければならないという設定になる
   #文字数を検証することを指定する「length」と、その最小値（minimum）と最大値（maximum）を設定します。

def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
end

end