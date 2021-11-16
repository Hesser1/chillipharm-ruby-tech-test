module Account::LibrariesHelper
  def current_filter_label(filter)
    case filter
    when "video"
      "Video Only"
    when "audio"
      "Audio Only"
    when "image"
      "Image Only"
    else
      "All File Types"
    end
  end

  def current_sort_label(sort)
    case sort
    when "created_at_asc"
      "Oldest"
    when "created_at_desc"
      "Most Recent"
    when "title_asc"
      "Title A-Z"
    when "title_desc"
      "Title Z-A"
    else
      "Most Recent"
    end
  end

  def filter_link(filter, sort, search, display_assets, section, library, object=nil)
    args = {}
    args[:filter] = filter

    if sort.present?
      args[:sort] = sort
    end

    if search.present?
      args[:search] = search
    end

    if display_assets.present?
      args[:display_assets] = display_assets
    end

    section_link(library, section, args, object)
  end

  def sort_link(sort, filter, search, display_assets, section, library, object=nil)
    args = {}
    args[:sort] = sort

    if filter.present?
      args[:filter] = filter
    end

    if search.present?
      args[:search] = search
    end

    if display_assets.present?
      args[:display_assets] = display_assets
    end

    section_link(library, section, args, object)
  end

  def list_link(filter, search, sort, section, library, object=nil)
    link('display_assets_as_list', filter, search, sort, section, library, object=nil)
  end

  def grid_link(filter, search, sort, section, library, object=nil)
    link('display_assets_as_grid', filter, search, sort, section, library, object=nil)
  end

  def search_link(filter, search, sort, display_assets, section, library, object=nil)
    link(display_assets, filter, search, sort, section, library, object=nil)
  end
   
  def link(display_assets, filter, search, sort, section, library, object=nil)
    args = {}
    args[:display_assets] = display_assets

    if filter.present?
      args[:filter] = filter
    end

    if sort.present?
      args[:sort] = sort
    end

    if search.present?
      args[:search] = search
    end

    section_link(library, section, args, object)
  end

  def save_search_link(filter, search, sort, section, library, object=nil)
    args = {}

    if filter.present?
      args[:filter] = filter
    end

    if sort.present?
      args[:sort] = sort
    end

    if search.present?
      args[:search] = search
    end

    section_link(library, section, args, object)
  end
  
  def section_link(library, section, args, object=nil)
    case section
    when "library"
      library_path(library, args)
    when "collection"
      library_collection_path(library, object, args)
    when "save_search"
      save_search_library_path(library, args)
    else
      library_path(library, args)
    end
  end
end
