module MoHReport
  

    def self.by_facility(facility,depart_option, year, quater)
        period = nil
        data = {}
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

        if depart_option == "all"

				
                months = MoHReport.generate_quater(quater)
            
                months.each do |month|
                    period = year + "-" + month
                            
						
						res = TestType.where(name: "FBC").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND	(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[0] = value.to_s
						else
							keeper[0] = keeper[0] + "_" + value.to_s
						end
					

						res = TestType.where(name: "ESR").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND (substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
						if checker == 0
							keeper[1] = value.to_s
						else
							keeper[1] = keeper[1] + "_" + value.to_s
						end
					


						res = TestType.where(name: "Sickling Test").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND	(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
						if checker == 0
							keeper[2] = value.to_s
						else
							keeper[2] = keeper[2] + "_" + value.to_s
						end
					


						res = TestType.where(name: "Prothrombin Time").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND	(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
						if checker == 0
							keeper[3] = value.to_s
						else
							keeper[3] = keeper[3] + "_" + value.to_s
						end
					


						res = TestType.where(name: "APTT").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND (substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
						if checker == 0
							keeper[4] = value.to_s
						else
							keeper[4] = keeper[4] + "_" + value.to_s
						end
					

						indicator_data_haematology['Full Blood Count'] =  keeper[0]
						indicator_data_haematology['Erythrocyte Sedimentation Rate (ESR)'] =  keeper[1]
						indicator_data_haematology['Sickling Test'] =  keeper[2]
						indicator_data_haematology['Prothrombin time (PT)'] =  keeper[3]
						indicator_data_haematology['Activated Partial Thromboplastin Time (APTT)'] =  keeper[4]
						data["Haematology"] =  indicator_data_haematology




						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Blood film' AND test_results.result !='0' ))"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[5] = value.to_s
						else
							keeper[5] = keeper[5] + "_" + value.to_s
						end

						per = period + "-28"
						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Blood film' AND (((DATEDIFF('#{per}',patients.dob) / 365) < 5.5) AND test_results.result !='0')))"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[6] = value.to_s
						else
							keeper[6] = keeper[6] + "_" + value.to_s
						end


						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Blood film' AND (DATEDIFF('#{per}',patients.dob) / 365) < 5.5) 
										AND  test_results.result != 'No parasite seen')"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[7] = value.to_s
						else
							keeper[7] = keeper[7] + "_" + value.to_s
						end


						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Blood film' AND patients.dob = 'NaNNaNNaNNaNNaNNaN' ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[8] = value.to_s
						else
							keeper[8] = keeper[8] + "_" + value.to_s
						end



						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Blood film' AND (patients.dob = 'NaNNaNNaNNaNNaNNaN' AND test_results.result != 'No parasite seen')))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[9] = value.to_s
						else
							keeper[9] = keeper[9] + "_" + value.to_s
						end



						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND test_results.result !='0' ))"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[10] = value.to_s
						else
							keeper[10] = keeper[10] + "_" + value.to_s
						end




						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND test_results.result ='Positive' ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[11] = value.to_s
						else
							keeper[11] = keeper[11] + "_" + value.to_s
						end



						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND (((DATEDIFF('#{per}',patients.dob) / 365) <= 5.5) AND test_results.result !='0')))"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[12] = value.to_s
						else
							keeper[12] = keeper[12] + "_" + value.to_s
						end


						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND (((DATEDIFF('#{per}',patients.dob) / 365) <= 5.5) AND test_results.result ='Positive') ))"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[13] = value.to_s
						else
							keeper[13] = keeper[13] + "_" + value.to_s
						end



						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND (((DATEDIFF('#{per}',patients.dob) / 365) >= 5.5) AND test_results.result !='0')))"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[14] = value.to_s
						else
							keeper[14] = keeper[14] + "_" + value.to_s
						end


						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND (((DATEDIFF('#{per}',patients.dob) / 365) >= 5.5) AND test_results.result ='Positive') ))"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[15] = value.to_s
						else
							keeper[15] = keeper[15] + "_" + value.to_s
						end



						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND test_results.result ='Invalid' ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[16] = value.to_s
						else
							keeper[16] = keeper[16] + "_" + value.to_s
						end


						res = TestType.where(name: "Urine Microscopy").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' )"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[17] = value.to_s
						else
							keeper[17] = keeper[17] + "_" + value.to_s
						end



						res = TestType.where(name: "Semen Analysis").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' )"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[18] = value.to_s
						else
							keeper[18] = keeper[18] + "_" + value.to_s
						end

						
						indicator_data_parasitology['Total malaria microscopy tests done'] =  keeper[5]
						indicator_data_parasitology['Malaria microscopy in ≤ 5yrs (by species)?'] =  keeper[6]
						indicator_data_parasitology['Positive malaria slides in < 5yrs'] =  keeper[7]
						indicator_data_parasitology['Malaria microscopy in unknown age'] =  keeper[8]
						indicator_data_parasitology['Positive malaria slides in unknown age'] =  keeper[9]
						indicator_data_parasitology['Total MRDTs Done'] =  keeper[10]
						indicator_data_parasitology['MRDTs Positives'] =  keeper[11]
						indicator_data_parasitology['MRDTs in ≤  5yrs'] =  keeper[12]
						indicator_data_parasitology['MRDT Positives in < 5yrs'] =  keeper[13] 
						indicator_data_parasitology['MRDTs in >= 5yrs'] =  keeper[14] 
						indicator_data_parasitology['MRDT Positives in > 5yrs'] =  keeper[15] 
						indicator_data_parasitology['Total invalid MRDTs tests'] =  keeper[16] 
						indicator_data_parasitology['Trypanosome tests'] = keeper[16] 
						indicator_data_parasitology['Positive tests'] =  keeper[16] 
						indicator_data_parasitology['Urine microscopy total'] =  keeper[17] 
						indicator_data_parasitology['Schistosome Haematobium'] =  keeper[16]   
						indicator_data_parasitology['Other urine parasites'] =  keeper[16]  
						indicator_data_parasitology['urine chemistry (count)'] =  keeper[16]
						indicator_data_parasitology['Semen analysis (count)'] =  keeper[18]
						indicator_data_parasitology['Blood Parasites (count)'] = keeper[5]
						indicator_data_parasitology['Blood Parasites seen'] = keeper[6]
						indicator_data_parasitology['Stool Microscopy (count)'] =  keeper[6]
						indicator_data_parasitology['Stool Microscopy Parasites seen'] =  keeper[6]

						data["Parasitology"] =  indicator_data_parasitology






						res = TestType.where(name: "ABO Blood Grouping").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id	
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Grouping' AND test_results.result IS NOT NULL ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[19] = value.to_s
						else
							keeper[19] = keeper[19] + "_" + value.to_s
						end


						res = TestType.where(name: "Cross-match").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id	
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Pack ABO Group' AND test_results.result IS NOT NULL ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[20] = value.to_s
						else
							keeper[20] = keeper[20] + "_" + value.to_s
						end



						res = TestType.where(name: "Cross-match").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id 
										INNER JOIN wards ON wards.id = orders.ward_id	
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										((substr(tests.time_created,1,7) = '#{period}' AND (wards.name = 'EM THEATRE' OR wards.name = 'Labour' OR wards.name = 'OPD' OR wards.name ='PNW')) AND (measures.name = 'Pack ABO Group' AND test_results.result IS NOT NULL ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[21] = value.to_s
						else
							keeper[21] = keeper[21] + "_" + value.to_s
						end




						res = TestType.where(name: "Cross-match").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id 
										INNER JOIN wards ON wards.id = orders.ward_id	
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										((substr(tests.time_created,1,7) = '#{period}' AND (wards.name = 'CWA' OR wards.name = 'CWB' OR wards.name = 'CWC' OR wards.name ='EM Nursery' OR wards.name ='Under 5 Clinic')) AND (measures.name = 'Pack ABO Group' AND test_results.result IS NOT NULL ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[22] = value.to_s
						else
							keeper[22] = keeper[22] + "_" + value.to_s
						end


						res = TestType.where(name: "Cross-match").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id 
										INNER JOIN wards ON wards.id = orders.ward_id	
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										((substr(tests.time_created,1,7) = '#{period}' AND (wards.name = 'Other')) AND (measures.name = 'Pack ABO Group' AND test_results.result IS NOT NULL ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[23] = value.to_s
						else
							keeper[23] = keeper[23] + "_" + value.to_s
						end



						res = TestType.where(name: "Cross-match").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id 
										INNER JOIN wards ON wards.id = orders.ward_id	
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										((substr(tests.time_created,1,7) = '#{period}' ) AND (measures.name = 'Pack ABO Group' AND test_results.result IS NULL ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[24] = value.to_s
						else
							keeper[24] = keeper[24] + "_" + value.to_s
						end


						res = TestType.where(name: "Cross-match").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id 
										INNER JOIN wards ON wards.id = orders.ward_id	
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										((substr(tests.time_created,1,7) = '#{period}' ) AND (measures.name = 'Pack ABO Group' AND test_results.result IS NULL ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[25] = value.to_s
						else
							keeper[25] = keeper[25] + "_" + value.to_s
						end


						
					
						indicator_data_blood_bank['blood grouping done on Patients'] =  keeper[19]
						indicator_data_blood_bank['Total X-matched'] =  keeper[20]
						indicator_data_blood_bank['X- matched for matenity'] =  keeper[21]
						indicator_data_blood_bank['X-macthed for peads'] =  keeper[22]
						indicator_data_blood_bank['X-matched for others'] =  keeper[23]
						indicator_data_blood_bank['X-matches done on patients with Hb ≤ 6.0g/dl'] =  keeper[24]
						indicator_data_blood_bank['X-matches done on patients with Hb > 6.0g/dl'] =  keeper[25]

						data["Blood Bank"] =  indicator_data_blood_bank









						res = TestType.where(name: "Syphilis Test").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests WHERE test_type_id = '#{test_id}' AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[26] = value.to_s
						else
							keeper[26] = keeper[26] + "_" + value.to_s
						end
						

						res = TestType.where(name: "Syphilis Test").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND ((measures.name = 'TPHA' OR measures.name = 'VDRL' OR measures.name = 'RPR') AND test_results.result ='Reactive' ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[27] = value.to_s
						else
							keeper[27] = keeper[27] + "_" + value.to_s
						end



						res = TestType.where(name: "Hepatitis B Test").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[28] = value.to_s
						else
							keeper[28] = keeper[28] + "_" + value.to_s
						end
						

						res = TestType.where(name: "Hepatitis B Test").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Hepatitis B' AND test_results.result ='Positive' ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[29] = value.to_s
						else
							keeper[29] = keeper[29] + "_" + value.to_s
						end



						res = TestType.where(name: "Hepatitis C Test").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[30] = value.to_s
						else
							keeper[30] = keeper[30] + "_" + value.to_s
						end
							

						res = TestType.where(name: "Hepatitis C Test").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Hepatitis C' AND test_results.result ='Positive' ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[31] = value.to_s
						else
							keeper[31] = keeper[31] + "_" + value.to_s
						end

						

						res = TestType.where(name: "Pregnancy Test").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[32] = value.to_s
						else
							keeper[32] = keeper[32] + "_" + value.to_s
						end
							


						res = TestType.where(name: "Pregnancy Test").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Pregnancy Test' AND test_results.result ='Positive' ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[33] = value.to_s
						else
							keeper[33] = keeper[33] + "_" + value.to_s
						end


						res = TestType.where(name: "HIV").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[34] = value.to_s
						else
							keeper[34] = keeper[34] + "_" + value.to_s
						end



						res = TestType.where(name: "HIV").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'HIV STATUS' AND test_results.result ='Positive' ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[35] = value.to_s
						else
							keeper[35] = keeper[35] + "_" + value.to_s
						end

						
						indicator_data_serology['Syphilis Test'] =  keeper[26]
						indicator_data_serology['Syphilis screening on patients (by depart_option)'] =  keeper[26]
						indicator_data_serology['Positive tests^'] =  keeper[27]
						indicator_data_serology['Syphilis screening on antenatal mothers'] =  keeper[26]
						indicator_data_serology['Positive tests ^'] =  keeper[26]
						indicator_data_serology['HepBs test done on patients'] =  keeper[28]
						indicator_data_serology['Positive_tests  ^'] =  keeper[29]
						indicator_data_serology['HepC test done on patients'] =  keeper[30]
						indicator_data_serology['Positive tests  ^'] =  keeper[31]
						indicator_data_serology['Hcg  Pregnacy tests done'] =  keeper[32]
						indicator_data_serology['Positive tests   ^'] =  keeper[33]
						indicator_data_serology['HIV tests on PEP'] =  keeper[34]
						indicator_data_serology['positives tests    ^'] =  keeper[35]

						data["Serology"] =  indicator_data_serology









						res = TestType.where(name: "Glucose").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[36] = value.to_s
						else
							keeper[36] = keeper[36] + "_" + value.to_s
						end

						res = TestType.where(name: "Glucose").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[37] = value.to_s
						else
							keeper[37] = keeper[37] + "_" + value.to_s
						end

						res = TestType.where(name: "Total Protein").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[38] = value.to_s
						else
							keeper[38] = keeper[38] + "_" + value.to_s
						end

						res = Measure.where(name: "Albumin(ALB)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[39] = value.to_s
						else
							keeper[39] = keeper[39] + "_" + value.to_s
						end


						res = Measure.where(name: "Alkaline Phosphate(ALP)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[40] = value.to_s
						else
							keeper[40] = keeper[40] + "_" + value.to_s
						end




						res = Measure.where(name: "ALT/GPT").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[41] = value.to_s
						else
							keeper[41] = keeper[41] + "_" + value.to_s
						end


						res = Measure.where(name: "Amylase").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[42] = value.to_s
						else
							keeper[42] = keeper[42] + "_" + value.to_s
						end



						
						
						res = Measure.where(name: "Antistreptolysin O (ASO)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[43] = value.to_s
						else
							keeper[43] = keeper[43] + "_" + value.to_s
						end



						res = Measure.where(name: "AST/GOT").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[44] = value.to_s
						else
							keeper[44] = keeper[44] + "_" + value.to_s
						end


						res = Measure.where(name: "Bilirubin Total(BIT))").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[45] = value.to_s
						else
							keeper[45] = keeper[45] + "_" + value.to_s
						end


						res = Measure.where(name: "Bilirubin Direct(BID)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[46] = value.to_s
						else
							keeper[46] = keeper[46] + "_" + value.to_s
						end


						res = TestType.where(name: "Calcium").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND  
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[47] = value.to_s
						else
							keeper[47] = keeper[47] + "_" + value.to_s
						end



						res = Measure.where(name: "Chloride").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[48] = value.to_s
						else
							keeper[48] = keeper[48] + "_" + value.to_s
						end



						res = Measure.where(name: "Cholestero l(CHOL)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND  
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[49] = value.to_s
						else
							keeper[49] = keeper[49] + "_" + value.to_s
						end


						res = Measure.where(name: "Cholestero l(CHOL)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[50] = value.to_s
						else
							keeper[50] = keeper[50] + "_" + value.to_s
						end


						res = Measure.where(name: "Cholestero l(CHOL)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND  
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[51] = value.to_s
						else
							keeper[51] = keeper[51] + "_" + value.to_s
						end


						res = Measure.where(name: "Cholestero l(CHOL)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[52] = value.to_s
						else
							keeper[52] = keeper[52] + "_" + value.to_s
						end


						res = TestType.where(name: "C-reactive protein").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[53] = value.to_s
						else
							keeper[53] = keeper[53] + "_" + value.to_s
						end


						res = TestType.where(name: "Creatinine").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[54] = value.to_s
						else
							keeper[54] = keeper[54] + "_" + value.to_s
						end



						res = Measure.where(name: "Creatine Kinase(CKN)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[55] = value.to_s
						else
							keeper[55] = keeper[55] + "_" + value.to_s
						end
					

						res = Measure.where(name: "Creatine Kinase MB(CKMB)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[56] = value.to_s
						else
							keeper[56] = keeper[56] + "_" + value.to_s
						end



						res = TestType.where(name: "HbA1c").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[57] = value.to_s
						else
							keeper[57] = keeper[57] + "_" + value.to_s
						end

						

						res = TestType.where(name: "Iron Studies").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[58] = value.to_s
						else
							keeper[58] = keeper[58] + "_" + value.to_s
						end

						
						res = Measure.where(name: "Lipase").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[59] = value.to_s
						else
							keeper[59] = keeper[59] + "_" + value.to_s
						end						
						

						res = Measure.where(name: "LDH").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[60] = value.to_s
						else
							keeper[60] = keeper[60] + "_" + value.to_s
						end						
						


						res = Measure.where(name: "Magnesium (MGXB)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[61] = value.to_s
						else
							keeper[61] = keeper[61] + "_" + value.to_s
						end						
						


						res = TestType.where(name: "Microprotein").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[62] = value.to_s
						else
							keeper[62] = keeper[62] + "_" + value.to_s
						end


						res = TestType.where(name: "Microalbumin").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[63] = value.to_s
						else
							keeper[63] = keeper[63] + "_" + value.to_s
						end


						res = TestType.where(name: "Phosphorus").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[64] = value.to_s
						else
							keeper[64] = keeper[64] + "_" + value.to_s
						end
						
						

						res = Measure.where(name: "Potassium").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[65] = value.to_s
						else
							keeper[65] = keeper[65] + "_" + value.to_s
						end	



						res = TestType.where(name: "Rheumatoid Factor Test").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[66] = value.to_s
						else
							keeper[66] = keeper[66] + "_" + value.to_s
						end


						res = Measure.where(name: "Sodium").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[67] = value.to_s
						else
							keeper[67] = keeper[67] + "_" + value.to_s
						end	


						res = Measure.where(name: "Triglycerides(TG)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[68] = value.to_s
						else
							keeper[68] = keeper[68] + "_" + value.to_s
						end	


						res = TestType.where(name: "Urea").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[69] = value.to_s
						else
							keeper[69] = keeper[69] + "_" + value.to_s
						end


						res = TestType.where(name: "Uric Acid").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[70] = value.to_s
						else
							keeper[70] = keeper[70] + "_" + value.to_s
						end

						checker = checker + 1
						indicator_data_bio['Blood glucose'] =  keeper[36]
						indicator_data_bio['CSF glucose'] =  keeper[37]
						indicator_data_bio['Total Protein'] =  keeper[38]
						indicator_data_bio['Albumin'] =  keeper[39]
						indicator_data_bio['Alkaline Phosphatase(ALP)'] =  keeper[40]
						indicator_data_bio['Alanine aminotransferase (ALT)'] =  keeper[41]
						indicator_data_bio['Amylase'] =  keeper[42]
						indicator_data_bio['Antistreptolysin O (ASO)'] =  keeper[43]
						indicator_data_bio['Aspartate aminotransferase(AST)'] =  keeper[44]
						indicator_data_bio['Bilirubin Total'] =  keeper[45]
						indicator_data_bio['Bilirubin Direct'] =  keeper[46]
						indicator_data_bio['Calcium'] =  keeper[47]
						indicator_data_bio['Chloride'] =  keeper[48]
						indicator_data_bio['Cholesterol Total'] =  keeper[49]
						indicator_data_bio['Cholesterol LDL'] =  keeper[50]
						indicator_data_bio['Cholesterol HDL'] =  keeper[51]
						indicator_data_bio['Cholinesterase'] =  keeper[52]
						indicator_data_bio['C Reactive Protein (CRP)'] =  keeper[53]
						indicator_data_bio['Creatinine'] =  keeper[54]
						indicator_data_bio['Creatine Kinase NAC'] =  keeper[55]
						indicator_data_bio['Creatine Kinase MB'] =  keeper[56]
						indicator_data_bio['Haemoglobin A1c'] =  keeper[57]
						indicator_data_bio['Iron'] =  keeper[58]
						indicator_data_bio['Lipase'] =  keeper[59]
						indicator_data_bio['Lactate Dehydrogenase (LDH)'] =  keeper[60]
						indicator_data_bio['Magnesium'] =  keeper[61]
						indicator_data_bio['Micro-protein'] =  keeper[62]
						indicator_data_bio['Micro-albumin'] =  keeper[63]
						indicator_data_bio['Phosphorus'] =  keeper[64]
						indicator_data_bio['Potassium'] =  keeper[65]
						indicator_data_bio['Rheumatoid Factor'] =  keeper[66]
						indicator_data_bio['Sodium'] =  keeper[67]
						indicator_data_bio['Triglycerides'] =  keeper[68]
						indicator_data_bio['Urea'] =  keeper[69]
						indicator_data_bio['Uric acid'] =  keeper[70]

						data["Biochemistry"] =  indicator_data_bio

					end



			else

				if depart_option == "Haematology"
					

                    months = MoHReport.generate_quater(quater)
           
                    months.each do |month|
                        period = year + "-" + month
						
						
						res = TestType.where(name: "FBC").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND	(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[0] = value.to_s
						else
							keeper[0] = keeper[0] + "_" + value.to_s
						end
					

						res = TestType.where(name: "ESR").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND (substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
						if checker == 0
							keeper[1] = value.to_s
						else
							keeper[1] = keeper[1] + "_" + value.to_s
						end
					


						res = TestType.where(name: "Sickling Test").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND	(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
						if checker == 0
							keeper[2] = value.to_s
						else
							keeper[2] = keeper[2] + "_" + value.to_s
						end
					


						res = TestType.where(name: "Prothrombin Time").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND	(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
						if checker == 0
							keeper[3] = value.to_s
						else
							keeper[3] = keeper[3] + "_" + value.to_s
						end
					


						res = TestType.where(name: "APTT").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND (substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
						if checker == 0
							keeper[4] = value.to_s
						else
							keeper[4] = keeper[4] + "_" + value.to_s
						end
					


						
						checker = checker + 1
					

						indicator_data['Full Blood Count'] =  keeper[0]
						indicator_data['Erythrocyte Sedimentation Rate (ESR)'] =  keeper[1]
						indicator_data['Sickling Test'] =  keeper[2]
						indicator_data['Prothrombin time (PT)'] =  keeper[3]
						indicator_data['Activated Partial Thromboplastin Time (APTT)'] =  keeper[4]
						data["Haematology"] =  indicator_data

					end




				elsif depart_option == "Parasitology"
		
					months = MoHReport.generate_quater(quater)
            
                    months.each do |month|
                        period = year + "-" + month
						
						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Blood film' AND test_results.result !='0' ))"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[0] = value.to_s
						else
							keeper[0] = keeper[0] + "_" + value.to_s
						end

						per = period + "-28"
						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Blood film' AND (((DATEDIFF('#{per}',patients.dob) / 365) < 5.5) AND test_results.result !='0')))"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[1] = value.to_s
						else
							keeper[1] = keeper[1] + "_" + value.to_s
						end


						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Blood film' AND (DATEDIFF('#{per}',patients.dob) / 365) < 5.5) 
										AND  test_results.result != 'No parasite seen')"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[2] = value.to_s
						else
							keeper[2] = keeper[2] + "_" + value.to_s
						end


						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Blood film' AND patients.dob = 'NaNNaNNaNNaNNaNNaN' ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[3] = value.to_s
						else
							keeper[3] = keeper[3] + "_" + value.to_s
						end



						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Blood film' AND (patients.dob = 'NaNNaNNaNNaNNaNNaN' AND test_results.result != 'No parasite seen')))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[4] = value.to_s
						else
							keeper[4] = keeper[4] + "_" + value.to_s
						end



						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND test_results.result !='0' ))"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[5] = value.to_s
						else
							keeper[5] = keeper[5] + "_" + value.to_s
						end




						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND test_results.result ='Positive' ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[6] = value.to_s
						else
							keeper[6] = keeper[6] + "_" + value.to_s
						end



						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND (((DATEDIFF('#{per}',patients.dob) / 365) <= 5.5) AND test_results.result !='0')))"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[7] = value.to_s
						else
							keeper[7] = keeper[7] + "_" + value.to_s
						end


						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND (((DATEDIFF('#{per}',patients.dob) / 365) <= 5.5) AND test_results.result ='Positive') ))"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[8] = value.to_s
						else
							keeper[8] = keeper[8] + "_" + value.to_s
						end



						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND (((DATEDIFF('#{per}',patients.dob) / 365) >= 5.5) AND test_results.result !='0')))"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[9] = value.to_s
						else
							keeper[9] = keeper[9] + "_" + value.to_s
						end


						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND (((DATEDIFF('#{per}',patients.dob) / 365) >= 5.5) AND test_results.result ='Positive') ))"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[10] = value.to_s
						else
							keeper[10] = keeper[10] + "_" + value.to_s
						end



						res = TestType.where(name: "Malaria Screening").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND test_results.result ='Invalid' ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[11] = value.to_s
						else
							keeper[11] = keeper[11] + "_" + value.to_s
						end


						res = TestType.where(name: "Urine Microscopy").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' )"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[12] = value.to_s
						else
							keeper[12] = keeper[12] + "_" + value.to_s
						end



						res = TestType.where(name: "Semen Analysis").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' )"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[13] = value.to_s
						else
							keeper[13] = keeper[13] + "_" + value.to_s
						end


						checker = checker + 1
						
						indicator_data['Total malaria microscopy tests done'] =  keeper[0]
						indicator_data['Malaria microscopy in ≤ 5yrs (by species)?'] =  keeper[1]
						indicator_data['Positive malaria slides in < 5yrs'] =  keeper[2]
						indicator_data['Malaria microscopy in unknown age'] =  keeper[3]
						indicator_data['Positive malaria slides in unknown age'] =  keeper[4]
						indicator_data['Total MRDTs Done'] =  keeper[5]
						indicator_data['MRDTs Positives'] =  keeper[6]
						indicator_data['MRDTs in ≤  5yrs'] =  keeper[7]
						indicator_data['MRDT Positives in < 5yrs'] =  keeper[8] 
						indicator_data['MRDTs in >= 5yrs'] =  keeper[9] 
						indicator_data['MRDT Positives in > 5yrs'] =  keeper[10] 
						indicator_data['Total invalid MRDTs tests'] =  keeper[11] 
						indicator_data['Trypanosome tests'] = keeper[11] 
						indicator_data['Positive tests'] =  keeper[11] 
						indicator_data['Urine microscopy total'] =  keeper[12] 
						indicator_data['Schistosome Haematobium'] =  keeper[11]   
						indicator_data['Other urine parasites'] =  keeper[11]  
						indicator_data['urine chemistry (count)'] =  keeper[11]
						indicator_data['Semen analysis (count)'] =  keeper[13]
						indicator_data['Blood Parasites (count)'] = keeper[5]
						indicator_data['Blood Parasites seen'] = keeper[6]
						indicator_data['Stool Microscopy (count)'] =  keeper[6]
						indicator_data['Stool Microscopy Parasites seen'] =  keeper[6]

						data["Parasitology"] =  indicator_data
					end







				elsif depart_option == "Blood_Bank"
		
                    months = MoHReport.generate_quater(quater)
           
                    months.each do |month|
                        period = year + "-" + month
						

						res = TestType.where(name: "ABO Blood Grouping").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id	
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Grouping' AND test_results.result IS NOT NULL ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[0] = value.to_s
						else
							keeper[0] = keeper[0] + "_" + value.to_s
						end


						res = TestType.where(name: "Cross-match").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id	
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Pack ABO Group' AND test_results.result IS NOT NULL ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[1] = value.to_s
						else
							keeper[1] = keeper[1] + "_" + value.to_s
						end



						res = TestType.where(name: "Cross-match").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id 
										INNER JOIN wards ON wards.id = orders.ward_id	
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										((substr(tests.time_created,1,7) = '#{period}' AND (wards.name = 'EM THEATRE' OR wards.name = 'Labour' OR wards.name = 'OPD' OR wards.name ='PNW')) AND (measures.name = 'Pack ABO Group' AND test_results.result IS NOT NULL ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[2] = value.to_s
						else
							keeper[2] = keeper[2] + "_" + value.to_s
						end




						res = TestType.where(name: "Cross-match").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id 
										INNER JOIN wards ON wards.id = orders.ward_id	
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										((substr(tests.time_created,1,7) = '#{period}' AND (wards.name = 'CWA' OR wards.name = 'CWB' OR wards.name = 'CWC' OR wards.name ='EM Nursery' OR wards.name ='Under 5 Clinic')) AND (measures.name = 'Pack ABO Group' AND test_results.result IS NOT NULL ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[3] = value.to_s
						else
							keeper[3] = keeper[3] + "_" + value.to_s
						end


						res = TestType.where(name: "Cross-match").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id 
										INNER JOIN wards ON wards.id = orders.ward_id	
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										((substr(tests.time_created,1,7) = '#{period}' AND (wards.name = 'Other')) AND (measures.name = 'Pack ABO Group' AND test_results.result IS NOT NULL ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[4] = value.to_s
						else
							keeper[4] = keeper[4] + "_" + value.to_s
						end



						res = TestType.where(name: "Cross-match").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id 
										INNER JOIN wards ON wards.id = orders.ward_id	
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										((substr(tests.time_created,1,7) = '#{period}' ) AND (measures.name = 'Pack ABO Group' AND test_results.result IS NULL ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[5] = value.to_s
						else
							keeper[5] = keeper[5] + "_" + value.to_s
						end


						res = TestType.where(name: "Cross-match").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id 
										INNER JOIN wards ON wards.id = orders.ward_id	
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										((substr(tests.time_created,1,7) = '#{period}' ) AND (measures.name = 'Pack ABO Group' AND test_results.result IS NULL ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[6] = value.to_s
						else
							keeper[6] = keeper[6] + "_" + value.to_s
						end


						
						checker = checker + 1
						indicator_data['blood grouping done on Patients'] =  keeper[0]
						indicator_data['Total X-matched'] =  keeper[1]
						indicator_data['X- matched for matenity'] =  keeper[2]
						indicator_data['X-macthed for peads'] =  keeper[3]
						indicator_data['X-matched for others'] =  keeper[4]
						indicator_data['X-matches done on patients with Hb ≤ 6.0g/dl'] =  keeper[5]
						indicator_data['X-matches done on patients with Hb > 6.0g/dl'] =  keeper[6]

						data["Blood Bank"] =  indicator_data
					end







				elsif depart_option == "Serology"
					months = MoHReport.generate_quater(quater)
            
                    months.each do |month|
                        period = year + "-" + month

						res = TestType.where(name: "Syphilis Test").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests WHERE test_type_id = '#{test_id}' AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[0] = value.to_s
						else
							keeper[0] = keeper[0] + "_" + value.to_s
						end
						

						res = TestType.where(name: "Syphilis Test").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND ((measures.name = 'TPHA' OR measures.name = 'VDRL' OR measures.name = 'RPR') AND test_results.result ='Reactive' ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[1] = value.to_s
						else
							keeper[1] = keeper[1] + "_" + value.to_s
						end



						res = TestType.where(name: "Hepatitis B Test").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[2] = value.to_s
						else
							keeper[2] = keeper[2] + "_" + value.to_s
						end
						

						res = TestType.where(name: "Hepatitis B Test").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}') 
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Hepatitis B' AND test_results.result ='Positive' ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[3] = value.to_s
						else
							keeper[3] = keeper[3] + "_" + value.to_s
						end



						res = TestType.where(name: "Hepatitis C Test").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[4] = value.to_s
						else
							keeper[4] = keeper[4] + "_" + value.to_s
						end
							

						res = TestType.where(name: "Hepatitis C Test").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Hepatitis C' AND test_results.result ='Positive' ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[5] = value.to_s
						else
							keeper[5] = keeper[5] + "_" + value.to_s
						end

						

						res = TestType.where(name: "Pregnancy Test").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[6] = value.to_s
						else
							keeper[6] = keeper[6] + "_" + value.to_s
						end
							


						res = TestType.where(name: "Pregnancy Test").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Pregnancy Test' AND test_results.result ='Positive' ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[7] = value.to_s
						else
							keeper[7] = keeper[7] + "_" + value.to_s
						end


						res = TestType.where(name: "HIV").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[8] = value.to_s
						else
							keeper[8] = keeper[8] + "_" + value.to_s
						end



						res = TestType.where(name: "HIV").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests INNER JOIN test_results ON test_results.test_id = tests.id 
										INNER JOIN measures ON measures.id = test_results.measure_id
										INNER JOIN orders ON orders.id = tests.order_id
										INNER JOIN patients ON patients.id = orders.patient_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'HIV STATUS' AND test_results.result ='Positive' ))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[9] = value.to_s
						else
							keeper[9] = keeper[9] + "_" + value.to_s
						end

						checker = checker + 1
						indicator_data['Syphilis Test'] =  keeper[0]
						indicator_data['Syphilis screening on patients (by depart_option)'] =  keeper[0]
						indicator_data['Positive tests^'] =  keeper[1]
						indicator_data['Syphilis screening on antenatal mothers'] =  keeper[0]
						indicator_data['Positive tests ^'] =  keeper[0]
						indicator_data['HepBs test done on patients'] =  keeper[2]
						indicator_data['Positive_tests  ^'] =  keeper[3]
						indicator_data['HepC test done on patients'] =  keeper[4]
						indicator_data['Positive tests  ^'] =  keeper[5]
						indicator_data['Hcg  Pregnacy tests done'] =  keeper[6]
						indicator_data['Positive tests   ^'] =  keeper[7]
						indicator_data['HIV tests on PEP'] =  keeper[8]
						indicator_data['positives tests    ^'] =  keeper[9]

						data["Serology"] =  indicator_data

					end



				elsif depart_option == "Biochemistry"
                    months = MoHReport.generate_quater(quater)
           
                    months.each do |month|
                        period = year + "-" + month
							
						res = TestType.where(name: "Glucose").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[0] = value.to_s
						else
							keeper[0] = keeper[0] + "_" + value.to_s
						end

						res = TestType.where(name: "Glucose").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[1] = value.to_s
						else
							keeper[1] = keeper[1] + "_" + value.to_s
						end

						res = TestType.where(name: "Total Protein").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[2] = value.to_s
						else
							keeper[2] = keeper[2] + "_" + value.to_s
						end

						res = Measure.where(name: "Albumin(ALB)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[3] = value.to_s
						else
							keeper[3] = keeper[3] + "_" + value.to_s
						end


						res = Measure.where(name: "Alkaline Phosphate(ALP)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[4] = value.to_s
						else
							keeper[4] = keeper[4] + "_" + value.to_s
						end




						res = Measure.where(name: "ALT/GPT").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[5] = value.to_s
						else
							keeper[5] = keeper[5] + "_" + value.to_s
						end


						res = Measure.where(name: "Amylase").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[6] = value.to_s
						else
							keeper[6] = keeper[6] + "_" + value.to_s
						end



						
						
						res = Measure.where(name: "Antistreptolysin O (ASO)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[7] = value.to_s
						else
							keeper[7] = keeper[7] + "_" + value.to_s
						end



						res = Measure.where(name: "AST/GOT").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[8] = value.to_s
						else
							keeper[8] = keeper[8] + "_" + value.to_s
						end


						res = Measure.where(name: "Bilirubin Total(BIT))").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[9] = value.to_s
						else
							keeper[9] = keeper[9] + "_" + value.to_s
						end


						res = Measure.where(name: "Bilirubin Direct(BID)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[10] = value.to_s
						else
							keeper[10] = keeper[10] + "_" + value.to_s
						end


						res = TestType.where(name: "Calcium").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND  
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[11] = value.to_s
						else
							keeper[11] = keeper[11] + "_" + value.to_s
						end



						res = Measure.where(name: "Chloride").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[12] = value.to_s
						else
							keeper[12] = keeper[12] + "_" + value.to_s
						end



						res = Measure.where(name: "Cholestero l(CHOL)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND  
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[13] = value.to_s
						else
							keeper[13] = keeper[13] + "_" + value.to_s
						end


						res = Measure.where(name: "Cholestero l(CHOL)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[14] = value.to_s
						else
							keeper[14] = keeper[14] + "_" + value.to_s
						end


						res = Measure.where(name: "Cholestero l(CHOL)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND  
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[15] = value.to_s
						else
							keeper[15] = keeper[15] + "_" + value.to_s
						end


						res = Measure.where(name: "Cholestero l(CHOL)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[16] = value.to_s
						else
							keeper[16] = keeper[16] + "_" + value.to_s
						end


						res = TestType.where(name: "C-reactive protein").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[17] = value.to_s
						else
							keeper[17] = keeper[17] + "_" + value.to_s
						end


						res = TestType.where(name: "Creatinine").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[18] = value.to_s
						else
							keeper[18] = keeper[18] + "_" + value.to_s
						end



						res = Measure.where(name: "Creatine Kinase(CKN)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[19] = value.to_s
						else
							keeper[19] = keeper[19] + "_" + value.to_s
						end
					

						res = Measure.where(name: "Creatine Kinase MB(CKMB)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[20] = value.to_s
						else
							keeper[20] = keeper[20] + "_" + value.to_s
						end



						res = TestType.where(name: "HbA1c").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[21] = value.to_s
						else
							keeper[21] = keeper[21] + "_" + value.to_s
						end

						

						res = TestType.where(name: "Iron Studies").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[22] = value.to_s
						else
							keeper[22] = keeper[22] + "_" + value.to_s
						end

						
						res = Measure.where(name: "Lipase").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[23] = value.to_s
						else
							keeper[23] = keeper[23] + "_" + value.to_s
						end						
						

						res = Measure.where(name: "LDH").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[24] = value.to_s
						else
							keeper[24] = keeper[24] + "_" + value.to_s
						end						
						


						res = Measure.where(name: "Magnesium (MGXB)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[25] = value.to_s
						else
							keeper[25] = keeper[25] + "_" + value.to_s
						end						
						


						res = TestType.where(name: "Microprotein").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[26] = value.to_s
						else
							keeper[26] = keeper[26] + "_" + value.to_s
						end


						res = TestType.where(name: "Microalbumin").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[27] = value.to_s
						else
							keeper[27] = keeper[27] + "_" + value.to_s
						end


						res = TestType.where(name: "Phosphorus").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[28] = value.to_s
						else
							keeper[28] = keeper[28] + "_" + value.to_s
						end
						
						

						res = Measure.where(name: "Potassium").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[29] = value.to_s
						else
							keeper[29] = keeper[29] + "_" + value.to_s
						end	



						res = TestType.where(name: "Rheumatoid Factor Test").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[30] = value.to_s
						else
							keeper[30] = keeper[30] + "_" + value.to_s
						end


						res = Measure.where(name: "Sodium").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[31] = value.to_s
						else
							keeper[31] = keeper[31] + "_" + value.to_s
						end	


						res = Measure.where(name: "Triglycerides(TG)").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
										)
						value = res[0].test_count
		
						if checker == 0
							keeper[32] = value.to_s
						else
							keeper[32] = keeper[32] + "_" + value.to_s
						end	


						res = TestType.where(name: "Urea").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[33] = value.to_s
						else
							keeper[33] = keeper[33] + "_" + value.to_s
						end


						res = TestType.where(name: "Uric Acid").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[34] = value.to_s
						else
							keeper[34] = keeper[34] + "_" + value.to_s
						end


						checker = checker + 1
					
						indicator_data['Blood glucose'] =  keeper[0]
						indicator_data['CSF glucose'] =  keeper[1]
						indicator_data['Total Protein'] =  keeper[2]
						indicator_data['Albumin'] =  keeper[3]
						indicator_data['Alkaline Phosphatase(ALP)'] =  keeper[4]
						indicator_data['Alanine aminotransferase (ALT)'] =  keeper[5]
						indicator_data['Amylase'] =  keeper[6]
						indicator_data['Antistreptolysin O (ASO)'] =  keeper[7]
						indicator_data['Aspartate aminotransferase(AST)'] =  keeper[8]
						indicator_data['Bilirubin Total'] =  keeper[9]
						indicator_data['Bilirubin Direct'] =  keeper[10]
						indicator_data['Calcium'] =  keeper[11]
						indicator_data['Chloride'] =  keeper[12]
						indicator_data['Cholesterol Total'] =  keeper[13]
						indicator_data['Cholesterol LDL'] =  keeper[14]
						indicator_data['Cholesterol HDL'] =  keeper[15]
						indicator_data['Cholinesterase'] =  keeper[16]
						indicator_data['C Reactive Protein (CRP)'] =  keeper[17]
						indicator_data['Creatinine'] =  keeper[18]
						indicator_data['Creatine Kinase NAC'] =  keeper[19]
						indicator_data['Creatine Kinase MB'] =  keeper[20]
						indicator_data['Haemoglobin A1c'] =  keeper[21]
						indicator_data['Iron'] =  keeper[22]
						indicator_data['Lipase'] =  keeper[23]
						indicator_data['Lactate Dehydrogenase (LDH)'] =  keeper[24]
						indicator_data['Magnesium'] =  keeper[25]
						indicator_data['Micro-protein'] =  keeper[26]
						indicator_data['Micro-albumin'] =  keeper[27]
						indicator_data['Phosphorus'] =  keeper[28]
						indicator_data['Potassium'] =  keeper[29]
						indicator_data['Rheumatoid Factor'] =  keeper[30]
						indicator_data['Sodium'] =  keeper[31]
						indicator_data['Triglycerides'] =  keeper[32]
						indicator_data['Urea'] =  keeper[33]
						indicator_data['Uric acid'] =  keeper[34]

						data["Biochemistry"] =  indicator_data
					end






				elsif depart_option == "Microbiology" 
					
                    months = MoHReport.generate_quater(quater)
           
                    months.each do |month|
                        period = year + "-" + month
						
						res = TestType.where(name: "TB Microscopic Exam").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND  
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[0] = value.to_s
						else
							keeper[0] = keeper[0] + "_" + value.to_s
						end


						res = TestType.where(name: "TB Tests").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_created,1,7) = '#{period}')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[1] = value.to_s
						else
							keeper[1] = keeper[1] + "_" + value.to_s
						end



						res = Measure.where(name: "Smear microscopy result").first
						test_id = res.id
						res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
										test_results 
										INNER JOIN tests ON tests.id = test_results.test_id 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(time_entered,1,7) = '#{period}' AND (result = '++' OR result = '+++' OR result = '+' OR result = 'positive'))"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[2] = value.to_s
						else
							keeper[2] = keeper[2] + "_" + value.to_s
						end




						res = SpecimenType.where(name: "CSF").first
						test_id = res.id
						res = Order.find_by_sql("SELECT count(*) AS test_count FROM 
										orders WHERE (specimen_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(date_created,1,7) = '#{period}')"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[3] = value.to_s
						else
							keeper[3] = keeper[3] + "_" + value.to_s
						end



						res = SpecimenType.where(name: "HVS").first
						test_id = res.id
						res = Order.find_by_sql("SELECT count(*) AS test_count FROM 
										orders WHERE (specimen_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND  
										(substr(date_created,1,7) = '#{period}')"
										)

						value = res[0].test_count
		
						if checker == 0
							keeper[4] = value.to_s
						else
							keeper[4] = keeper[4] + "_" + value.to_s
						end


						res = TestType.where(name: "TB Tests").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN test_results ON tests.id = test_results.test_id
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND test_results.result ='MTB NOT DETECTED')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[5] = value.to_s
						else
							keeper[5] = keeper[5] + "_" + value.to_s
						end


						res = TestType.where(name: "TB Tests").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN test_results ON tests.id = test_results.test_id
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND test_results.result ='RIF Resistant Detected')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[6] = value.to_s
						else
							keeper[6] = keeper[6] + "_" + value.to_s
						end



						res = TestType.where(name: "TB Tests").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN test_results ON tests.id = test_results.test_id
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND  
										(substr(tests.time_created,1,7) = '#{period}' AND test_results.result ='RIF Resistant Not Detected')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[7] = value.to_s
						else
							keeper[7] = keeper[7] + "_" + value.to_s
						end


						res = TestType.where(name: "TB Tests").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN test_results ON tests.id = test_results.test_id
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND test_results.result ='RIF Resistant Indeterminate')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[8] = value.to_s
						else
							keeper[8] = keeper[8] + "_" + value.to_s
						end




						res = TestType.where(name: "TB Tests").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN test_results ON tests.id = test_results.test_id
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND (test_results.result = 'Invalid' OR test_results.result = 'invalid'))"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[9] = value.to_s
						else
							keeper[9] = keeper[9] + "_" + value.to_s
						end


						res = TestType.where(name: "TB Tests").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN test_results ON tests.id = test_results.test_id
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND  
										(substr(tests.time_created,1,7) = '#{period}' AND test_results.result IS NULL)"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[10] = value.to_s
						else
							keeper[10] = keeper[10] + "_" + value.to_s
						end


						res = TestType.where(name: "Culture & Sensitivity").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' )"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[11] = value.to_s
						else
							keeper[11] = keeper[11] + "_" + value.to_s
						end




						res = TestType.where(name: "Culture & Sensitivity").first
						test_id = res.id
						res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
										tests 
										INNER JOIN test_results ON tests.id = test_results.test_id
										INNER JOIN orders ON orders.id = tests.order_id
										WHERE (test_type_id = '#{test_id}' AND orders.health_facility = '#{facility}')
										AND 
										(substr(tests.time_created,1,7) = '#{period}' AND test_results.result = 'Growth')"

										)
						value = res[0].test_count
		
						if checker == 0
							keeper[12] = value.to_s
						else
							keeper[12] = keeper[12] + "_" + value.to_s
						end




									
						checker = checker + 1


						indicator_data['Number of AFB sputum examined'] =  keeper[0]
						indicator_data['Number of  new TB cases examined'] =  keeper[1]
						indicator_data['New cases with positive smear'] =  keeper[2]
						indicator_data['MTB Not Detected'] =  keeper[5]
						indicator_data['RIF Resistant Detected'] =  keeper[6]
						indicator_data['RIF Resistant Not Detected'] =  keeper[7]
						indicator_data['RIF Resistant Indeterminate'] =  keeper[8]
						indicator_data['Invalid'] =  keeper[9]
						indicator_data['No results'] =  keeper[10]
						indicator_data['Number of CSF samples analysed'] =  keeper[3]
						indicator_data['Number of CSF samples analysed for AFB'] =  keeper[3]
						indicator_data['Number of CSF samples with Organism'] =  keeper[3]
						indicator_data['HVS analysed '] =  keeper[4]
						indicator_data['Number of Blood Cultures done'] =  keeper[11]
						indicator_data['Positive blood Cultures'] =  keeper[12]
						indicator_data['Number of tests on microscopy'] =  keeper[5]
						indicator_data['Number of tests on GeneXpert'] =  keeper[1]
						indicator_data['MTB Detected'] =  keeper[2]
						indicator_data['India ink positive'] =  keeper[0]
						indicator_data['Gram stain positive'] =  keeper[0]

						data["Microbiology"] =  indicator_data
					end



						

				end

			end

        return data
    end


#begining of another method-------

    def self.by_national(depart_option, year, quater)
        period = nil
        data = {}
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

        if depart_option == "all"
            months = MoHReport.generate_quater(quater)
           
            months.each do |month|
                
                period = year + "-" + month
                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Blood film' AND test_results.result !='0' ))"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[0] = value.to_s
                else
                    keeper[0] = keeper[0] + "_" + value.to_s
                end

                per = period + "-28"
                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Blood film' AND (((DATEDIFF('#{per}',patients.dob) / 365) < 5.5) AND test_results.result !='0')))"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[1] = value.to_s
                else
                    keeper[1] = keeper[1] + "_" + value.to_s
                end


                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Blood film' AND (DATEDIFF('#{per}',patients.dob) / 365) < 5.5) 
                                AND  test_results.result != 'No parasite seen')"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[2] = value.to_s
                else
                    keeper[2] = keeper[2] + "_" + value.to_s
                end


                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Blood film' AND patients.dob = 'NaNNaNNaNNaNNaNNaN' ))"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[3] = value.to_s
                else
                    keeper[3] = keeper[3] + "_" + value.to_s
                end



                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Blood film' AND (patients.dob = 'NaNNaNNaNNaNNaNNaN' AND test_results.result != 'No parasite seen')))"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[4] = value.to_s
                else
                    keeper[4] = keeper[4] + "_" + value.to_s
                end



                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND test_results.result !='0' ))"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[5] = value.to_s
                else
                    keeper[5] = keeper[5] + "_" + value.to_s
                end




                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND test_results.result ='Positive' ))"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[6] = value.to_s
                else
                    keeper[6] = keeper[6] + "_" + value.to_s
                end



                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND (((DATEDIFF('#{per}',patients.dob) / 365) <= 5.5) AND test_results.result !='0')))"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[7] = value.to_s
                else
                    keeper[7] = keeper[7] + "_" + value.to_s
                end


                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND (((DATEDIFF('#{per}',patients.dob) / 365) <= 5.5) AND test_results.result ='Positive') ))"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[8] = value.to_s
                else
                    keeper[8] = keeper[8] + "_" + value.to_s
                end



                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND (((DATEDIFF('#{per}',patients.dob) / 365) >= 5.5) AND test_results.result !='0')))"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[9] = value.to_s
                else
                    keeper[9] = keeper[9] + "_" + value.to_s
                end


                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND (((DATEDIFF('#{per}',patients.dob) / 365) >= 5.5) AND test_results.result ='Positive') ))"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[10] = value.to_s
                else
                    keeper[10] = keeper[10] + "_" + value.to_s
                end



                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND test_results.result ='Invalid' ))"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[11] = value.to_s
                else
                    keeper[11] = keeper[11] + "_" + value.to_s
                end


                res = TestType.where(name: "Urine Microscopy").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' )"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[12] = value.to_s
                else
                    keeper[12] = keeper[12] + "_" + value.to_s
                end



                res = TestType.where(name: "Semen Analysis").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' )"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[13] = value.to_s
                else
                    keeper[13] = keeper[13] + "_" + value.to_s
                end


            
                
                indicator_data['Total malaria microscopy tests done'] =  keeper[0]
                indicator_data['Malaria microscopy in ≤ 5yrs (by species)?'] =  keeper[1]
                indicator_data['Positive malaria slides in < 5yrs'] =  keeper[2]
                indicator_data['Malaria microscopy in unknown age'] =  keeper[3]
                indicator_data['Positive malaria slides in unknown age'] =  keeper[4]
                indicator_data['Total MRDTs Done'] =  keeper[5]
                indicator_data['MRDTs Positives'] =  keeper[6]
                indicator_data['MRDTs in ≤  5yrs'] =  keeper[7]
                indicator_data['MRDT Positives in < 5yrs'] =  keeper[8] 
                indicator_data['MRDTs in >= 5yrs'] =  keeper[9] 
                indicator_data['MRDT Positives in > 5yrs'] =  keeper[10] 
                indicator_data['Total invalid MRDTs tests'] =  keeper[11] 
                indicator_data['Trypanosome tests'] = keeper[11] 
                indicator_data['Positive tests'] =  keeper[11] 
                indicator_data['Urine microscopy total'] =  keeper[12] 
                indicator_data['Schistosome Haematobium'] =  keeper[11]   
                indicator_data['Other urine parasites'] =  keeper[11]  
                indicator_data['urine chemistry (count)'] =  keeper[11]
                indicator_data['Semen analysis (count)'] =  keeper[13]

                data["Parasitology"] =  indicator_data
        





                res = TestType.where(name: "FBC").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[14] = value.to_s
                else
                    keeper[14] = keeper[14] + "_" + value.to_s
                end
            

                res = TestType.where(name: "ESR").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count
                if checker == 0
                    keeper[15] = value.to_s
                else
                    keeper[15] = keeper[15] + "_" + value.to_s
                end
            


                res = TestType.where(name: "Sickling Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count
                if checker == 0
                    keeper[16] = value.to_s
                else
                    keeper[16] = keeper[16] + "_" + value.to_s
                end
            


                res = TestType.where(name: "Prothrombin Time").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count
                if checker == 0
                    keeper[17] = value.to_s
                else
                    keeper[17] = keeper[17] + "_" + value.to_s
                end
            


                res = TestType.where(name: "APTT").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count
                if checker == 0
                    keeper[18] = value.to_s
                else
                    keeper[18] = keeper[18] + "_" + value.to_s
                end
                

            indicator_data_haematology['Full Blood Count'] =  keeper[14]
            indicator_data_haematology['Erythrocyte Sedimentation Rate (ESR)'] =  keeper[15]
            indicator_data_haematology['Sickling Test'] =  keeper[16]
            indicator_data_haematology['Prothrombin time (PT)'] =  keeper[17]
            indicator_data_haematology['Activated Partial Thromboplastin Time (APTT)'] =  keeper[18]
            data["Haematology"] =  indicator_data_haematology








            res = TestType.where(name: "TB Microscopic Exam").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[19] = value.to_s
                else
                    keeper[19] = keeper[19] + "_" + value.to_s
                end


                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[20] = value.to_s
                else
                    keeper[20] = keeper[20] + "_" + value.to_s
                end



                res = Measure.where(name: "Smear microscopy result").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND (result = '++' OR result = '+++' OR result = '+' OR result = 'positive'))"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[21] = value.to_s
                else
                    keeper[21] = keeper[21] + "_" + value.to_s
                end




                res = SpecimenType.where(name: "CSF").first
                test_id = res.id
                res = Order.find_by_sql("SELECT count(*) AS test_count FROM 
                                orders WHERE specimen_type_id = '#{test_id}' AND 
                                (substr(date_created,1,7) = '#{period}')"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[22] = value.to_s
                else
                    keeper[22] = keeper[22] + "_" + value.to_s
                end



                res = SpecimenType.where(name: "HVS").first
                test_id = res.id
                res = Order.find_by_sql("SELECT count(*) AS test_count FROM 
                                orders WHERE specimen_type_id = '#{test_id}' AND 
                                (substr(date_created,1,7) = '#{period}')"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[23] = value.to_s
                else
                    keeper[23] = keeper[23] + "_" + value.to_s
                end


                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result ='MTB NOT DETECTED')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[24] = value.to_s
                else
                    keeper[24] = keeper[24] + "_" + value.to_s
                end


                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result ='RIF Resistant Detected')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[25] = value.to_s
                else
                    keeper[25] = keeper[25] + "_" + value.to_s
                end



                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result ='RIF Resistant Not Detected')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[26] = value.to_s
                else
                    keeper[26] = keeper[26] + "_" + value.to_s
                end


                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result ='RIF Resistant Indeterminate')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[27] = value.to_s
                else
                    keeper[27] = keeper[27] + "_" + value.to_s
                end




                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (test_results.result = 'Invalid' OR test_results.result = 'invalid'))"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[28] = value.to_s
                else
                    keeper[28] = keeper[28] + "_" + value.to_s
                end


                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result IS NULL)"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[29] = value.to_s
                else
                    keeper[29] = keeper[29] + "_" + value.to_s
                end


                res = TestType.where(name: "Culture & Sensitivity").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' )"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[30] = value.to_s
                else
                    keeper[30] = keeper[30] + "_" + value.to_s
                end




                res = TestType.where(name: "Culture & Sensitivity").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result = 'Growth')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[31] = value.to_s
                else
                    keeper[31] = keeper[31] + "_" + value.to_s
                end



                indicator_data_microbiology['Number of AFB sputum examined'] =  keeper[19]
                indicator_data_microbiology['Number of  new TB cases examined'] =  keeper[20]
                indicator_data_microbiology['New cases with positive smear'] =  keeper[21]
                indicator_data_microbiology['MTB Not Detected'] =  keeper[24]
                indicator_data_microbiology['RIF Resistant Detected'] =  keeper[25]
                indicator_data_microbiology['RIF Resistant Not Detected'] =  keeper[26]
                indicator_data_microbiology['RIF Resistant Indeterminate'] =  keeper[27]
                indicator_data_microbiology['Invalid'] =  keeper[28]
                indicator_data_microbiology['No results'] =  keeper[29]
                indicator_data_microbiology['Number of CSF samples analysed'] =  keeper[22]
                indicator_data_microbiology['Number of CSF samples analysed for AFB'] =  keeper[22]
                indicator_data_microbiology['Number of CSF samples with Organism'] =  keeper[22]
                indicator_data_microbiology['HVS analysed '] =  keeper[23]
                indicator_data_microbiology['Number of Blood Cultures done'] =  keeper[30]
				indicator_data_microbiology['Positive blood Cultures'] =  keeper[31]
				indicator_data_microbiology['Number of tests on microscopy'] =  keeper[20]
				indicator_data_microbiology['Number of tests on GeneXpert'] =  keeper[21]
				indicator_data_microbiology['MTB Detected'] =  keeper[21]
				indicator_data_microbiology['India ink positive'] =  keeper[25]
				indicator_data_microbiology['Gram stain positive'] =  keeper[25]

                data["Microbiology"] =  indicator_data_microbiology








                res = TestType.where(name: "Syphilis Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[32] = value.to_s
                else
                    keeper[32] = keeper[32] + "_" + value.to_s
                end
                

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

                if checker == 0
                    keeper[33] = value.to_s
                else
                    keeper[33] = keeper[33] + "_" + value.to_s
                end



                res = TestType.where(name: "Hepatitis B Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[34] = value.to_s
                else
                    keeper[34] = keeper[34] + "_" + value.to_s
                end
                

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

                if checker == 0
                    keeper[35] = value.to_s
                else
                    keeper[35] = keeper[35] + "_" + value.to_s
                end



                res = TestType.where(name: "Hepatitis C Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[36] = value.to_s
                else
                    keeper[36] = keeper[36] + "_" + value.to_s
                end
                    

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

                if checker == 0
                    keeper[37] = value.to_s
                else
                    keeper[37] = keeper[37] + "_" + value.to_s
                end

                

                res = TestType.where(name: "Pregnancy Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[38] = value.to_s
                else
                    keeper[38] = keeper[38] + "_" + value.to_s
                end
                    


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

                if checker == 0
                    keeper[39] = value.to_s
                else
                    keeper[39] = keeper[39] + "_" + value.to_s
                end


                res = TestType.where(name: "HIV").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[40] = value.to_s
                else
                    keeper[40] = keeper[40] + "_" + value.to_s
                end



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

                if checker == 0
                    keeper[41] = value.to_s
                else
                    keeper[41] = keeper[41] + "_" + value.to_s
                end


                indicator_data_serology['Syphilis Test'] =  keeper[32]
                indicator_data_serology['Syphilis screening on patients (by depart_option)'] =  keeper[32]
                indicator_data_serology['Positive tests^'] =  keeper[33]
                indicator_data_serology['Syphilis screening on antenatal mothers'] =  keeper[32]
                indicator_data_serology['Positive tests ^'] =  keeper[32]
                indicator_data_serology['HepBs test done on patients'] =  keeper[34]
                indicator_data_serology['Positive_tests  ^'] =  keeper[35] 
                indicator_data_serology['HepC test done on patients'] =  keeper[36]
                indicator_data_serology['Positive tests  ^'] =  keeper[37]
                indicator_data_serology['Hcg  Pregnacy tests done'] =  keeper[38]
                 indicator_data_serology['Positive tests   ^'] =  keeper[39]
                indicator_data_serology['HIV tests on PEP'] =  keeper[40] 
                indicator_data_serology['positives tests    ^'] =  keeper[41]

                data["Serology"] =  indicator_data_serology







                res = TestType.where(name: "ABO Blood Grouping").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id	
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Grouping' AND test_results.result IS NOT NULL ))"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[42] = value.to_s
                else
                    keeper[42] = keeper[42] + "_" + value.to_s
                end


                res = TestType.where(name: "Cross-match").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id	
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Pack ABO Group' AND test_results.result IS NOT NULL ))"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[43] = value.to_s
                else
                    keeper[43] = keeper[43] + "_" + value.to_s
                end



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

                if checker == 0
                    keeper[44] = value.to_s
                else
                    keeper[44] = keeper[44] + "_" + value.to_s
                end




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

                if checker == 0
                    keeper[45] = value.to_s
                else
                    keeper[45] = keeper[45] + "_" + value.to_s
                end


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

                if checker == 0
                    keeper[46] = value.to_s
                else
                    keeper[46] = keeper[46] + "_" + value.to_s
                end



                res = TestType.where(name: "Cross-match").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id 
                                INNER JOIN wards ON wards.id = orders.ward_id	
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                ((substr(tests.time_created,1,7) = '#{period}' ) AND (measures.name = 'Pack ABO Group' AND test_results.result IS NULL ))"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[47] = value.to_s
                else
                    keeper[47] = keeper[47] + "_" + value.to_s
                end


                res = TestType.where(name: "Cross-match").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id 
                                INNER JOIN wards ON wards.id = orders.ward_id	
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                ((substr(tests.time_created,1,7) = '#{period}' ) AND (measures.name = 'Pack ABO Group' AND test_results.result IS NULL ))"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[48] = value.to_s
                else
                    keeper[48] = keeper[48] + "_" + value.to_s
                end


                
                indicator_data_blood_bank['blood grouping done on Patients'] =  keeper[42]
                indicator_data_blood_bank['Total X-matched'] =  keeper[43]
                indicator_data_blood_bank['X- matched for matenity'] =  keeper[44]
                indicator_data_blood_bank['X-macthed for peads'] =  keeper[45]
                indicator_data_blood_bank['X-matched for others'] =  keeper[46]
                indicator_data_blood_bank['X-matches done on patients with Hb ≤ 6.0g/dl'] =  keeper[47]
                indicator_data_blood_bank['X-matches done on patients with Hb > 6.0g/dl'] =  keeper[48]

                data["Blood Bank"] =  indicator_data_blood_bank















                res = TestType.where(name: "Glucose").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[49] = value.to_s
                else
                    keeper[49] = keeper[49] + "_" + value.to_s
                end

                res = TestType.where(name: "Glucose").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[50] = value.to_s
                else
                    keeper[50] = keeper[50] + "_" + value.to_s
                end

                res = TestType.where(name: "Total Protein").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[51] = value.to_s
                else
                    keeper[51] = keeper[51] + "_" + value.to_s
                end

                res = Measure.where(name: "Albumin(ALB)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[52] = value.to_s
                else
                    keeper[52] = keeper[52] + "_" + value.to_s
                end


                res = Measure.where(name: "Alkaline Phosphate(ALP)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[53] = value.to_s
                else
                    keeper[53] = keeper[53] + "_" + value.to_s
                end




                res = Measure.where(name: "ALT/GPT").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[54] = value.to_s
                else
                    keeper[54] = keeper[54] + "_" + value.to_s
                end


                res = Measure.where(name: "Amylase").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[55] = value.to_s
                else
                    keeper[55] = keeper[55] + "_" + value.to_s
                end



                
                
                res = Measure.where(name: "Antistreptolysin O (ASO)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[56] = value.to_s
                else
                    keeper[56] = keeper[56] + "_" + value.to_s
                end



                res = Measure.where(name: "AST/GOT").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[57] = value.to_s
                else
                    keeper[57] = keeper[57] + "_" + value.to_s
                end


                res = Measure.where(name: "Bilirubin Total(BIT))").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[58] = value.to_s
                else
                    keeper[58] = keeper[58] + "_" + value.to_s
                end


                res = Measure.where(name: "Bilirubin Direct(BID)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[59] = value.to_s
                else
                    keeper[59] = keeper[59] + "_" + value.to_s
                end


                res = TestType.where(name: "Calcium").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[60] = value.to_s
                else
                    keeper[60] = keeper[60] + "_" + value.to_s
                end



                res = Measure.where(name: "Chloride").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[61] = value.to_s
                else
                    keeper[61] = keeper[61] + "_" + value.to_s
                end



                res = Measure.where(name: "Cholestero l(CHOL)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[62] = value.to_s
                else
                    keeper[62] = keeper[62] + "_" + value.to_s
                end


                res = Measure.where(name: "Cholestero l(CHOL)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[63] = value.to_s
                else
                    keeper[63] = keeper[63] + "_" + value.to_s
                end


                res = Measure.where(name: "Cholestero l(CHOL)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[64] = value.to_s
                else
                    keeper[64] = keeper[64] + "_" + value.to_s
                end


                res = Measure.where(name: "Cholestero l(CHOL)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[65] = value.to_s
                else
                    keeper[65] = keeper[65] + "_" + value.to_s
                end


                res = TestType.where(name: "C-reactive protein").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[66] = value.to_s
                else
                    keeper[66] = keeper[66] + "_" + value.to_s
                end


                res = TestType.where(name: "Creatinine").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[67] = value.to_s
                else
                    keeper[67] = keeper[67] + "_" + value.to_s
                end



                res = Measure.where(name: "Creatine Kinase(CKN)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[68] = value.to_s
                else
                    keeper[68] = keeper[68] + "_" + value.to_s
                end
            

                res = Measure.where(name: "Creatine Kinase MB(CKMB)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[69] = value.to_s
                else
                    keeper[69] = keeper[69] + "_" + value.to_s
                end



                res = TestType.where(name: "HbA1c").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[70] = value.to_s
                else
                    keeper[70] = keeper[70] + "_" + value.to_s
                end

                

                res = TestType.where(name: "Iron Studies").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[71] = value.to_s
                else
                    keeper[71] = keeper[71] + "_" + value.to_s
                end

                
                res = Measure.where(name: "Lipase").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[72] = value.to_s
                else
                    keeper[72] = keeper[72] + "_" + value.to_s
                end						
                

                res = Measure.where(name: "LDH").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[73] = value.to_s
                else
                    keeper[73] = keeper[73] + "_" + value.to_s
                end						
                


                res = Measure.where(name: "Magnesium (MGXB)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[74] = value.to_s
                else
                    keeper[74] = keeper[74] + "_" + value.to_s
                end						
                


                res = TestType.where(name: "Microprotein").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[75] = value.to_s
                else
                    keeper[75] = keeper[75] + "_" + value.to_s
                end


                res = TestType.where(name: "Microalbumin").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[76] = value.to_s
                else
                    keeper[76] = keeper[76] + "_" + value.to_s
                end


                res = TestType.where(name: "Phosphorus").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[77] = value.to_s
                else
                    keeper[77] = keeper[77] + "_" + value.to_s
                end
                
                

                res = Measure.where(name: "Potassium").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[78] = value.to_s
                else
                    keeper[78] = keeper[78] + "_" + value.to_s
                end	



                res = TestType.where(name: "Rheumatoid Factor Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[79] = value.to_s
                else
                    keeper[79] = keeper[79] + "_" + value.to_s
                end


                res = Measure.where(name: "Sodium").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[80] = value.to_s
                else
                    keeper[80] = keeper[80] + "_" + value.to_s
                end	


                res = Measure.where(name: "Triglycerides(TG)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[81] = value.to_s
                else
                    keeper[81] = keeper[81] + "_" + value.to_s
                end	


                res = TestType.where(name: "Urea").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[82] = value.to_s
                else
                    keeper[82] = keeper[82] + "_" + value.to_s
                end


                res = TestType.where(name: "Uric Acid").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[83] = value.to_s
                else
                    keeper[83] = keeper[83] + "_" + value.to_s
                end


                checker = checker + 1
            
                indicator_data_bio['Blood glucose'] =  keeper[49]
                indicator_data_bio['CSF glucose'] =  keeper[50]
                indicator_data_bio['Total Protein'] =  keeper[51]
                indicator_data_bio['Albumin'] =  keeper[52]
                indicator_data_bio['Alkaline Phosphatase(ALP)'] =  keeper[53]
                indicator_data_bio['Alanine aminotransferase (ALT)'] =  keeper[54]
                indicator_data_bio['Amylase'] =  keeper[55]
                indicator_data_bio['Antistreptolysin O (ASO)'] =  keeper[56]
                indicator_data_bio['Aspartate aminotransferase(AST)'] =  keeper[57]
                indicator_data_bio['Bilirubin Total'] =  keeper[58]
                indicator_data_bio['Bilirubin Direct'] =  keeper[59]
                indicator_data_bio['Calcium'] =  keeper[60]
                indicator_data_bio['Chloride'] =  keeper[61]
                indicator_data_bio['Cholesterol Total'] =  keeper[62]
                indicator_data_bio['Cholesterol LDL'] =  keeper[63]
                indicator_data_bio['Cholesterol HDL'] =  keeper[64]
                indicator_data_bio['Cholinesterase'] =  keeper[65]
                indicator_data_bio['C Reactive Protein (CRP)'] =  keeper[66]
                indicator_data_bio['Creatinine'] =  keeper[67]
                indicator_data_bio['Creatine Kinase NAC'] =  keeper[68]
                indicator_data_bio['Creatine Kinase MB'] =  keeper[69]
                indicator_data_bio['Haemoglobin A1c'] =  keeper[70]
                indicator_data_bio['Iron'] =  keeper[71]
                indicator_data_bio['Lipase'] =  keeper[72]
                indicator_data_bio['Lactate Dehydrogenase (LDH)'] =  keeper[73]
                indicator_data_bio['Magnesium'] =  keeper[74]
                indicator_data_bio['Micro-protein'] =  keeper[75]
                indicator_data_bio['Micro-albumin'] =  keeper[76]
                indicator_data_bio['Phosphorus'] =  keeper[77]
                indicator_data_bio['Potassium'] =  keeper[78]
                indicator_data_bio['Rheumatoid Factor'] =  keeper[79]
                indicator_data_bio['Sodium'] =  keeper[80]
                indicator_data_bio['Triglycerides'] =  keeper[81]
                indicator_data_bio['Urea'] =  keeper[82]
                indicator_data_bio['Uric acid'] =  keeper[83]

                data["Biochemistry"] =  indicator_data_bio



        end






















        elsif depart_option == "Haematology"
            
            months = MoHReport.generate_quater(quater)
           
            months.each do |month|
                period = year + "-" + month
                res = TestType.where(name: "FBC").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[0] = value.to_s
                else
                    keeper[0] = keeper[0] + "_" + value.to_s
                end
            

                res = TestType.where(name: "ESR").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count
                if checker == 0
                    keeper[1] = value.to_s
                else
                    keeper[1] = keeper[1] + "_" + value.to_s
                end
            


                res = TestType.where(name: "Sickling Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count
                if checker == 0
                    keeper[2] = value.to_s
                else
                    keeper[2] = keeper[2] + "_" + value.to_s
                end
            


                res = TestType.where(name: "Prothrombin Time").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count
                if checker == 0
                    keeper[3] = value.to_s
                else
                    keeper[3] = keeper[3] + "_" + value.to_s
                end
            


                res = TestType.where(name: "APTT").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count
                if checker == 0
                    keeper[4] = value.to_s
                else
                    keeper[4] = keeper[4] + "_" + value.to_s
                end
       

                
                checker = checker + 1
            end 

            indicator_data['Full Blood Count'] =  keeper[0]
            indicator_data['Erythrocyte Sedimentation Rate (ESR)'] =  keeper[1]
            indicator_data['Sickling Test'] =  keeper[2]
            indicator_data['Prothrombin time (PT)'] =  keeper[3]
            indicator_data['Activated Partial Thromboplastin Time (APTT)'] =  keeper[4]
            data["Haematology"] =  indicator_data














        elsif depart_option == "Microbiology" 
					
            months = MoHReport.generate_quater(quater)
           
            months.each do |month|
                period = year + "-" + month
                
                res = TestType.where(name: "TB Microscopic Exam").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[0] = value.to_s
                else
                    keeper[0] = keeper[0] + "_" + value.to_s
                end


                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[1] = value.to_s
                else
                    keeper[1] = keeper[1] + "_" + value.to_s
                end



                res = Measure.where(name: "Smear microscopy result").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND (result = '++' OR result = '+++' OR result = '+' OR result = 'positive'))"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[2] = value.to_s
                else
                    keeper[2] = keeper[2] + "_" + value.to_s
                end




                res = SpecimenType.where(name: "CSF").first
                test_id = res.id
                res = Order.find_by_sql("SELECT count(*) AS test_count FROM 
                                orders WHERE specimen_type_id = '#{test_id}' AND 
                                (substr(date_created,1,7) = '#{period}')"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[3] = value.to_s
                else
                    keeper[3] = keeper[3] + "_" + value.to_s
                end



                res = SpecimenType.where(name: "HVS").first
                test_id = res.id
                res = Order.find_by_sql("SELECT count(*) AS test_count FROM 
                                orders WHERE specimen_type_id = '#{test_id}' AND 
                                (substr(date_created,1,7) = '#{period}')"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[4] = value.to_s
                else
                    keeper[4] = keeper[4] + "_" + value.to_s
                end


                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result ='MTB NOT DETECTED')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[5] = value.to_s
                else
                    keeper[5] = keeper[5] + "_" + value.to_s
                end


                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result ='RIF Resistant Detected')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[6] = value.to_s
                else
                    keeper[6] = keeper[6] + "_" + value.to_s
                end



                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result ='RIF Resistant Not Detected')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[7] = value.to_s
                else
                    keeper[7] = keeper[7] + "_" + value.to_s
                end


                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result ='RIF Resistant Indeterminate')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[8] = value.to_s
                else
                    keeper[8] = keeper[8] + "_" + value.to_s
                end




                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (test_results.result = 'Invalid' OR test_results.result = 'invalid'))"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[9] = value.to_s
                else
                    keeper[9] = keeper[9] + "_" + value.to_s
                end


                res = TestType.where(name: "TB Tests").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result IS NULL)"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[10] = value.to_s
                else
                    keeper[10] = keeper[10] + "_" + value.to_s
                end


                res = TestType.where(name: "Culture & Sensitivity").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' )"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[11] = value.to_s
                else
                    keeper[11] = keeper[11] + "_" + value.to_s
                end




                res = TestType.where(name: "Culture & Sensitivity").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests 
                                INNER JOIN test_results ON tests.id = test_results.test_id
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND test_results.result = 'Growth')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[12] = value.to_s
                else
                    keeper[12] = keeper[12] + "_" + value.to_s
                end




                            
                checker = checker + 1


                indicator_data['Number of AFB sputum examined'] =  keeper[0]
                indicator_data['Number of  new TB cases examined'] =  keeper[1]
                indicator_data['New cases with positive smear'] =  keeper[2]
                indicator_data['MTB Not Detected'] =  keeper[5]
                indicator_data['RIF Resistant Detected'] =  keeper[6]
                indicator_data['RIF Resistant Not Detected'] =  keeper[7]
                indicator_data['RIF Resistant Indeterminate'] =  keeper[8]
                indicator_data['Invalid'] =  keeper[9]
                indicator_data['No results'] =  keeper[10]
                indicator_data['Number of CSF samples analysed'] =  keeper[3]
                indicator_data['Number of CSF samples analysed for AFB'] =  keeper[3]
                indicator_data['Number of CSF samples with Organism'] =  keeper[3]
                indicator_data['HVS analysed '] =  keeper[4]
                indicator_data['Number of Blood Cultures done'] =  keeper[11]
				indicator_data['Positive blood Cultures'] =  keeper[12]
				indicator_data['Number of tests on microscopy'] =  keeper[5]
				indicator_data['Number of tests on GeneXpert'] =  keeper[1]
				indicator_data['MTB Detected'] =  keeper[2]
				indicator_data['India ink positive'] =  keeper[0]
				indicator_data['Gram stain positive'] =  keeper[0]

                data["Microbiology"] =  indicator_data
            end
        













        elsif depart_option == "Biochemistry"
            
            months = MoHReport.generate_quater(quater)
           
            months.each do |month|
                period = year + "-" + month
                    
                res = TestType.where(name: "Glucose").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[0] = value.to_s
                else
                    keeper[0] = keeper[0] + "_" + value.to_s
                end

                res = TestType.where(name: "Glucose").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[1] = value.to_s
                else
                    keeper[1] = keeper[1] + "_" + value.to_s
                end

                res = TestType.where(name: "Total Protein").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[2] = value.to_s
                else
                    keeper[2] = keeper[2] + "_" + value.to_s
                end

                res = Measure.where(name: "Albumin(ALB)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[3] = value.to_s
                else
                    keeper[3] = keeper[3] + "_" + value.to_s
                end


                res = Measure.where(name: "Alkaline Phosphate(ALP)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[4] = value.to_s
                else
                    keeper[4] = keeper[4] + "_" + value.to_s
                end




                res = Measure.where(name: "ALT/GPT").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[5] = value.to_s
                else
                    keeper[5] = keeper[5] + "_" + value.to_s
                end


                res = Measure.where(name: "Amylase").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[6] = value.to_s
                else
                    keeper[6] = keeper[6] + "_" + value.to_s
                end



                
                
                res = Measure.where(name: "Antistreptolysin O (ASO)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[7] = value.to_s
                else
                    keeper[7] = keeper[7] + "_" + value.to_s
                end



                res = Measure.where(name: "AST/GOT").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[8] = value.to_s
                else
                    keeper[8] = keeper[8] + "_" + value.to_s
                end


                res = Measure.where(name: "Bilirubin Total(BIT))").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[9] = value.to_s
                else
                    keeper[9] = keeper[9] + "_" + value.to_s
                end


                res = Measure.where(name: "Bilirubin Direct(BID)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[10] = value.to_s
                else
                    keeper[10] = keeper[10] + "_" + value.to_s
                end


                res = TestType.where(name: "Calcium").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[11] = value.to_s
                else
                    keeper[11] = keeper[11] + "_" + value.to_s
                end



                res = Measure.where(name: "Chloride").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[12] = value.to_s
                else
                    keeper[12] = keeper[12] + "_" + value.to_s
                end



                res = Measure.where(name: "Cholestero l(CHOL)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[13] = value.to_s
                else
                    keeper[13] = keeper[13] + "_" + value.to_s
                end


                res = Measure.where(name: "Cholestero l(CHOL)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[14] = value.to_s
                else
                    keeper[14] = keeper[14] + "_" + value.to_s
                end


                res = Measure.where(name: "Cholestero l(CHOL)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[15] = value.to_s
                else
                    keeper[15] = keeper[15] + "_" + value.to_s
                end


                res = Measure.where(name: "Cholestero l(CHOL)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[16] = value.to_s
                else
                    keeper[16] = keeper[16] + "_" + value.to_s
                end


                res = TestType.where(name: "C-reactive protein").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[17] = value.to_s
                else
                    keeper[17] = keeper[17] + "_" + value.to_s
                end


                res = TestType.where(name: "Creatinine").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[18] = value.to_s
                else
                    keeper[18] = keeper[18] + "_" + value.to_s
                end



                res = Measure.where(name: "Creatine Kinase(CKN)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[19] = value.to_s
                else
                    keeper[19] = keeper[19] + "_" + value.to_s
                end
            

                res = Measure.where(name: "Creatine Kinase MB(CKMB)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[20] = value.to_s
                else
                    keeper[20] = keeper[20] + "_" + value.to_s
                end



                res = TestType.where(name: "HbA1c").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[21] = value.to_s
                else
                    keeper[21] = keeper[21] + "_" + value.to_s
                end

                

                res = TestType.where(name: "Iron Studies").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[22] = value.to_s
                else
                    keeper[22] = keeper[22] + "_" + value.to_s
                end

                
                res = Measure.where(name: "Lipase").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[23] = value.to_s
                else
                    keeper[23] = keeper[23] + "_" + value.to_s
                end						
                

                res = Measure.where(name: "LDH").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[24] = value.to_s
                else
                    keeper[24] = keeper[24] + "_" + value.to_s
                end						
                


                res = Measure.where(name: "Magnesium (MGXB)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[25] = value.to_s
                else
                    keeper[25] = keeper[25] + "_" + value.to_s
                end						
                


                res = TestType.where(name: "Microprotein").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[26] = value.to_s
                else
                    keeper[26] = keeper[26] + "_" + value.to_s
                end


                res = TestType.where(name: "Microalbumin").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[27] = value.to_s
                else
                    keeper[27] = keeper[27] + "_" + value.to_s
                end


                res = TestType.where(name: "Phosphorus").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[28] = value.to_s
                else
                    keeper[28] = keeper[28] + "_" + value.to_s
                end
                
                

                res = Measure.where(name: "Potassium").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[29] = value.to_s
                else
                    keeper[29] = keeper[29] + "_" + value.to_s
                end	



                res = TestType.where(name: "Rheumatoid Factor Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[30] = value.to_s
                else
                    keeper[30] = keeper[30] + "_" + value.to_s
                end


                res = Measure.where(name: "Sodium").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[31] = value.to_s
                else
                    keeper[31] = keeper[31] + "_" + value.to_s
                end	


                res = Measure.where(name: "Triglycerides(TG)").first
                test_id = res.id
                res = TestResult.find_by_sql("SELECT count(*) AS test_count FROM 
                                test_results WHERE measure_id = '#{test_id}' AND 
                                (substr(time_entered,1,7) = '#{period}' AND test_results.result IS NOT NULL)"
                                )
                value = res[0].test_count

                if checker == 0
                    keeper[32] = value.to_s
                else
                    keeper[32] = keeper[32] + "_" + value.to_s
                end	


                res = TestType.where(name: "Urea").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[33] = value.to_s
                else
                    keeper[33] = keeper[33] + "_" + value.to_s
                end


                res = TestType.where(name: "Uric Acid").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[34] = value.to_s
                else
                    keeper[34] = keeper[34] + "_" + value.to_s
                end


                checker = checker + 1
            
                indicator_data['Blood glucose'] =  keeper[0]
                indicator_data['CSF glucose'] =  keeper[1]
                indicator_data['Total Protein'] =  keeper[2]
                indicator_data['Albumin'] =  keeper[3]
                indicator_data['Alkaline Phosphatase(ALP)'] =  keeper[4]
                indicator_data['Alanine aminotransferase (ALT)'] =  keeper[5]
                indicator_data['Amylase'] =  keeper[6]
                indicator_data['Antistreptolysin O (ASO)'] =  keeper[7]
                indicator_data['Aspartate aminotransferase(AST)'] =  keeper[8]
                indicator_data['Bilirubin Total'] =  keeper[9]
                indicator_data['Bilirubin Direct'] =  keeper[10]
                indicator_data['Calcium'] =  keeper[11]
                indicator_data['Chloride'] =  keeper[12]
                indicator_data['Cholesterol Total'] =  keeper[13]
                indicator_data['Cholesterol LDL'] =  keeper[14]
                indicator_data['Cholesterol HDL'] =  keeper[15]
                indicator_data['Cholinesterase'] =  keeper[16]
                indicator_data['C Reactive Protein (CRP)'] =  keeper[17]
                indicator_data['Creatinine'] =  keeper[18]
                indicator_data['Creatine Kinase NAC'] =  keeper[19]
                indicator_data['Creatine Kinase MB'] =  keeper[20]
                indicator_data['Haemoglobin A1c'] =  keeper[21]
                indicator_data['Iron'] =  keeper[22]
                indicator_data['Lipase'] =  keeper[23]
                indicator_data['Lactate Dehydrogenase (LDH)'] =  keeper[24]
                indicator_data['Magnesium'] =  keeper[25]
                indicator_data['Micro-protein'] =  keeper[26]
                indicator_data['Micro-albumin'] =  keeper[27]
                indicator_data['Phosphorus'] =  keeper[28]
                indicator_data['Potassium'] =  keeper[29]
                indicator_data['Rheumatoid Factor'] =  keeper[30]
                indicator_data['Sodium'] =  keeper[31]
                indicator_data['Triglycerides'] =  keeper[32]
                indicator_data['Urea'] =  keeper[33]
                indicator_data['Uric acid'] =  keeper[34]

                data["Biochemistry"] =  indicator_data



            end
        








        

        elsif depart_option == "Parasitology"
		
            months = MoHReport.generate_quater(quater)
           
            months.each do |month|
                period = year + "-" + month
                
                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Blood film' AND test_results.result !='0' ))"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[0] = value.to_s
                else
                    keeper[0] = keeper[0] + "_" + value.to_s
                end

                per = period + "-28"
                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Blood film' AND (((DATEDIFF('#{per}',patients.dob) / 365) < 5.5) AND test_results.result !='0')))"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[1] = value.to_s
                else
                    keeper[1] = keeper[1] + "_" + value.to_s
                end


                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Blood film' AND (DATEDIFF('#{per}',patients.dob) / 365) < 5.5) 
                                AND  test_results.result != 'No parasite seen')"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[2] = value.to_s
                else
                    keeper[2] = keeper[2] + "_" + value.to_s
                end


                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Blood film' AND patients.dob = 'NaNNaNNaNNaNNaNNaN' ))"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[3] = value.to_s
                else
                    keeper[3] = keeper[3] + "_" + value.to_s
                end



                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Blood film' AND (patients.dob = 'NaNNaNNaNNaNNaNNaN' AND test_results.result != 'No parasite seen')))"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[4] = value.to_s
                else
                    keeper[4] = keeper[4] + "_" + value.to_s
                end



                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND test_results.result !='0' ))"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[5] = value.to_s
                else
                    keeper[5] = keeper[5] + "_" + value.to_s
                end




                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND test_results.result ='Positive' ))"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[6] = value.to_s
                else
                    keeper[6] = keeper[6] + "_" + value.to_s
                end



                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND (((DATEDIFF('#{per}',patients.dob) / 365) <= 5.5) AND test_results.result !='0')))"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[7] = value.to_s
                else
                    keeper[7] = keeper[7] + "_" + value.to_s
                end


                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND (((DATEDIFF('#{per}',patients.dob) / 365) <= 5.5) AND test_results.result ='Positive') ))"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[8] = value.to_s
                else
                    keeper[8] = keeper[8] + "_" + value.to_s
                end



                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND (((DATEDIFF('#{per}',patients.dob) / 365) >= 5.5) AND test_results.result !='0')))"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[9] = value.to_s
                else
                    keeper[9] = keeper[9] + "_" + value.to_s
                end


                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND (((DATEDIFF('#{per}',patients.dob) / 365) >= 5.5) AND test_results.result ='Positive') ))"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[10] = value.to_s
                else
                    keeper[10] = keeper[10] + "_" + value.to_s
                end



                res = TestType.where(name: "Malaria Screening").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id
                                INNER JOIN patients ON patients.id = orders.patient_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'MRDT' AND test_results.result ='Invalid' ))"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[11] = value.to_s
                else
                    keeper[11] = keeper[11] + "_" + value.to_s
                end


                res = TestType.where(name: "Urine Microscopy").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' )"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[12] = value.to_s
                else
                    keeper[12] = keeper[12] + "_" + value.to_s
                end



                res = TestType.where(name: "Semen Analysis").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                WHERE test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' )"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[13] = value.to_s
                else
                    keeper[13] = keeper[13] + "_" + value.to_s
                end


                checker = checker + 1
                
                indicator_data['Total malaria microscopy tests done'] =  keeper[0]
                indicator_data['Malaria microscopy in ≤ 5yrs (by species)?'] =  keeper[1]
                indicator_data['Positive malaria slides in < 5yrs'] =  keeper[2]
                indicator_data['Malaria microscopy in unknown age'] =  keeper[3]
                indicator_data['Positive malaria slides in unknown age'] =  keeper[4]
                indicator_data['Total MRDTs Done'] =  keeper[5]
                indicator_data['MRDTs Positives'] =  keeper[6]
                indicator_data['MRDTs in ≤  5yrs'] =  keeper[7]
                indicator_data['MRDT Positives in < 5yrs'] =  keeper[8] 
                indicator_data['MRDTs in >= 5yrs'] =  keeper[9] 
                indicator_data['MRDT Positives in > 5yrs'] =  keeper[10] 
                indicator_data['Total invalid MRDTs tests'] =  keeper[11] 
                indicator_data['Trypanosome tests'] = keeper[11] 
                indicator_data['Positive tests'] =  keeper[11] 
                indicator_data['Urine microscopy total'] =  keeper[12] 
                indicator_data['Schistosome Haematobium'] =  keeper[11]   
                indicator_data['Other urine parasites'] =  keeper[11]  
                indicator_data['urine chemistry (count)'] =  keeper[11]
				indicator_data['Semen analysis (count)'] =  keeper[13]
				
				indicator_data['Blood Parasites (count)'] = keeper[5]
				indicator_data['Blood Parasites seen'] = keeper[6]
				indicator_data['Stool Microscopy (count)'] =  keeper[6]
				indicator_data['Stool Microscopy Parasites seen'] =  keeper[6]
			
                data["Parasitology"] =  indicator_data
            end

        













        
        elsif depart_option == "Serology"
            
            months = MoHReport.generate_quater(quater)
           
            months.each do |month|
                period = year + "-" + month

                res = TestType.where(name: "Syphilis Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[0] = value.to_s
                else
                    keeper[0] = keeper[0] + "_" + value.to_s
                end
                

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

                if checker == 0
                    keeper[1] = value.to_s
                else
                    keeper[1] = keeper[1] + "_" + value.to_s
                end



                res = TestType.where(name: "Hepatitis B Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[2] = value.to_s
                else
                    keeper[2] = keeper[2] + "_" + value.to_s
                end
                

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

                if checker == 0
                    keeper[3] = value.to_s
                else
                    keeper[3] = keeper[3] + "_" + value.to_s
                end



                res = TestType.where(name: "Hepatitis C Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[4] = value.to_s
                else
                    keeper[4] = keeper[4] + "_" + value.to_s
                end
                    

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

                if checker == 0
                    keeper[5] = value.to_s
                else
                    keeper[5] = keeper[5] + "_" + value.to_s
                end

                

                res = TestType.where(name: "Pregnancy Test").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[6] = value.to_s
                else
                    keeper[6] = keeper[6] + "_" + value.to_s
                end
                    


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

                if checker == 0
                    keeper[7] = value.to_s
                else
                    keeper[7] = keeper[7] + "_" + value.to_s
                end


                res = TestType.where(name: "HIV").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests WHERE test_type_id = '#{test_id}' AND 
                                (substr(time_created,1,7) = '#{period}')"

                                )
                value = res[0].test_count

                if checker == 0
                    keeper[8] = value.to_s
                else
                    keeper[8] = keeper[8] + "_" + value.to_s
                end



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

                if checker == 0
                    keeper[9] = value.to_s
                else
                    keeper[9] = keeper[9] + "_" + value.to_s
                end

                checker = checker + 1
                indicator_data['Syphilis Test'] =  keeper[0]
                indicator_data['Syphilis screening on patients (by depart_option)'] =  keeper[0]
                indicator_data['Positive tests^'] =  keeper[1]
                indicator_data['Syphilis screening on antenatal mothers'] =  keeper[0]
                indicator_data['Positive tests ^'] =  keeper[0]
                indicator_data['HepBs test done on patients'] =  keeper[2]
                indicator_data['Positive_tests  ^'] =  keeper[3]
                indicator_data['HepC test done on patients'] =  keeper[4]
                indicator_data['Positive tests  ^'] =  keeper[5]
                indicator_data['Hcg  Pregnacy tests done'] =  keeper[6]
                indicator_data['Positive tests   ^'] =  keeper[7]
                indicator_data['HIV tests on PEP'] =  keeper[8]
                indicator_data['positives tests    ^'] =  keeper[9]

                data["Serology"] =  indicator_data

            end

        







        
        elsif depart_option == "Blood_Bank"
		
            months = MoHReport.generate_quater(quater)
           
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

                if checker == 0
                    keeper[0] = value.to_s
                else
                    keeper[0] = keeper[0] + "_" + value.to_s
                end


                res = TestType.where(name: "Cross-match").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id	
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                (substr(tests.time_created,1,7) = '#{period}' AND (measures.name = 'Pack ABO Group' AND test_results.result IS NOT NULL ))"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[1] = value.to_s
                else
                    keeper[1] = keeper[1] + "_" + value.to_s
                end



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

                if checker == 0
                    keeper[2] = value.to_s
                else
                    keeper[2] = keeper[2] + "_" + value.to_s
                end




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

                if checker == 0
                    keeper[3] = value.to_s
                else
                    keeper[3] = keeper[3] + "_" + value.to_s
                end


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

                if checker == 0
                    keeper[4] = value.to_s
                else
                    keeper[4] = keeper[4] + "_" + value.to_s
                end



                res = TestType.where(name: "Cross-match").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id 
                                INNER JOIN wards ON wards.id = orders.ward_id	
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                ((substr(tests.time_created,1,7) = '#{period}' ) AND (measures.name = 'Pack ABO Group' AND test_results.result IS NULL ))"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[5] = value.to_s
                else
                    keeper[5] = keeper[5] + "_" + value.to_s
                end


                res = TestType.where(name: "Cross-match").first
                test_id = res.id
                res = Test.find_by_sql("SELECT count(*) AS test_count FROM 
                                tests INNER JOIN test_results ON test_results.test_id = tests.id 
                                INNER JOIN measures ON measures.id = test_results.measure_id
                                INNER JOIN orders ON orders.id = tests.order_id 
                                INNER JOIN wards ON wards.id = orders.ward_id	
                                WHERE tests.test_type_id = '#{test_id}' AND 
                                ((substr(tests.time_created,1,7) = '#{period}' ) AND (measures.name = 'Pack ABO Group' AND test_results.result IS NULL ))"
                                )

                value = res[0].test_count

                if checker == 0
                    keeper[6] = value.to_s
                else
                    keeper[6] = keeper[6] + "_" + value.to_s
                end


                
                checker = checker + 1
                indicator_data['blood grouping done on Patients'] =  keeper[0]
                indicator_data['Total X-matched'] =  keeper[1]
                indicator_data['X- matched for matenity'] =  keeper[2]
                indicator_data['X-macthed for peads'] =  keeper[3]
                indicator_data['X-matched for others'] =  keeper[4]
                indicator_data['X-matches done on patients with Hb ≤ 6.0g/dl'] =  keeper[5]
                indicator_data['X-matches done on patients with Hb > 6.0g/dl'] =  keeper[6]

                data["Blood Bank"] =  indicator_data


            end

        end        

        return  data
    end








#begining of another method-------

    def self.by_lab_depart_options

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
