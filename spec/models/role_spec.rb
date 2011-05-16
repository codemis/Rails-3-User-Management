require 'spec_helper'

describe Role do
  
  describe "database" do
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:user_id).of_type(:integer) }

    describe "indexes" do
      it { should have_db_index(:user_id) }
    end
  end
  
  describe "relationships" do
    it {should belong_to(:user)}
  end
  
  describe "validates" do
    it {should_not allow_value("Other").for(:title)}

    User::ROLES.each do |r|
      it {should allow_value(r[1]).for(:title)}
    end
  end
  
end
