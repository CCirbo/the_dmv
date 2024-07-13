require 'spec_helper'

RSpec.configure do |config|
  config.formatter = :documentation 
  end

RSpec.describe Registrant do
  before(:each) do
    @registrant_1 = Registrant.new('Bruce', 18, true )
    @registrant_2 = Registrant.new('Penny', 16 )
    @registrant_3 = Registrant.new('Tucker', 15 )

  end

  describe '#initialize' do
    it 'can initialize and have attributes' do
      expect(@registrant_1).to be_an_instance_of(Registrant)
      expect(@registrant_1.name).to eq("Bruce")
      expect(@registrant_1.age).to eq(18)
    end

    it 'can have another registrant with attributes' do
        expect(@registrant_2.name).to eq("Penny")
        expect(@registrant_2.age).to eq(16)
        expect(@registrant_3.name).to eq("Tucker")
        expect(@registrant_3.age).to eq(15)
    end
  end
   
  describe '#permit?' do
    it 'checks whether registrant has a permit or not' do
        expect(@registrant_1.permit?).to eq(true)   
        expect(@registrant_2.permit?).to eq(false) 
        expect(@registrant_3.permit?).to eq(false)
    end
  end

  describe '#license data' do
    it 'can show status of registrant license info' do
        expect(@registrant_1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
        expect(@registrant_2.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
        expect(@registrant_3.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end
  end

  describe '#earn permit' do
    it 'changes permit status' do
        @registrant_2.earn_permit
        expect(@registrant_2.permit?).to eq(true)
    end
  end
end

