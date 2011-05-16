require 'spec_helper'

describe User do
  describe "database" do
    it {should have_db_column(:first_name).of_type(:string)}
    it {should have_db_column(:last_name).of_type(:string)}
    it {should have_db_column(:login).of_type(:string)}
    it {should have_db_column(:email).of_type(:string)}
    it {should have_db_column(:crypted_password).of_type(:string)}
    it {should have_db_column(:password_salt).of_type(:string)}
    it {should have_db_column(:persistence_token).of_type(:string)}
    it {should have_db_column(:single_access_token).of_type(:string)}
    it {should have_db_column(:perishable_token).of_type(:string)}
    it {should have_db_column(:login_count).of_type(:integer)}
    it {should have_db_column(:failed_login_count).of_type(:integer)}
    it {should have_db_column(:last_request_at).of_type(:datetime)}
    it {should have_db_column(:current_login_at).of_type(:datetime)}
    it {should have_db_column(:last_login_at).of_type(:datetime)}
    it {should have_db_column(:current_login_ip).of_type(:string)}
    it {should have_db_column(:last_login_ip).of_type(:string)}
  end
  
  describe "validations" do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
    it {should validate_presence_of(:role)}
  end
  
  describe "relationships" do
    it {should have_one(:role).dependent(:destroy) }
  end
  
  describe "custom attributes" do
    before do
      @user = Factory.create(:user, {:first_name => 'John', :last_name => 'Doe', :role_attributes => {:title => "administrator"}})
    end
    
    it "should have access to a full_name" do
      @user.full_name.should == "John Doe"
    end
    
    it "should have access to a login_date" do
      @user.login_date.should == @user.last_login_at.strftime("%b %d, %Y")
    end
    
    it "should not throw an error if user never logged in" do
      user = Factory.create(:user, {:first_name => 'John', :last_name => 'Doe', :last_login_at => nil, :role_attributes => {:title => "administrator"}})
      user.login_date.should == ''
    end
  end
  
  describe "accepts_nested_attributes_for" do
     it "should accepts_nested_attributes_for :roles" do
       user = Factory.create(:user, {:role_attributes => {:title => "administrator"}})
       user.role_symbols.should include(:administrator)
     end
   end
   
   describe "declarative authorization" do
     it "should respond to #role_symbols" do
       user = User.new
       user.should respond_to(:role_symbols)
     end
   end
   
   describe "#administrator?" do
     it "should return true if the user is an administrator" do
       user = Factory.create(:user, {:role_attributes => {:title => 'administrator'}})
       user.administrator?.should be_true
     end

     it "should return false if the user is not an administrator" do
       user = Factory.create(:user, {:role_attributes => {:title => 'member'}})
       user.administrator?.should be_false
     end
   end
  
  describe "before_validation methods" do
    
    it "should use email for the login" do
      user = Factory.create(:user, {:email => 'test_valid@mysite.com', :role_attributes => {:title => "administrator"}})
      user.login.should == 'test_valid@mysite.com'
    end
    
  end
  
  describe "deleting users" do
    before do
      @a1 = Factory.create(:user, {:role_attributes => {:title => "administrator"}})
      @a2 = Factory.create(:user, {:role_attributes => {:title => "administrator"}})
    end

    it "should delete an administrator if there are more than 1" do
      @a2.destroy.should be_true
    end

    context "when there is only 1 administrator" do
      it "should not allow delete" do
        @a2.destroy
        @a1.destroy.should be_false
        @a1.errors[:base].should include("last administrator cannot be deleted")
      end

      it "should allow the deletion of the non administrator" do
        @a2.update_attributes({:role_attributes => {:title => "member"}})
        @a2.destroy.should be_true
      end
    end
  end
  
  describe "updating users" do
    before do
      @a1 = Factory.create(:user, {:role_attributes => {:title => "administrator"}})
      @a2 = Factory.create(:user, {:role_attributes => {:title => "administrator"}})
    end

    it "should update the role of an administrator if there are more than 1" do
      @a2.update_attributes({:role_attributes => {:title => "member"}}).should be_true
    end

    context "when there is only 1 adminsitrator" do
      before {@a2.destroy}

      it "should allow update base attribtues" do
        @a1.update_attributes({:first_name => "Bob", :last_name => "Vila"}).should be_true
      end

      it "should not allow update of role of the administrator" do
        @a1.update_attributes({:role_attributes => {:title => "member"}}).should be_false
        @a1.errors[:base].should include("last administrator cannot edit their role")
      end
    end
  end
  
end