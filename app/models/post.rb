class Post < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "500x500>", thumb: "100x100>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  has_and_belongs_to_many :tags

  def tag_list
  end

  def tag_list=(some_tags)
  	return if some_tags.empty?

  	some_tags.split(', ').uniq.each do |tag|
  	  self.tags << Tag.find_or_create_by(text: tag)
    end
  end

end
