class Post < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "500x500>", thumb: "100x100>" },
                      :storage => :s3,
                      :s3_credentials => Proc.new{|a| a.instance.s3_credentials }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_presence_of :image,  :on => :create, :message => "A post image is required" 

  has_and_belongs_to_many :tags

  def tag_list
  end

  def tag_list=(some_tags)
  	return if some_tags.empty?

  	some_tags.split(', ').uniq.each do |tag|
  	  self.tags << Tag.find_or_create_by(text: tag)
    end
  end

  def s3_credentials
    {:bucket => "instagramme", :access_key_id => Rails.application.secrets.aws_access_key_id, :secret_access_key => Rails.application.secrets.aws_secret_access_key }
  end

end
