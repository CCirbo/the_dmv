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
    return nil unless @services.include?("Vehicle Registration")
    vehicle.assign_registration_date
    vehicle.assign_plate_type
    registration_fee(vehicle)
    @registered_vehicles << vehicle
    @registered_vehicles
  end
end

def registration_fee(vehicle)
    if vehicle.antique?
     @collected_fees += 25
    elsif vehicle.electric_vehicle?
     @collected_fees += 200
    else
     @collected_fees += 100
    end
  end
