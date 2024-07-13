require 'spec_helper'

RSpec.configure do |config|
  config.formatter = :documentation 
  end

RSpec.describe Facility do
  before(:each) do
    @facility = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
    @cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
    @bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
    @camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
    @registrant_1 = Registrant.new('Bruce', 18, true )
    @registrant_2 = Registrant.new('Penny', 16 )
    @registrant_3 = Registrant.new('Tucker', 15 )

  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@facility).to be_an_instance_of(Facility)
      expect(@facility.name).to eq('DMV Tremont Branch')
      expect(@facility.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility.phone).to eq('(720) 865-4600')
      expect(@facility.services).to eq([])
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility.services).to eq([])
      @facility.add_service('New Drivers License')
      @facility.add_service('Renew Drivers License')
      @facility.add_service('Vehicle Registration')
      expect(@facility.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end

    it 'can add available services to another facility' do
      @facility_1.add_service('New Drivers License')
      @facility_1.add_service('Vehicle Registration')
      expect(@facility_1.services).to eq(['New Drivers License', 'Vehicle Registration'])

      @facility_2.add_service('New Drivers License')
      @facility_2.add_service('Renew Drivers License')
      expect(@facility_2.services).to eq(['New Drivers License','Renew Drivers License'])
    end
  end

  describe '#vehicles services' do
    before(:each) do
      @facility_1.add_service('Vehicle Registration')
      # @facility_1.register_vehicle(@cruz)
    end
    
    it 'it can register vehicles of any kind if service is offered' do
      expect(@facility_1.registered_vehicles).to eq([])
      @facility_1.register_vehicle(@cruz)
      expect(@facility_1.registered_vehicles).to eq([@cruz])
      @facility_1.register_vehicle(@camaro)
      @facility_1.register_vehicle(@bolt)
      expect(@facility_1.registered_vehicles).to eq([@cruz, @camaro, @bolt])
    end

    it 'cannot perform service if service is not offered at facility' do
      expect(@facility_2.registered_vehicles).to eq([])
      @facility_2.register_vehicle(@cruz)
      expect(@facility_2.registered_vehicles).to eq([])
    end

    it 'can update registration date when vehicle is registered' do
      @facility_1.register_vehicle(@cruz)
      expect(@cruz.registration_date).to eq(Date.today)

      @facility_1.register_vehicle(@camaro)
      expect(@camaro.registration_date).to eq(Date.today)

      @facility_1.register_vehicle(@bolt)
      expect(@bolt.registration_date).to eq(Date.today)
    end

    it 'assigns a license plate based on car type when registered' do
      @facility_1.register_vehicle(@cruz)
      expect(@cruz.plate_type).to eq(:regular)

      @facility_1.register_vehicle(@camaro)
      expect(@camaro.plate_type).to eq(:antique)

      @facility_1.register_vehicle(@bolt)
      expect(@bolt.plate_type).to eq(:ev)
    end

    it 'can collect vehicle registration fees for all vehicles' do
      expect(@facility_1.collected_fees).to eq(0)
      @facility_1.register_vehicle(@cruz)
      expect(@facility_1.collected_fees).to eq(100)

      @facility_1.register_vehicle(@camaro)
      @facility_1.register_vehicle(@bolt)
      expect(@facility_1.collected_fees).to eq(325)
    end

  describe '#Written testing services' do
    it 'can administer a Written Test if you have a permit' do
      expect(@facility_1.administer_written_test(@registrant_1)).to eq(false)
      @facility_1.add_service('Written Test')
      expect(@facility_1.administer_written_test(@registrant_1)).to eq(true)
      expect(@registrant_1.license_data[:written]).to eq(true)
      expect(@registrant_1.license_data).to eq({:written=>true, :license=>false, :renewed=>false})
    end

    it 'can adminster a Written Test if you earn a permit' do
      expect(@registrant_2.permit?).to eq(false)
      expect(@facility_1.administer_written_test(@registrant_2)).to eq(false)
      @facility_1.add_service('Written Test')
      @registrant_2.earn_permit
      expect(@facility_1.administer_written_test(@registrant_2)).to eq(true)
      expect(@registrant_2.license_data).to eq({:written=>true, :license=>false, :renewed=>false})
    end

    it 'will not adminster a Written Test if you do not have a permit' do
      expect(@registrant_3.permit?).to eq(false)
      expect(@facility_1.administer_written_test(@registrant_3)).to eq(false)
      @facility_1.add_service('Written Test')
      @registrant_3.earn_permit
      expect(@facility_1.administer_written_test(@registrant_3)).to eq(false)
      expect(@registrant_3.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end
  end

  describe "#Road Testing services" do
    before(:each) do
      @facility_1.add_service('Written Test')
      @facility_1.add_service('Road Test')
    end
    
      it 'will not administer Road Test if Written Test is not earned' do
      expect(@facility_1.administer_road_test(@registrant_3)).to eq(false)
      @registrant_3.earn_permit
      expect(@facility_1.administer_road_test(@registrant_3)).to eq(false)
      expect(@registrant_3.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end

    it 'will adminster Road Test if Written test is earned' do
      expect(@facility_1.administer_road_test(@registrant_1)).to eq(false)
      expect(@facility_1.services).to eq(["Written Test", "Road Test"])

      @facility_1.administer_written_test(@registrant_1)
      @facility_1.administer_road_test(@registrant_1)
      expect(@facility_1.administer_road_test(@registrant_1)).to eq(true)
      expect(@registrant_1.license_data).to eq({:written=>true, :license=>true, :renewed=>false})
    end

    it 'will adminster Road Test if Written Test is earned to another registrant' do
      @registrant_2.earn_permit
      @facility_1.administer_written_test(@registrant_2)
      @facility_1.administer_road_test(@registrant_2)
      expect(@facility_1.administer_road_test(@registrant_2)).to eq(true)
      expect(@registrant_2.license_data).to eq({:written=>true, :license=>true, :renewed=>false})
    end
  end

  describe '#Renew License' do
    before(:each) do
      @facility_1.add_service('Written Test')
      @facility_1.add_service('Road Test')
      @facility_1.add_service('Renew License')
    end

    it 'will Renew License if registrant has taken a Written Test and Road Test' do
      expect(@facility_1.renew_drivers_license(@registrant_1)).to eq(false)
      expect(@facility_1.services).to eq(['Written Test', 'Road Test', 'Renew License'])

      @facility_1.administer_written_test(@registrant_1)
      @facility_1.administer_road_test(@registrant_1)

      expect(@facility_1.renew_drivers_license(@registrant_1)).to eq(true)
      expect(@registrant_1.license_data).to eq({:written=>true, :license=>true, :renewed=>true})
    end

    it 'will Renew License for another registrant if they have a Written and Road Test' do
      @registrant_2.earn_permit
      @facility_1.administer_written_test(@registrant_2)
      @facility_1.administer_road_test(@registrant_2)

      expect(@facility_1.renew_drivers_license(@registrant_2)).to eq(true)
      expect(@registrant_2.license_data).to eq({:written=>true, :license=>true, :renewed=>true})
    end
    
    it 'will not Renew License if registrant is missing the Written or Road Test' do
      expect(@facility_1.renew_drivers_license(@registrant_3)).to eq(false)
      expect(@registrant_3.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end
  end
end


