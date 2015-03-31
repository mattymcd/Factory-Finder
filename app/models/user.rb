class User < ActiveRecord::Base

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  # validates_format_of :email, :with => /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/, :on => :create
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :tweets

  # the user is a fan. You can interpret "fan_relationship" as "relationship in which you are a FAN"
  has_many :fan_relationships, class_name: "Relationship", foreign_key: "idol_id"
  has_many :fans, class_name: "User", through: :fan_relationships

  # the user is an idol. You can interpret "idol_relationship" as "relationship in which you are an IDOL"
  has_many :idol_relationships, class_name: "Relationship", foreign_key: "fan_id"
  has_many :idols, class_name: "User", through: :idol_relationships

  def authenticate(input_password)
    self.password == input_password
  end

end
