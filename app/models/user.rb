class User < ActiveRecord::Base
  include BCrypt

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  # validates_format_of :email, :with => /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/, :on => :create
  validates :username, presence: true, uniqueness: true


  def password
    @password ||= BCrypt::Password.new(hashed_password)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.hashed_password = @password
  end

  def authenticate(input_password)
    self.password == input_password
  end

end
