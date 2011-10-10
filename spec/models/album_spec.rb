require 'spec_helper'

describe Album do
  it "has many users" do
    u1 = FactoryGirl::create(:user1)
    u2 = FactoryGirl::create(:user2)
    admin = FactoryGirl::create(:admin)
    
    a1 = FactoryGirl::create(:album1)
    a2 = FactoryGirl::create(:album2)
    
    #u1.should be_able_to(:read, a1)
    #u1.should be_able_to(:read, a2)
    #u2.should_not be_able_to(:read, a1)
    #u2.should be_able_to(:read, a2)
    
    #admin.should be_able_to(:read, a1)
    #admin.should be_able_to(:read, a2)
  end
end
