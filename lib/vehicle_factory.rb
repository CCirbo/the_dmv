class VehicleFactory 
 
    def create_vehicles(bulk_vehicle_details)
        bulk_vehicle_details.map do |vehicle_details|
         Vehicle.new(
                vin: vehicle_details[:vin_1_10],
                year: vehicle_details[:model_year],
                make: vehicle_details[:make],
                model: vehicle_details[:model],
                engine: :ev
                )
        end
    end
end
# @vin = vehicle_details[:vin]
# @year = vehicle_details[:year]
# @make = vehicle_details[:make]
# @model = vehicle_details[:model]
# @engine = vehicle_details[:engine]