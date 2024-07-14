require 'spec_helper'

RSpec.configure do |config| 
 config.formatter = :documentation 
 end

 RSpec.describe DmvFacilityFactory do 
  before(:each) do 
    @colorado_facilities = DmvDataService.new.co_dmv_office_locations
    @new_york_facilities = DmvDataService.new.ny_dmv_office_locations
    @missouri_facilities = DmvDataService.new.mo_dmv_office_locations
    @dmv_facility_factory = DmvFacilityFactory.new
  end

  describe '#create multistate facilities' do
    it 'can create bulk Colorado facilities' do
      expect(@dmv_facility_factory.create_facilities(@colorado_facilities)[0]).to be_a(Facility)
      expect(@dmv_facility_factory.create_facilities(@colorado_facilities)).to be_an(Array)
      expect(@dmv_facility_factory.create_facilities(@colorado_facilities).count).to eq(5)
      expect(@dmv_facility_factory.create_facilities(@colorado_facilities)[0].name).to eq("DMV Tremont Branch")
      expect(@dmv_facility_factory.create_facilities(@colorado_facilities)[0].address).to eq("2855 Tremont Place  Denver CO 80205")
      expect(@dmv_facility_factory.create_facilities(@colorado_facilities)[0].phone).to eq("(720) 865-4600")
      expect(@dmv_facility_factory.create_facilities(@colorado_facilities)[0].services).to eq([])
      expect(@dmv_facility_factory.create_facilities(@colorado_facilities)[3].name).to eq("DMV Southwest Branch")
      expect(@dmv_facility_factory.create_facilities(@colorado_facilities)[3].address).to eq("3100 S. Sheridan Blvd.  Denver CO 80227")
    end
  
    it 'can create bulk NY facilities' do
      expect(@dmv_facility_factory.create_facilities(@new_york_facilities)[0]).to be_a(Facility)
      expect(@dmv_facility_factory.create_facilities(@new_york_facilities)).to be_an(Array)
      expect(@dmv_facility_factory.create_facilities(@new_york_facilities).count).to eq(170)
      expect(@dmv_facility_factory.create_facilities(@new_york_facilities)[0].name).to eq("HUNTINGTON")
      expect(@dmv_facility_factory.create_facilities(@new_york_facilities)[0].address).to eq("1815 E JERICHO TURNPIKE  HUNTINGTON NY 11743")
      expect(@dmv_facility_factory.create_facilities(@new_york_facilities)[0].phone).to eq("7184774820")
      expect(@dmv_facility_factory.create_facilities(@new_york_facilities)[0].services).to eq([])
      expect(@dmv_facility_factory.create_facilities(@new_york_facilities)[65].name).to eq("BRONX LICENSE CENTER")
      expect(@dmv_facility_factory.create_facilities(@new_york_facilities)[65].address).to eq("1350 COMMERCE AVE  BRONX NY 10461")
    end

    it 'can create bulk MO facilities' do
      expect(@dmv_facility_factory.create_facilities(@missouri_facilities)[0]).to be_a(Facility)
      expect(@dmv_facility_factory.create_facilities(@missouri_facilities)).to be_an(Array)
      expect(@dmv_facility_factory.create_facilities(@missouri_facilities).count).to eq(178)
      expect(@dmv_facility_factory.create_facilities(@missouri_facilities)[0].name).to eq("FERGUSON-OFFICE CLOSED UNTIL FURTHER NOTICE")
      expect(@dmv_facility_factory.create_facilities(@missouri_facilities)[0].address).to eq("10425 WEST FLORISSANT FERGUSON MO 63136")
      expect(@dmv_facility_factory.create_facilities(@missouri_facilities)[0].phone).to eq("(314) 733-5316")
      expect(@dmv_facility_factory.create_facilities(@missouri_facilities)[0].services).to eq([])
      expect(@dmv_facility_factory.create_facilities(@missouri_facilities)[87].name).to eq("COLUMBIA")
      expect(@dmv_facility_factory.create_facilities(@missouri_facilities)[87].address).to eq("403 VANDIVER SUITE B COLUMBIA MO 65202")
    end
  end
end
