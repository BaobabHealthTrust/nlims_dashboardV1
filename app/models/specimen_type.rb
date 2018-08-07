class SpecimenType < ApplicationRecord

    def self.check_specimen_type(type)
        rs = SpecimenType.find_by_sql("SELECT * FROM specimen_types WHERE specimen_types.name='#{type}'")
        if rs.length > 0
            return true
        else
            return false
        end
    end

    def self.get_specimen_type_id(type)
        res = SpecimenType.find_by_sql("SELECT specimen_types.id AS tst_id FROM specimen_types WHERE specimen_types.name='#{type}'").first
        return res.tst_id
    end

end
