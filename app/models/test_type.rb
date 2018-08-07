class TestType < ApplicationRecord


    def self.check_test_type(type)
        rs = TestType.find_by_sql("SELECT * FROM test_types WHERE test_types.name='#{type}'")
        if rs.length > 0
            return true
        else
            return false
        end
    end

    def self.get_test_type_id(type)
        res = TestType.find_by_sql("SELECT test_types.id AS tst_id FROM test_types WHERE test_types.name='#{type}'").first
        return res.tst_id
    end

end
