module AutocompleteHelper

  # This module contains all the auto-complete AJAX functions needed for
  # autocompleting 

  def auto_complete_for_book_type_name
    find_options = {
      :conditions => [ "LOWER(TRIM(name)) LIKE ? ", '%' + params[:book_type][:name].downcase + '%'],
      :order => "id DESC", :limit => 20
    }
    @items = BookType.scoped(find_options)
    for entry in @items 
      entry['displayentry'] = entry['id'].to_s + ' '+  entry['name']
    end

    render :inline => "<%= auto_complete_result @items, 'displayentry' %>"
  end
end
