class Api::V1::BookController < ApplicationController
    def index
        @book = Book.all
        render json: @book
    end
      
    def show
        begin
            @book = Book.find(params[:id])
            render json: @book
        rescue ActiveRecord::RecordNotFound => e
            render json: { error: "Book not found." }, status: 400
        end
    end
        
    def create
        begin
            @book = Book.new(book_params)
            @book.save
            render json: @book
        rescue ActiveRecord::RecordNotUnique => e
            render json: { error: 'Unable to create Book.' }, status: 400
        end
    end
    
    def update
        begin
            @book = Book.find(params[:id])
            @book.update(book_params)
            render json: {message: 'Book updated.'}, status: 200
        rescue ActiveRecord::RecordNotFound => e
            render json: {message: 'Book not found.'}, status: 400
        rescue ActiveRecord::RecordNotUnique => e
            render json: {message: 'Another book already exist with that id. Update failed.'}, status: 400
        end
    end
    def destroy
        begin
            @book = Book.find(params[:id])
            render json: {message: 'Book sucessfully deleted' },status: 200
            @book.destroy
        rescue ActiveRecord::RecordNotFound => e
            render json: {error: 'Unable to delete Book. (Book not found).'}, status: 400
        end
    end
          
    private
      
    def book_params
        params.require(:book).permit(:B_id, :B_title, :Author, :Publisher, :Year)
    end
end
