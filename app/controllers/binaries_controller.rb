class BinariesController < ApplicationController
  before_action :set_number, only: [:index]
  def index
  end

  def binary_search 
    @numbers = params[:numbers]  ##hidden_fieldから送られた数字をインスタンス変数に代入
    unless @numbers ##送られた値が存在しなければ処理を終了。JSにindex=0を渡す。このindexが「検索結果が見つからなかった場合のポップアップと対応する。」
      index = 0
       return render json: { index: index } 
    end
    #検索対象の一番左と一番右を変数化
    left = 0
    right = @numbers.length - 1

    center = (left + right) / 2.0 #2.0で割らないと@numbersの要素数が偶数のときに中央値が正しく出ない。
    if @numbers.length % 2 == 0
      center_number = (@numbers[@numbers.length/2 -1].to_i + @numbers[@numbers.length/2].to_i)/2.0 #要素数が偶数の場合中央の値は真ん中2つの平均になる  
    else
      center_number = @numbers[center].to_i #要素数が奇数のときは中央の値は配列からcenter番目の要素を取り出す
    end

    target_number = params[:target].to_i #params[:target]はtext_fieldから飛んでくるのでstringになっているためto_iで数字に変換

    if center_number == target_number
      @deleted_numbers = @numbers.reject{ |n| n.to_i == center_number } #中央の値と検索対象の値が等しい時、中央の値以外の要素を検索対象から除外する
      index = 1
      render json: { deleted_numbers: @deleted_numbers, target: target_number, index: index }
    elsif center_number < target_number
      @deleted_numbers = @numbers[left.floor..center]   #中央の値のほうが小さい場合、検索対象の一番左から真ん中までを検索対象から除外する
      index = 2   
      left = center + 1
      render json: { deleted_numbers: @deleted_numbers, target: target_number, index: index }
    else
      @deleted_numbers =  @numbers[center.ceil..right]   #中央の値のほうが大きい場合、中央から一番右の値までを検索対象から除外する
      index = 3
      right = center - 1
      render json: { deleted_numbers: @deleted_numbers, target: target_number, index: index }
    end
  
  end

  private 

  def array_params
    params.require(:key_array).permit(numbers: [])    
  end

  def set_number 
    @number_data = Number.all.sample(50).sort #DB内にある100個の数字からランダムに50個取得して小さい順に並べる
    @numbers = []

    @number_data.each do |number| 
      @numbers << number.number #findで取ってこれるのはあくまでモデルデータなので数字だけを表示するために空配列に代入し直す
    end
  end

end
