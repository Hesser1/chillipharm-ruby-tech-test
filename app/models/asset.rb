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

    # creating search engine to search by search phrase or for all in the library
    # ordering by asset index DESC by default
    if search
      where("LOWER(title) LIKE ? AND library_id = ?", "%#{search.downcase}%", "#{library_id}").order('id DESC')
    else
      where("library_id = ?", "#{library_id}").order('id DESC')
    end
  end 
end
