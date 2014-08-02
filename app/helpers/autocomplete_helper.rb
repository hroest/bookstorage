

module AutocompleteHelper

  # This module contains all the auto-complete AJAX functions needed for
  # autocompleting 

  def auto_complete_for_author_name
    q = '%' + params[:author][:name] + '%'
    flconcat = db_concat( {:doMap => false},  "TRIM(firstname)", ' " " ', "TRIM(lastname)" )
    lfconcat = db_concat( {:doMap => false},  "TRIM(lastname)", ' " " ', "TRIM(firstname)" )

    find_options = {
      :conditions => [ "(LOWER(#{flconcat}) LIKE ? 
        OR LOWER(#{lfconcat}) LIKE ? 
        OR LOWER(publisher) LIKE ?)", q, q, q],
      :order => "id DESC"}
    @items = Author.scoped(find_options)
    for entry in @items 
      entry['displayentry'] = entry[:id].to_s + ' ' + entry[:firstname] + ' ' + entry[:lastname]
      if entry[:publisher].present? and entry[:firstname].empty? and entry[:lastname].empty?
        entry['displayentry'] = entry[:id].to_s + ' ' + entry[:publisher]
      end
    end

    render :inline => "<%= auto_complete_result @items, 'displayentry' %>"
  end

  def auto_complete_for_book_type_name
    return auto_helper_show_items BookType.all.sort, "id", "name" if params[:book_type][:name].strip == "?"
    find_options = {
      :conditions => [ "LOWER(TRIM(name)) LIKE ? ", '%' + params[:book_type][:name].downcase + '%'],
      :order => "id DESC", :limit => 20 }
    auto_helper_show_items BookType.scoped(find_options), "id", "name"
  end

  def auto_complete_for_owner_name
    return auto_helper_show_items Owner.all.sort, "id", "name" if params[:owner][:name].strip == "?"
    find_options = {
      :conditions => [ "LOWER(TRIM(name)) LIKE ? ", '%' + params[:owner][:name].downcase + '%'],
      :order => "id DESC", :limit => 20 }
    auto_helper_show_items Owner.scoped(find_options), "id", "name"
  end

  def auto_complete_for_language_name
    return auto_helper_show_items Language.all.sort, "id", "name" if params[:language][:name].strip == "?"
    find_options = {
      :conditions => [ "LOWER(TRIM(name)) LIKE ? ", '%' + params[:language][:name].downcase + '%'],
      :order => "id DESC", :limit => 20 }
    auto_helper_show_items Language.scoped(find_options), "id", "name"
  end

  def auto_complete_for_location_name
    @items = Location.all.select{ |loc| loc.getLocation.downcase.include? params[:location][:name].downcase}
    @items = Location.all.sort if params[:location][:name].strip == "?"
    for entry in @items 
      entry['displayentry'] = entry.id.to_s + ' ' + entry.getLocation
    end
    render :inline => "<%= auto_complete_result @items, 'displayentry' %>"
  end

  def auto_helper_show_items items, idname, valuename
    @items = items
    for entry in @items 
      entry['displayentry'] = entry[idname].to_s + ' '+  entry[valuename]
    end

    render :inline => "<%= auto_complete_result @items, 'displayentry' %>"
  end

  # Symbols should be used for field names, everything else will be quoted as a string
  # http://stackoverflow.com/questions/2986405/database-independant-sql-string-concatenation-in-rails
  def db_concat(options = {}, *args)

    #adapter = configurations[RAILS_ENV]['adapter'].to_sym
    adapter = ActiveRecord::Base.connection.instance_values["config"][:adapter] 
    if options[:doMap] then 
      args.map!{ |arg| arg.class==Symbol ? arg.to_s : "'#{arg}'" }
    end

    case adapter
      when :mysql
        "CONCAT(#{args.join(',')})"
      when :sqlserver
        args.join('+')
      else
        args.join('||')
    end

  end

end
