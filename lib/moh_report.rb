module MoHReport
  

    def self.get_statistics(indicator,year,quater)
        period = nil
        
        indicator_data = {}
        indicator_data_haematology = {}
        indicator_data_microbiology =  {}
        indicator_data_serology = {}
        indicator_data_blood_bank = {}
        indicator_data_bio = {}
        indicator_data_parasitology =  {}
        values = ""
        keeper = []
        checker = 0
        months = MoHReport.generate_quater(quater)
        
        if indicator == "blood grouping done on Patients"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "ABO Blood Grouping").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id	
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Grouping' AND test_results.result IS NOT NULL ))"
                                )

                value = res[0].test_count
                data.push(value)
            end            
            return data
        elsif indicator == "Total X-matched"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "Cross-match").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id	
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Pack ABO Group' AND test_results.result IS NOT NULL ))"
                                )

                value = res[0].test_count               
                data.push(value)
            end
            return data
        elsif indicator == "X- matched for matenity"
            data = []
            months.each do |month|
                period = year + "-" + month

                res = TestType.where(name: "Cross-match").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id 
                                INNER JOIN wards ON wards.id = orders.ward_id	
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                ((substr(tests.time_created,1,7) = '#{period}' AND (wards.name = 'EM THEATRE' OR wards.name = 'Labour' OR wards.name = 'OPD' OR wards.name ='PNW')) AND (measures.name = 'Pack ABO Group' AND test_results.result IS NOT NULL ))"
                                )

                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "X-macthed for peads"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "Cross-match").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id 
                                INNER JOIN wards ON wards.id = orders.ward_id	
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                ((substr(tests.time_created,1,7) = '#{period}' AND (wards.name = 'CWA' OR wards.name = 'CWB' OR wards.name = 'CWC' OR wards.name ='EM Nursery' OR wards.name ='Under 5 Clinic')) AND (measures.name = 'Pack ABO Group' AND test_results.result IS NOT NULL ))"
                                )

                value = res[0].test_count
                data.push(value)
            end
            return data

        elsif indicator == "X-matched for others"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "Cross-match").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id 
                                INNER JOIN wards ON wards.id = orders.ward_id	
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                ((substr(tests.time_created,1,7) = '#{period}' AND (wards.name = 'Other')) AND (measures.name = 'Pack ABO Group' AND test_results.result IS NOT NULL ))"
                                )

                value = res[0].test_count
                data.push(value)
            end
            return data

        elsif indicator == "X-matches done on patients with Hb ≤ 6.0g/dl"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "Cross-match").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id 
                                INNER JOIN wards ON wards.id = orders.ward_id	
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                ((substr(tests.time_created,1,7) = '#{period}' ) AND (measures.name = 'Pack ABO Group' AND test_results.result IS NOT NULL ))"
                                )

                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "X-matches done on patients with Hb > 6.0g/dl"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "Cross-match").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id 
                                INNER JOIN wards ON wards.id = orders.ward_id	
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                ((substr(tests.time_created,1,7) = '#{period}' ) AND (measures.name = 'Pack ABO Group' AND test_results.result IS NOT NULL ))"
                                )

                value = res[0].test_count
                data.push(value)
            end
            return data
        
        elsif indicator == "Number of AFB sputum examined"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "TB Microscopic Exam").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "Number of  new TB cases examined"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "New cases with positive smear"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = Measure.where(name: "Smear microscopy result").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND (result = '++' OR result = '+++' OR result = '+' OR result = 'positive'))"
                                )

                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "MTB Not Detected"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result ='MTB NOT DETECTED')"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "RIF Resistant Detected"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result ='RIF Resistant Detected')"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "RIF Resistant Not Detected"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result ='RIF Resistant Not Detected')"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "RIF Resistant Indeterminate"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result ='RIF Resistant Indeterminate')"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "Invalid"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (test_results.result = 'Invalid' OR test_results.result = 'invalid'))"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "No results"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result IS NULL)"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "Number of CSF samples analysed"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "Culture & Sensitivity").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' )"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "Number of CSF samples analysed for AFB"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "Culture & Sensitivity").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result = 'Growth')"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "Number of CSF samples with Organism"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "Culture & Sensitivity").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result = 'Growth')"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "HVS analysed"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = SpecimenType.where(name: "HVS").first
                test_id = res.id
                res = Order.find_by_sql("SELECT count(*) AS test_count FROM 
                                orders WHERE specimen_type_id = '#{test_id}' AND 
                                (substr(date_created,1,7) = '#{period}')"
                                )

                value = res[0].test_count
                data.push(value)
            end            
            return data
        elsif indicator == "Number of Blood Cultures done"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "Culture & Sensitivity").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' )"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "Positive blood Cultures"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "Culture & Sensitivity").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result = 'Growth')"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "Number of tests on microscopy"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "MTB Detected"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result ='MTB DETECTED')"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "India ink positive"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result ='MTB DETECTED')"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "Gram stain positive"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result ='MTB DETECTED')"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "Number of tests on GeneXpert"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result ='MTB DETECTED')"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "Syphilis Test"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "Syphilis Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "Syphilis screening on patients (by depart_option)"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "Syphilis Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "Positive tests^"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "Syphilis Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND ((measures.name = 'TPHA' OR measures.name = 'VDRL' OR measures.name = 'RPR') AND test_results.result ='Reactive' ))"
                                )

                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "Syphilis screening on antenatal mothers"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "Syphilis Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "Positive tests ^"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "Syphilis Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND ((measures.name = 'TPHA' OR measures.name = 'VDRL' OR measures.name = 'RPR') AND test_results.result ='Reactive' ))"
                                )

                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "HepBs test done on patients"
            data = []
            months.each do |month|
                period = year + "-" + month                
                res = TestType.where(name: "Hepatitis B Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "Positive_tests  ^"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "Hepatitis B Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Hepatitis B' AND test_results.result ='Positive' ))"
                                )

                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "HepC test done on patients"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "Hepatitis C Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "Positive tests  ^"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "Hepatitis C Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Hepatitis C' AND test_results.result ='Positive' ))"
                                )

                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "Hcg  Pregnacy tests done"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "Pregnancy Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "Positive tests   ^"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "Pregnancy Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Pregnancy Test' AND test_results.result ='Positive' ))"
                                )

                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "HIV tests on PEP"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "HIV").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count
                data.push(value)
            end
            return data
        elsif indicator == "positives tests    ^"
            data = []
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "HIV").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'HIV STATUS' AND test_results.result ='Positive' ))"
                                )

                value = res[0].test_count
                data.push(value)
            end
            return data
        end	
       


    end


    def self.generate_quater(quater)

        quaters = {
			"q1" => ["01","02","03"],
			"q2" => ["04","05","06"],
			"q3" => ["07","08","09"],
			"q4" => ["10","11","12"]
		}
        return quaters[quater]
    end
end
