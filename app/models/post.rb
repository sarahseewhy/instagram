class Post < ActiveRecord::Base
  has_attached_file :photo,
    storage: :s3,
    bucket: 'instagram_sy',
    s3_credentials: {
      access_key_id: Rails.application.secrets.s3_access_key,
      secret_access_key: Rails.application.secrets.s3_secret_key
    }
	validates :description, presence: true
	# validates_attachment_content_type :picture, content_type: ["image/jpg", "image/jpeg", "image/png"]
	# has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }
	has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  has_and_belongs_to_many :tags
  has_many :comments
  belongs_to :user
  

  def tag_names
    tags.map(&:name).join
  end

  def tag_names=(tag_names)
    tag_names.split(' ').uniq.each do |tag_name|
      tag_name.prepend('#') unless tag_name[0] == '#'
      tag = Tag.find_or_create_by(name: tag_name.downcase)
      tags << tag
    end
  end



end
