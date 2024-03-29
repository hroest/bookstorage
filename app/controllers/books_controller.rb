class BooksController < ApplicationController

  include AutocompleteHelper

  # GET /books
  # GET /books.xml
  def index
    params[:per_page] = Book.count if params[:paginate] == "no"
    @books = Book.all.paginate(:page => params[:page], :per_page => params[:per_page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @books }
    end
  end

  # GET /books/1
  # GET /books/1.xml
  def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book }
    end
  end

  def search
    @books = find_by_params params
    @books = @books.paginate(:page => params[:page], :per_page => params[:per_page])
    render :action => "index"
  end

  def show_by_location
    params[:per_page] = Book.count if params[:paginate] == "no"
    @books = Location.find(params[:by_location]).books
    @books = @books.select{ |b| b.column_nr == params[:col_nr].to_i} if params[:col_nr] and params[:col_nr].to_i > 0
    @books = @books.select{ |b| b.row_nr == params[:row_nr].to_i} if params[:row_nr] and params[:row_nr].to_i > 0
    @books = @books.paginate(:page => params[:page], :per_page => params[:per_page])
    render :action => "index"
  end

  # GET /books/new
  # GET /books/new.xml
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.xml
  def create
    rewriteParams
    @book = Book.new(params[:book])
    @book.authors << Author.find(params[:author][:name]) if not params[:author][:name].empty?
    @book.book_types << BookType.find(params[:book_type][:name]) if not params[:book_type][:name].empty?

    respond_to do |format|
      if @book.save
        format.html { redirect_to(@book, :notice => 'Book was successfully created.') }
        format.xml  { render :xml => @book, :status => :created, :location => @book }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.xml
  def update
    rewriteParams
    @book = Book.find(params[:id])
    @book.authors << Author.find(params[:author][:name]) if not params[:author][:name].empty?
    @book.book_types << BookType.find(params[:book_type][:name]) if not params[:book_type][:name].empty?

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to(@book, :notice => 'Book was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.xml
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to(books_url) }
      format.xml  { head :ok }
    end
  end

  def remove_author
    @author = Author.find( params[:author_id])
    @book = Book.find( params[:book_id])
    @book.authors.delete(@author)

    render :update do |page|
      page["book_author_#{params[:author_id]}"].remove
    end
  end

  def remove_book_type
    @book_type = BookType.find( params[:book_type_id])
    @book = Book.find( params[:book_id])
    @book.book_types.delete(@book_type)

    render :update do |page|
      page["book_type_#{params[:book_type_id]}"].remove
    end
  end

  private

  def find_by_params options
    current_query = "%" + options[:query] + "%" if options[:query]
    if current_query.blank?
      Book.find(:all)
    else
      @items_top = Book.scoped( {:conditions => [
        "LOWER(title) LIKE ? OR LOWER(subtitle) LIKE ? OR LOWER(comment) LIKE ?",
        current_query, current_query, current_query]})

      flconcat = db_concat( {:doMap => false},  "TRIM(firstname)", ' " " ', "TRIM(lastname)" )
      lfconcat = db_concat( {:doMap => false},  "TRIM(lastname)", ' " " ', "TRIM(firstname)" )
      @authors = Author.scoped( {:conditions => [
        "(LOWER(#{flconcat}) LIKE ? 
        OR LOWER(#{lfconcat}) LIKE ? 
        OR LOWER(comment) LIKE ? 
        OR LOWER(publisher) LIKE ?)", current_query, current_query, current_query, current_query] })
      @authors.each do |author|
        @items_top = @items_top.concat(author.books) if author.books.size > 0
      end

      return @items_top.uniq{|x| x.id}
    end
  end

  def rewriteParams 
    params[:book][:owner_id] = params[:owner][:name]
    params[:book][:location_id] = params[:location][:name]
    params[:book][:language_id] = params[:language][:name]
  end

end
