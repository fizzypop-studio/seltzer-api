# frozen_string_literal: true

module Api
  module V1
    class BooksController < ApiController
      before_action :set_book, only: %i[show edit update destroy]

      # GET /books or /books.json
      def index
        @books = Book.all
        render json: @books
      end

      # GET /books/1 or /books/1.json
      def show
        render json: @book
      end

      # GET /books/new
      def new
        render json: @book = Book.new
      end

      # GET /books/1/edit
      def edit
        render json: @book
      end

      # POST /books or /books.json
      def create
        @book = Book.new(book_params)

        respond_to do |format|
          if @book.save
            format.html do
              redirect_to api_v1_book_url(@book),
                          notice: "Book was successfully created."
            end
            format.json { render :show, status: :created, location: @book }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json do
              render json: @book.errors, status: :unprocessable_entity
            end
          end
        end
      end

      # PATCH/PUT /books/1 or /books/1.json
      def update
        respond_to do |format|
          if @book.update(book_params)
            format.html do
              redirect_to api_v1_book_url(@book),
                          notice: "Book was successfully updated."
            end
            format.json { render :show, status: :ok, location: @book }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json do
              render json: @book.errors, status: :unprocessable_entity
            end
          end
        end
      end

      # DELETE /books/1 or /books/1.json
      def destroy
        @book.destroy

        respond_to do |format|
          format.html do
            redirect_to api_v1_books_url,
                        notice: "Book was successfully destroyed."
          end
          format.json { head :no_content }
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_book
        @book = Book.find_by_id(params[:id])
        if @book.nil?
          render json: { error: "Book not found" }, status: :not_found
        end
      end

      # Only allow a list of trusted parameters through.
      def book_params
        params.require(:book).permit(:title, :body)
      end
    end
  end
end
