class BinariesController < ApplicationController
  before_action :set_number, only: [:index, :set]
  def index
  end

  def set
    render :index
  end

  def binary_search 
    @numbers = params[:numbers]  
    unless @numbers
      index = 0
       return render json: { index: index } 
    end
    left = 0
    right = @numbers.length - 1

    center = (left + right) / 2.0
    if @numbers.length % 2 == 0
      center_number = (@numbers[@numbers.length/2 -1].to_i + @numbers[@numbers.length/2].to_i)/2.0      
    else
      center_number = @numbers[center].to_i
    end

    target_number = params[:target].to_i

    if center_number == target_number
      @deleted_numbers = @numbers.reject{ |n| n.to_i == center_number }
      index = 1
      render json: { deleted_numbers: @deleted_numbers, target: target_number, index: index }
    elsif center_number < target_number
      @deleted_numbers = @numbers[left.floor..center]   
      index = 2   
      left = center + 1
      render json: { deleted_numbers: @deleted_numbers, target: target_number, index: index }
    else
      @deleted_numbers =  @numbers[center.ceil..right]    
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
    @number_data = Number.find(Number.pluck(:id).shuffle[0..10]).sort
    @numbers = []

    @number_data.each do |number| 
      @numbers << number.number
    end
  end

end
