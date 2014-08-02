
namespace :data do
  desc "import data from files to database"
  task :import => :environment do

    langdic = {
      0 => 'other',
      1 => 'German',
      2 => 'English',
      3 => 'French',
      4 => 'Spanish',
      5 => 'Swedish',
      6 => 'Old German',
      7 => 'German/English',
      8 => 'German/French',
      9 => 'Italian'
    }

    File.open('/tmp/buchn.csv').each_with_index do |line,i|
      spl = line.split("\t")
      puts i
      c_apartment = "Zürich Kügeliloostrasse"
      c_room = spl[1].strip
      c_shelf = spl[2].strip
      c_column = spl[3].strip
      c_height = spl[4].strip
      c_author_old = spl[5].strip
      c_title = spl[6].strip
      c_language = langdic[spl[7].strip.to_i]
      c_owner = spl[8].strip
      c_type = spl[9].strip
      c_first = spl[10].strip
      c_last = spl[11].strip

      # Author
      @author = Author.find(:all, :conditions=>["firstname=? and lastname=?", c_first, c_last]).first
      @author = Author.find(:all, :conditions=>["comment=?", c_author_old]).first if c_first.empty? and c_last.empty?
      @author = Author.new(:firstname => c_first, :lastname => c_last, 
                           :comment => c_author_old) if @author.nil?
      @author.save

      # Location
      @location = Location.find(:all, :conditions=>["room=? and shelf=?", 
                            c_room, c_shelf]).first
      @location = Location.new(:apartment => c_apartment, :room => c_room, :shelf => c_shelf) if @location.nil?
      @location.save

      # Language
      @lang = Language.find(:all, :conditions=>["name=?", c_language]).first
      @lang = Language.new(:name => c_language) if @lang.nil?
      @lang.save

      # Owner
      @owner = Owner.find(:all, :conditions=>["name=?", c_owner]).first
      @owner = Owner.new(:name => c_owner) if @owner.nil?
      @owner.save

      # Type
      @type = BookType.find(:all, :conditions=>["name=?", c_type]).first
      @type = BookType.new(:name => c_type) if @type.nil?
      @type.save

      # Book 
      @book = Book.new(:title => c_title.strip, 
                       :location => @location,
                       :language => @lang,
                       :owner => @owner,
                       :book_type => @type, 
                       :column_nr => c_column, 
                       :row_nr => c_height
                      )
      @book.authors << @author
      @book.save

    end
    puts "Done!"

  end
end
