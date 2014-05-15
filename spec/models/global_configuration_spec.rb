require 'spec_helper'

describe GlobalConfiguration do
  context 'key does not exists' do
    it '.raise exception' do
      expect {GlobalConfiguration[:not_set]}.to raise_error(GlobalConfiguration::ConfigurationNotFound)
    end
  end
  
  context 'gets/sets values' do
    it '.set values for each type and reads them back' do
      GlobalConfiguration[:age] = 111
      GlobalConfiguration[:age].should == 111
      
      GlobalConfiguration[:email] = 'joe@example.com'
      GlobalConfiguration[:email].should == 'joe@example.com'
      
      GlobalConfiguration[:present] = true
      GlobalConfiguration[:present].should == true
      
      GlobalConfiguration[:present] = false
      GlobalConfiguration[:present].should == false
    end
  end
  
  context 'returns types of the values they are set' do
    it '.Fixnum' do
      GlobalConfiguration[:age] = 111
      GlobalConfiguration[:age].class.should == Fixnum
    end

    it '.String' do
      GlobalConfiguration[:email] = 'joe@example.com'
      GlobalConfiguration[:email].class.should == String
    end
    it '.TrueClass' do
      GlobalConfiguration[:present] = true
      GlobalConfiguration[:present].class.should == TrueClass
    end
    it '.FalseClass' do
      GlobalConfiguration[:present] = false
      GlobalConfiguration[:present].class.should == FalseClass
    end
  end
end
