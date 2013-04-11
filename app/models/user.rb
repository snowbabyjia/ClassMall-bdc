class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #Relationships with other models
  has_and_belongs_to_many :courses
  has_many :comments, inverse_of: :user
  has_many :ratings, inverse_of: :user
  has_and_belongs_to_many :majors

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false
end
