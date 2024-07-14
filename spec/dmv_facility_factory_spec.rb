require 'spec_helper'

RSpec.configure do |config| 
 config.formatter = :documentation 
 end

 RSpec.describe DmvFacilityFactory do 
  before(:each) do 
    @colorado_facilities = DmvDataService.new.co_dmv_office_locations
    @dmv_facility_factory = DmvFacilityFactory.new
  end

  describe '#create Colorado facilities' do
    it 'can create bulk Colorado facilities' do
        expect(@dmv_facility_factory.create_facilities(@colorado_facilities)[0]).to be_a(Facility)
        expect(@dmv_facility_factory.create_facilities(@colorado_facilities).length).to eq(5)
    end
  end
end
