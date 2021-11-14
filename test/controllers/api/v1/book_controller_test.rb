require "test_helper"

class Api::V1::BookControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def index
    @book = Book.all
    render json: @book
  end
  
  def show
    begin
      @book = Book.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      @book = nil
    end
    render json: @book
  end
    
  def create
    @book = Book.new(book_params)
    if @book.save
        render json: @book
    else
      render error: { error: 'Unable to create Book.' }, status: 400
    end
  end

  def update
    begin
      @book = Book.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      @book = nil
    end
    if @book
      @book.update(book_params)
      render json: {message: 'Book updated.'}, status: 200
    else
      render json: {message: 'Book update failed.'}, status: 400
    end
  end

  def destroy
    begin
      @book = Book.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      @book = nil
    end
    if @book
      @book.destroy
      render json: {message: 'Book sucessfully deleted' },status: 200
    else
      render error: {error: 'Unable to delete Book.'}, status: 400
    end
  end
      
  private
  
  def book_params
    @book = Book.find(params[:id])
  end
end
