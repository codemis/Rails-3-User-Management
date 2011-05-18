class User < ActiveRecord::Base
  acts_as_authentic
  
  ROLES = [
    ["Administrator", "administrator"],
    ["Member", "member"],
  ]
  
  # callbacks
  #
  before_validation :assign_email_to_login
  before_validation :last_administrator, :on => :update
  after_create :send_new_user_email, :if => Proc.new {|f| f.send_email == "1"}
  
  # relationships
  #
  has_one :role, :dependent => :destroy
  
  # attributes
  #
  accepts_nested_attributes_for :role
  attr_accessor :send_email, :validate_password
  
  # validates
  #
  validates :first_name, :last_name, :email, :presence => true
  validates :role, :presence => true
  validates :password, :presence => true, :on => :update, :if => proc { |u|
    u.validate_password === true
  }
  
  # methods
  #
  def role_symbols
    [role.title.underscore.to_sym]
  end
  
  # is this an administrator
  #
  def administrator?
    role_symbols == [:administrator]
  end
  
  # join first and last name
  #
  def full_name
    "#{first_name} #{last_name}"
  end
  
  # A nice looking logged in date
  #
  def login_date
    if last_login_at.nil?
      return ''
    else
      last_login_at.strftime("%b %d, %Y")
    end
  end
  
  # append to Rails destroy method to protect from deleting last administrator
  #
  def destroy
    if last_administrator?
      errors.add(:base, "last administrator cannot be deleted")
      false
    else
      super
    end
  end

  # Checks if this is the last administrator
  #
  def last_administrator?
    Role.count(:conditions => ["title = 'administrator' AND user_id != ?", self.id]) < 1
  end
  
  def reset_password
    reset_perishable_token!
  end

  def deliver_reset_password_email
    UserMailer.reset_password_email(self).deliver
  end
  
  private
    
    # Create error if this is the last administrator
    #
    def last_administrator
      if role.title != "administrator" && last_administrator?
        errors.add(:base, "last administrator cannot edit their role")
      end
    end
    
    # before_validation methods
    #
    def assign_email_to_login
      self.login = self.email
    end
    
    # Send the welcome letter
    #
    def send_new_user_email
      UserMailer.new_user_email(self).deliver
    end
    
end
