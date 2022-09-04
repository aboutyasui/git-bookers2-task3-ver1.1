class BooksController < ApplicationController
 before_action :correct_user, only: [:edit, :update]
  #ログイン中にURLを入力すると他人が投稿した本の編集ページに遷移できないようにする

   # 投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id#この投稿の user_id としてcurrent_user.id(ログイン中のユーザーのID) の値を代入する、という意味
    if @book.save #対象のカラム（ここではtitleとopinion）にデータが保存されること
     flash[:notice] ="You have created book successfully."
     redirect_to book_path(@book) #投稿に成功後indexに戻る
    else
     @user = current_user
     @books = Book.all
     render :index #投稿に失敗後新規投稿画面が表示される
    end

  end

  def index
   @user = current_user
   @books = Book.all
   @book = Book.new
  end

  def show
   @book = Book.find(params[:id])#アクション内にparams[:id]と記述することで、詳細画面で呼び出される投稿データを URLの/posts/:id 内の:idで判別可能にする。
   @user = @book.user#特定のbook（@book）に関連付けられた投稿全て（.user）を取得し@userに渡す
   @books = Book.new
   #今回はレコードを1件だけ取得するので、インスタンス変数名は単数形の「@post_image」にします。
   #@post_comment = PostComment.new※今回の課題ではコメント機能は無し
   #コメントを投稿するためのインスタンス変数を定義する
  end

  def edit
   @book = Book.find(params[:id])
  end

  def update
   @book =  Book.find(params[:id]) #削除するPostImageレコードを取得
   #@user.user_id = current_user.id
    if @book.update(book_params)#更新する処理
      flash[:notice] ="You have updated book successfully."
      redirect_to book_path(@book.id)#booksのshowページへ戻る
    else
      render :edit
    end
  end

  def destroy
   @book =  Book.find(params[:id]) #削除するPostImageレコードを取得
   @book.destroy #削除する処理
   redirect_to books_path #booksのindexページへ戻る
  end

  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user#ログイン中にURLを入力すると他人が投稿した本の編集ページに遷移できないようにする
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

end
