module TestCatelog

    def self.retrieve_specimen_types
        rst = SpecimenType.find_by_sql("SELECT specimen_types.id AS tst_id, specimen_types.name AS spc_name FROM specimen_types")
        

        rt = rst
        results = []
        rst.each do |t|
            
           results.push(TestCatelog.calculate_specimen_type_frequency(t.tst_id))
           
        end

        if rst.length > 0
            return [rt,results]
        else
            return false
        end
    end

    def self.retrieve_test_Categories
        res = TestCategory.find_by_sql("SELECT test_categories.name AS c_name, test_categories.id AS c_id FROM test_categories")
        return res
    end

    def self.retrieve_test_types
        rst = TestType.find_by_sql("SELECT test_types.id AS tst_id, test_types.name AS tst_name, test_types.short_name AS short, test_types.targetTAT AS tat,
                                      test_categories.name AS cat_name FROM test_types INNER JOIN test_categories
                                      ON test_categories.id = test_types.test_category_id")
       
        rt = rst
        results = []
        rst.each do |t|
            
           results.push(TestCatelog.calculate_test_type_frequency(t.tst_id))
           
        end

        if rst.length > 0
            return [rt,results]
        else
            return false
        end
    end


    def self.total_tests
        rst = Test.find_by_sql("SELECT count(*) AS total FROM tests")
        return rst[0].total
    end

    def self.calculate_test_type_frequency(id)
        rst = Test.find_by_sql("SELECT count(*) AS total FROM tests WHERE tests.test_type_id='#{id}'")
        fre = "%.1f" % ((rst[0].total.to_f / TestCatelog.total_tests.to_f) * 100)
        return fre
    end


    def self.total_specimens
        rst = Test.find_by_sql("SELECT count(*) AS total FROM orders")
        return rst[0].total
    end

    def self.calculate_specimen_type_frequency(id)
        rst = SpecimenType.find_by_sql("SELECT count(*) AS total FROM orders WHERE orders.specimen_type_id='#{id}'")
        fre = "%.1f" % ((rst[0].total.to_f / TestCatelog.total_specimens.to_f) * 100)
        return fre
    end



    def self.retrieve_specimen_test_types(type)
        return true
    end


    def self.count_anomalises_specimen_type
        rs =    SlaveOrder.find_by_sql("SELECT count(*) AS total FROM slave_orders WHERE slave_orders.sample_type_resolved_to='not-resolved'")
        return  rs[0].total
    end


    def self.count_anomalises_test_types
        rs = SlaveTest.find_by_sql("SELECT count(*) AS total FROM slave_tests WHERE slave_tests.test_type_resolved_to='not-resolved'")
        return rs[0].total
    end

    def self.count_anomalises_measures
        rs = SlaveTestResult.find_by_sql("SELECT count(*) AS total FROM slave_test_results WHERE slave_test_results.measure_resolved_to='not-resolved'")
        return rs[0].total
    end


    def self.pull_unresolved_specimen
        res = SlaveOrder.find_by_sql("SELECT DISTINCT sending_facility AS fac,sample_type AS sample FROM slave_orders WHERE slave_orders.sample_type_resolved_to='not-resolved'")
    end


    def self.pull_unresolved_test_types
        res = SlaveTest.find_by_sql("SELECT DISTINCT slave_orders.sending_facility AS fac, slave_tests.test_type AS tes FROM slave_tests
                                     INNER JOIN slave_orders ON slave_orders.id = slave_tests.id 
                                     WHERE slave_tests.test_type_resolved_to='not-resolved'")
        return res
    end

    def self.pull_unresolved_measures
        res = SlaveTestResult.find_by_sql("SELECT DISTINCT slave_orders.sending_facility AS fac, slave_test_results.measure AS tes FROM slave_test_results
        INNER JOIN slave_orders ON slave_orders.id = slave_test_results.id 
        WHERE slave_test_results.measure_resolved_to='not-resolved'")
        return res
    end


    def self.capture_possible_matches(value)
        first = value[0,3]
        rs = SpecimenType.find_by_sql("SELECT DISTINCT specimen_types.name AS sample FROM specimen_types WHERE specimen_types.name LIKE '#{first}%' OR specimen_types.name LIKE '%#{first}%'")
        if rs.length > 0
            return rs
        else
            return false
        end
    end

    def self.capture_possible_test_type_matches(value)
        first = value[0,3]
        rs = TestType.find_by_sql("SELECT DISTINCT test_types.name AS sample FROM test_types WHERE (test_types.name LIKE '#{first}%' OR test_types.name LIKE '#{value[0,1]}%') OR test_types.name LIKE '%#{first}%'")
        if rs.length > 0
            return rs
        else
            return false
        end
    end


    def self.add_resolved(type,value, category, tat, short_name)
        
       
        if type == "specimen_type"
          
            ord = SpecimenType.new
            ord.name = value
            ord.doc_id = "10101"
            ord.save

            SlaveOrder.where(sample_type: value).update_all(sample_type_resolved_to: value)
        elsif type == "test_type"
            ord = TestType.new
            ord.test_category_id =  category
            ord.name = value
            ord.short_name  = short_name
            ord.targetTAT = tat      
            ord.doc_id = "10101"
            ord.save

            SlaveTest.where(test_type: value).update_all(test_type_resolved_to: value)
        end
    end


    def self.merge_resolved(type,merge_value,actual_value)
        if type == "specimen_type"
            SlaveOrder.where(sample_type: actual_value).update_all(sample_type_resolved_to: merge_value)
        else

        end

    end

end