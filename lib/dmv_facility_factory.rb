
  class DmvFacilityFactory

    def create_facilities(bulk_facilities)
        state = bulk_facilities.first[:state]
        if state == "CO"
            build_co_facilities(bulk_facilities)
        elsif state == "MO"
            build_mo_facilities(bulk_facilities)
        elsif state == "NY"
            build_ny_facilities(bulk_facilities)
        else
            []
        end
    end

    def build_co_facilities(bulk_facilities)
        bulk_facilities.map do |facility|
            facility_information = {
                name: facility[:dmv_office],
                address:"#{facility[:address_li]} #{facility[:address_1]} #{facility[:city]} #{facility[:state]} #{facility[:zip]}",
                phone: facility[:phone],
                services: facility[:services_p]
            }
            Facility.new(facility_information)
        end
    end

    
   
end