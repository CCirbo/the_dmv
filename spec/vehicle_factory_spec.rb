require 'spec_helper'

RSpec.configure do |config| 
 config.formatter = :documentation 
 end

 RSpec.describe VehicleFactory do 
  before(:each) do 
    @factory = VehicleFactory.new
    @wa_ev_registrations = DmvDataService.new.wa_ev_registrations
   
   end

  describe "#create vehicles" do
    it 'can create vehicle objects' do
        expect(@factory.create_vehicles(@wa_ev_registrations)[0]).to be_an(Vehicle)
        expect(@factory.create_vehicles(@wa_ev_registrations)).to be_an(Array)
        expect(@factory.create_vehicles(@wa_ev_registrations).length).to eq(1000)
        # require 'pry'; binding.pry
    end

    it "can create bulk vehicles that work with vehicle class" do
        expect(@factory.create_vehicles(@wa_ev_registrations)[0].vin).to eq("3C3CFFGE5F")
        expect(@factory.create_vehicles(@wa_ev_registrations)[0].year).to eq("2015")
        expect(@factory.create_vehicles(@wa_ev_registrations)[0].make).to eq("FIAT")
        expect(@factory.create_vehicles(@wa_ev_registrations)[0].model).to eq("500")

        expect(@factory.create_vehicles(@wa_ev_registrations)[500].vin).to eq("7SAYGDEEXP")
        expect(@factory.create_vehicles(@wa_ev_registrations)[500].year).to eq("2023")
        expect(@factory.create_vehicles(@wa_ev_registrations)[500].make).to eq("TESLA")
        expect(@factory.create_vehicles(@wa_ev_registrations)[500].model).to eq("Model Y")        
    end
  end
end



 