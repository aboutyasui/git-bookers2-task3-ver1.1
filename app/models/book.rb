class Book < ApplicationRecord
  #has_one_attached :book#本の情報を保存するメソッド
  belongs_to :user##1:N の「N」側にあたるモデルに、belongs_to を記載する必要がある

  #バリデーション
   validates :title,presence: true
   validates :body, length: { maximum: 200 },presence: true
   #validatesでは対象となる項目を指定し、入力されたデータのpresence(存在)をチェックする
   #trueと書くとデータが存在しなければならないという設定になる

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      #画像が設定されない場合はapp/assets/imagesに格納されているno_image.jpgという画像をデフォルト画像としてActiveStorageに格納
    end
    image
  end
def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed#画像を縦横共に100pxのサイズに変換する
end
end
