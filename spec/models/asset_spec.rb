require 'rails_helper'

RSpec.describe Asset, :type => :model do
  it { should belong_to(:library) }
  it { should belong_to(:uploader) }
  it { should have_many(:comments) }
  it { should validate_presence_of(:filename) }
  it { should validate_presence_of(:library) }
  it { should validate_presence_of(:uploader) }

  describe "search" do
    before :each do
      @user = create(:user)
      @library = create(:library)
      @video_asset = create(:asset, library: @library, uploader: @user, filename: "video.mp4", file_type: :video, title: "video AaA")
      @image_asset = create(:asset, library: @library, uploader: @user, filename: "image.jpg", file_type: :image, title: "image aAa")
      @document_asset = create(:asset, library: @library, uploader: @user, filename: "document.pdf", file_type: :document, title: "document")
      @audio_asset = create(:asset, library: @library, uploader: @user, filename: "audio.mp3", file_type: :audio, title: "audio")
      @unknown_asset = create(:asset, library: @library, uploader: @user, filename: "unknown.unkn", file_type: :unknown, title: "unknown")
    end

    it "returns whole list of assets" do
      
      params = {library_id: @library.id}
      expected_result = [
        @unknown_asset,
        @audio_asset, 
        @document_asset, 
        @image_asset, 
        @video_asset
      ]

      expect(Asset.search(params)).to eq(expected_result)
    end

    it "returns search result for assets having some search value" do
      params = {library_id: @library.id, search: "AaA"}
      expected_result = [ 
        @image_asset,
        @video_asset
      ]
      expect(Asset.search(params)).to eq(expected_result)
    end

    it "returns empty search result for assets not having some search value" do
      params = {library_id: @library.id, search: "BBB"}
      expected_result = []
      expect(Asset.search(params)).to eq(expected_result)
    end

    it "returns assets ordered by created by desc" do
      params = {library_id: @library.id, sort: 'created_at_desc'}
      expected_result = [
        @unknown_asset,
        @audio_asset, 
        @document_asset, 
        @image_asset, 
        @video_asset
      ]
      expect(Asset.search(params)).to eq(expected_result)
    end

    it "returns assets ordered by created by asc" do
      params = {library_id: @library.id, sort: 'created_at_asc'}
      expected_result = [
        @unknown_asset,
        @audio_asset, 
        @document_asset, 
        @image_asset, 
        @video_asset
      ].reverse
      expect(Asset.search(params)).to eq(expected_result)
    end

    it "returns assets ordered by title asc" do
      params = {library_id: @library.id, sort: 'title_asc'}
      expected_result = [
        @audio_asset, 
        @document_asset, 
        @image_asset, 
        @unknown_asset,
        @video_asset
      ]
      expect(Asset.search(params)).to eq(expected_result)
    end

    it "returns assets ordered by title desc" do
      params = {library_id: @library.id, sort: 'title_desc'}
      expected_result = [
        @audio_asset, 
        @document_asset, 
        @image_asset, 
        @unknown_asset,
        @video_asset
      ].reverse
      expect(Asset.search(params)).to eq(expected_result)
    end

    it "returns assets filter by video" do
      params = {library_id: @library.id, filter: 'video'}
      expected_result = [
        @video_asset
      ]
      expect(Asset.search(params)).to eq(expected_result)
    end

    it "returns assets filter by image" do
      params = {library_id: @library.id, filter: 'image'}
      expected_result = [
        @image_asset
      ]
      expect(Asset.search(params)).to eq(expected_result)
    end

    it "returns assets filter by audio" do
      params = {library_id: @library.id, filter: 'audio'}
      expected_result = [
        @audio_asset
      ]
      expect(Asset.search(params)).to eq(expected_result)
    end

    it "returns assets filter by document" do
      params = {library_id: @library.id, filter: 'document'}
      expected_result = [
        @document_asset
      ]
      expect(Asset.search(params)).to eq(expected_result)
    end

  end
end
