class Measure < ApplicationRecord

    def self.check_measure(type)
        rs = Measure.find_by_sql("SELECT * FROM measures WHERE measures.name='#{type}'")
        if rs.length > 0
            return true
        else
            return false
        end
    end

    def self.get_measure_id(type)
        res = Measure.find_by_sql("SELECT measures.id AS tst_id FROM measures WHERE measures.name='#{type}'").first
        return res.tst_id
    end

end
