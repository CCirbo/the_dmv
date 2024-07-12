class Facility
  attr_reader :name, 
              :address, 
              :phone, 
              :services,
              :registered_vehicles,
              :collected_fees

  def initialize(facility)
    @name = facility[:name]
    @address = facility[:address]
    @phone = facility[:phone]
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
    # return nil unless #facility has Vehicle registration
    # require 'pry'; binding.pry
    @registered_vehicles << vehicle
    @registered_vehicles
  end
end

#helper method for plate type
#helper method for registration fee

# Register a vehicle
# Vehicles have the following rules:
# Vehicles 25 years old or older are considered 
# antique and cost $25 to register

# Electric Vehicles (EV) cost $200 to register

# All other vehicles cost $100 to register

# A vehicle’s plate_type should be set to :regular, 
# :antique, or :ev upon successful registration.