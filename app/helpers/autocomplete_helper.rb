module AutocompleteHelper

  # This module contains all the auto-complete AJAX functions needed for
  # autocompleting 

  def auto_complete_for_book_type_name
    find_options = {
      :conditions => [ "LOWER(TRIM(name)) LIKE ? ", '%' + params[:book_type][:name].downcase + '%'],
      :order => "id DESC", :limit => 20 }
    auto_helper_show_items BookType.scoped(find_options), "id", "name"
  end

  def auto_complete_for_owner_name
    find_options = {
      :conditions => [ "LOWER(TRIM(name)) LIKE ? ", '%' + params[:owner][:name].downcase + '%'],
      :order => "id DESC", :limit => 20 }
    auto_helper_show_items Owner.scoped(find_options), "id", "name"
  end

  def auto_complete_for_language_name
    find_options = {
      :conditions => [ "LOWER(TRIM(name)) LIKE ? ", '%' + params[:language][:name].downcase + '%'],
      :order => "id DESC", :limit => 20 }
    auto_helper_show_items Language.scoped(find_options), "id", "name"
  end

  def auto_complete_for_location_name
    @items = Location.all.select{ |loc| loc.getLocation.downcase.include? params[:location][:name].downcase}
    for entry in @items 
      entry['displayentry'] = entry.id.to_s + ' ' + entry.getLocation
    end
    render :inline => "<%= auto_complete_result @items, 'displayentry' %>"
  end

  def auto_helper_show_items items, idname, valuename
    @items = items
    for entry in @items 
      puts entry.inspect
      entry['displayentry'] = entry[idname].to_s + ' '+  entry[valuename]
    end

    render :inline => "<%= auto_complete_result @items, 'displayentry' %>"
  end

end
