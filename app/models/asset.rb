class Asset < ApplicationRecord
  acts_as_paranoid column: :soft_deleted_at

  belongs_to :library, counter_cache: true
  belongs_to :uploader, class_name: "User"
  has_many :comments, -> { includes(:author) }

  enum file_type: [:video, :image, :audio, :document, :unknown]

  validates :filename, presence: true
  validates :library, presence: true
  validates :uploader, presence: true

  def self.search(params)
    library_id = params[:library_id]
    search = params[:search]
    sort = params[:sort] # sort types ['created_at_desc', 'created_at_asc', 'title_asc', 'title_desc']
    filter = params[:filter] # filter types ['all', 'video', 'audio', 'image']

    unless search.present?
      search = nil
    end

    unless sort.present?
      sort = 'id_desc'
    end

    unless filter.present?
      filter = nil
    end

    # changing asc/desc to uppercase
    sort_arr = sort.split('_')
    sort_arr.last.upcase!

    sort_param =  if sort_arr.size == 2
                    sort_arr.join(' ')
                  else
                    sort_arr[0..-2].join('_') + " #{sort_arr.last}"
                  end

    # creating search engine
    query_str = ""
    query_arr = []
    query_params = {}
    query_params.merge!({:library_id => "#{library_id}"})
    query_arr.append('library_id = :library_id')

    if search.present?
      query_params.merge!({:search => "%#{search.downcase}%"})
      query_arr.append('LOWER(title) LIKE :search')
    end

    if filter.present? && filter != 'all'
      query_params.merge!({:filter => "#{file_types[filter]}"})
      query_arr.append('file_type = :filter')
    end
    
    # joining query array into string
    query_str = query_arr.join(' AND ')

    where(query_str, query_params).order(sort_param)
  end 
end
