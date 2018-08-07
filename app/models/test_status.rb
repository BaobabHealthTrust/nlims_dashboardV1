class TestStatus < ApplicationRecord

    def self.check_test_status(type)
        rs = TestStatus.find_by_sql("SELECT * FROM test_statuses WHERE test_statuses.name='#{type}'")
        if rs.length > 0
            return true
        else
            return false
        end
    end

    def self.get_test_status_id(type)
        res = TestStatus.find_by_sql("SELECT test_statuses.id AS tst_id FROM test_statuses WHERE test_statuses.name='#{type}'").first
        return res.tst_id
    end
end
