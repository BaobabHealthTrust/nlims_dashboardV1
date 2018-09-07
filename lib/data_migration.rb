module DataMigration
    

    def self.load_tests
        tests = File.read("#{Rails.root}/public/master_tests.sql")
        status = false
        if tests.length != 26
            configs = YAML.load_file("#{Rails.root}/config/database.yml")[Rails.env]    
            client = Mysql2::Client.new(:host => "localhost", :username => "#{configs['username']}", :password => "#{configs['password']}", :database => "#{configs['database']}")
            client.query(tests)
            status = true
        end
        
        return status
    end
     
    
    def self.load_tests_results
        
        tests = File.read("#{Rails.root}/public/master_test_results.sql")
        status = false
        if tests.length != 33
            configs = YAML.load_file("#{Rails.root}/config/database.yml")[Rails.env]    
            client = Mysql2::Client.new(:host => "localhost", :username => "#{configs['username']}", :password => "#{configs['password']}", :database => "#{configs['database']}")
            client.query(tests)
            status = true
        end
    
        return status
    end

    def self.load_orders
        tests = File.read("#{Rails.root}/public/master_orders.sql")
        status = false
        if tests.length != 27
            configs = YAML.load_file("#{Rails.root}/config/database.yml")[Rails.env]    
            client = Mysql2::Client.new(:host => "localhost", :username => "#{configs['username']}", :password => "#{configs['password']}", :database => "#{configs['database']}")
            client.query(tests)
            status = true
        end

        return status
    end


    def self.load_slave_orders
        tests = File.read("#{Rails.root}/public/slave_orders.sql")
        status = false
        if tests.length != 33
            configs = YAML.load_file("#{Rails.root}/config/database.yml")[Rails.env]    
            client = Mysql2::Client.new(:host => "localhost", :username => "#{configs['username']}", :password => "#{configs['password']}", :database => "#{configs['database']}")
            client.query(tests)
            status = true
        end
    
        return status
    end


    def self.load_slave_tests
        tests = File.read("#{Rails.root}/public/slave_tests.sql")        
        status = false
        if tests.length != 32
            configs = YAML.load_file("#{Rails.root}/config/database.yml")[Rails.env]    
            client = Mysql2::Client.new(:host => "localhost", :username => "#{configs['username']}", :password => "#{configs['password']}", :database => "#{configs['database']}")
            client.query(tests)
            status4 = true
        end
    
        return status
    end


    def self.load_slave_test_results
        tests = File.read("#{Rails.root}/public/slave_test_results.sql")
        status = false
        if tests.length != 39
            configs = YAML.load_file("#{Rails.root}/config/database.yml")[Rails.env]    
            client = Mysql2::Client.new(:host => "localhost", :username => "#{configs['username']}", :password => "#{configs['password']}", :database => "#{configs['database']}")
            client.query(tests)
            status = true
        end
    
        return status
    end


    def self.escape_characters(value)

        value = value.to_s.gsub(/'/,"")
        value = value.to_s.gsub(/,/," ")
        value = value.to_s.gsub(/;/," ")
        value = value.to_s.gsub(")"," ")
        value = value.to_s.gsub("("," ")
        value = value.to_s.gsub("/"," ")
        value = value.to_s.gsub('\\'," ")
  
  
      return value
    end


    def self.check_files
        if !File.exists?("#{Rails.root}/public/master_orders.sql")
            FileUtils.touch "#{Rails.root}/public/master_orders.sql"
        else
            FileUtils.rm("#{Rails.root}/public/master_orders.sql")
            FileUtils.touch "#{Rails.root}/public/master_orders.sql"
        end
      
        if !File.exists?("#{Rails.root}/public/master_tests.sql")
            FileUtils.touch("#{Rails.root}/public/master_tests.sql")
        else
            FileUtils.rm("#{Rails.root}/public/master_tests.sql")
            FileUtils.touch "#{Rails.root}/public/master_tests.sql"
        end
        
        if !File.exists?("#{Rails.root}/public/master_test_results.sql")
            FileUtils.touch "#{Rails.root}/public/master_test_results.sql"
        else
            FileUtils.rm("#{Rails.root}/public/master_test_results.sql")
            FileUtils.touch "#{Rails.root}/public/master_test_results.sql"
        end


        if !File.exists?("#{Rails.root}/public/slave_orders.sql")
            FileUtils.touch "#{Rails.root}/public/slave_orders.sql"
        else
            FileUtils.rm("#{Rails.root}/public/slave_orders.sql")
            FileUtils.touch "#{Rails.root}/public/slave_orders.sql"
        end
      
        if !File.exists?("#{Rails.root}/public/slave_tests.sql")
            FileUtils.touch("#{Rails.root}/public/slave_tests.sql")
        else
            FileUtils.rm("#{Rails.root}/public/slave_tests.sql")
            FileUtils.touch "#{Rails.root}/public/slave_tests.sql"
        end
        
        if !File.exists?("#{Rails.root}/public/slave_test_results.sql")
            FileUtils.touch "#{Rails.root}/public/slave_test_results.sql"
        else
            FileUtils.rm("#{Rails.root}/public/slave_test_results.sql")
            FileUtils.touch "#{Rails.root}/public/slave_test_results.sql"
        end
    end
      
    def self.appendSemicolon
        File.open("#{Rails.root}/app/assets/orders.sql","a") do |txt|  
            
             txt.puts "\r" +  ";"
        end
   
    end


    def self.createHeaders
        File.open("#{Rails.root}/public/master_orders.sql","a") do |txt|  
            
             txt.puts "\r" +  "INSERT INTO orders VALUES"
        end
   
        File.open("#{Rails.root}/public/master_tests.sql","a") do |txt|  
            
             txt.puts "\r" +  "INSERT INTO tests VALUES"
        end
   
        File.open("#{Rails.root}/public/master_test_results.sql","a") do |txt|  
            
             txt.puts "\r" +  "INSERT INTO test_results VALUES"
        end 


        File.open("#{Rails.root}/public/slave_orders.sql","a") do |txt|  
            
             txt.puts "\r" +  "INSERT INTO slave_orders VALUES"
        end
   
        File.open("#{Rails.root}/public/slave_tests.sql","a") do |txt|  
            
             txt.puts "\r" +  "INSERT INTO slave_tests VALUES"
        end
   
        File.open("#{Rails.root}/public/slave_test_results.sql","a") do |txt|  
            
             txt.puts "\r" +  "INSERT INTO slave_test_results VALUES"
        end 
   
    end
    
    def self.track_test_number
        num = Test.find_by_sql("SELECT id AS tst_id FROM tests ORDER BY id DESC limit 1")
        if num.blank?
            num = 1
        else
            num = num[0]["tst_id"] + 1
        end
       return num 
    end


    def self.track_test_results_number
        num = Test.find_by_sql("SELECT id AS tst_id FROM test_results ORDER BY id DESC limit 1")
        if num.blank?
            num = 1
        else
            num = num[0]["tst_id"] + 1
        end
        return num + 1
    end


    def self.load_data(year,quarter)      
        quarter = DataMigration.generate_quater(quarter)
        order_id = 1
        testid = 1
        results_incrementor = 0
        trials_incrementor = 0
        patient_incrementor = 0
        checker = 0
        order_values = []
        order_counter = 0
        test_counter = track_test_number
        trail_counter = 0
        results_counter = 0
        patient_counter =0
        master_order_counter = 0 
        master_test_Count = 0
        test_Count = 0
        test_results_counter = track_test_results_number
      

        start_time = year + quarter[0].to_s + "070000"
        end_time = year + quarter[1].to_s + "070000"
        measure_counter = 0
        measure_counter1 = 0
        Couchorder.generic.startkey([start_time]).endkey([end_time]).each do |order|
            empty = "'" + "'"
          
            #order general details
            tracking_number = escape_characters(order['_id'])
            order_status = escape_characters(order['status'])
            sending_facility = "'" + escape_characters(order['sending_facility']) + "'"
            receiving_lab = "'" + escape_characters(order['receiving_facility']) + "'"
            sample_type = escape_characters(order['sample_type'])
            date_drawn = escape_characters(order['date_drawn'])
            date_time = escape_characters(order['date_time'])
            date_received = escape_characters(order['date_received'])
            priority = escape_characters(order['priority'])
            order_location = escape_characters(order['order_location'])
            district = escape_characters(order['district'])
            who_order_fname = escape_characters(order['who_order_test']['first_name'])
            who_order_lname = escape_characters(order['who_order_test']['last_name'])
            who_order_id = escape_characters(order['who_order_test']['id_number'])
            who_order_phone = escape_characters(order['who_order_test']['phone_number'])
            dispatcher_id =  "#{"'" + '0' + "'"}"
            dispatcher_fname = escape_characters(order['who_dispatched']['first_name']) rescue empty
            dispatcher_lname = escape_characters(order['who_dispatched']['last_name']) rescue empty
            dispatcher_phone = "#{"'" + '+265' +"'"}"
            art_start_date = '20180101020000' if order['art_start_date'].blank? 
            art_start_date = order['art_start_date'] if !order['art_start_date'].blank?
            date_dispatched = '20180101020000' 
            
            date_dispatched = "#{"'" +  date_dispatched + "'"}"
            art_start_date = "#{"'" + art_start_date + "'"}"
            sample_data_checker = false
           
            
            
            if receiving_lab.blank?

            elsif date_drawn.blank?

            elsif district.blank?

            elsif order_location.blank?
                
            else
                    sample_checker = SpecimenType.check_specimen_type(sample_type)
                    sending_facility_checker = Site.check_site(order['sending_facility'])
                    receiving_facility_checker =  Site.check_site( order['receiving_facility'])
                    order_location_checker = Ward.check_ward(order_location)
                    sample_status_checker =  SpecimenStatus.check_specimen_status(order_status)                  
           
            
                if (sample_checker == true && sending_facility_checker == true) && ((receiving_facility_checker == true && order_location_checker == true) && sample_status_checker == true) 
                    sample_data_checker = true                   
                end

                if sample_data_checker == false
                    sample_type_checker = "'" + escape_characters(sample_type) + "'"
                    sending_facility_check = "'" + escape_characters(sending_facility) + "'"
                    receiving_facility_check = "'" + escape_characters(receiving_lab) + "'"
                    order_location_check = "'" + escape_characters(order_location) + "'"
                    sample_status_check = "'" + escape_characters(order_status) + "'"

                    if sample_checker == false
                        sample_type_checker = "'" + "not-resolved" + "'"
                    end

                    if sending_facility_checker == false
                        sending_facility_check = "'" + "not-resolved" + "'"
                    end

                    if receiving_facility_checker == false
                        receiving_facility_check = "'" + "not-resolved" + "'"
                    end
                    
                    if order_location_checker == false
                        order_location_check = "'" + "not-resolved" + "'"
                    end

                    if sample_status_checker == false
                        sample_status_check = "'" +  "not-resolved" + "'"
                     end
                    
                    empty = "'" + "'"
                    File.open("#{Rails.root}/public/slave_orders.sql","a") do |txt|                 
                        if (order_counter==0)
                            txt.puts "\r" + "(#{"'" + self.escape_characters(tracking_number) + "'"},#{sending_facility},#{ sending_facility_check },#{receiving_lab},#{receiving_facility_check},#{"'" + self.escape_characters(sample_type) + "'"},#{sample_type_checker },#{"'" + self.escape_characters(who_order_fname) + "'" rescue empty},#{"'" + self.escape_characters(who_order_lname) + "'" rescue empty},#{"'" + self.escape_characters(who_order_id) + "'" rescue empty},#{"'" + self.escape_characters(who_order_phone) + "'" rescue 0},#{art_start_date},#{"'" + self.escape_characters(order['date_dispatched']) + "'" rescue empty},#{"'" + self.escape_characters(date_drawn) + "'"},#{"'" + self.escape_characters(date_received) + "'"},#{"'" + self.escape_characters(date_drawn) + "'"},#{"'" + self.escape_characters(district) + "'"},#{"'" + self.escape_characters(order_location) + "'"},#{order_location_check },#{"'" + self.escape_characters(priority) + "'"},#{"'" + self.escape_characters(order_status) + "'"},#{sample_status_check },'not_resolved')"
                            order_counter = order_counter + 1
                        else
                            txt.puts "\r" + ",(#{"'" + self.escape_characters(tracking_number) + "'"},#{sending_facility},#{sending_facility_check},#{receiving_lab},#{receiving_facility_check },#{"'" + self.escape_characters(sample_type) + "'"},#{sample_type_checker},#{"'" + self.escape_characters(who_order_fname) + "'" rescue empty},#{"'" + self.escape_characters(who_order_lname) + "'" rescue empty},#{"'" + self.escape_characters(who_order_id) + "'" rescue empty},#{"'" + self.escape_characters(who_order_phone) + "'" rescue 0},#{art_start_date},#{"'" + self.escape_characters(order['date_dispatched']) + "'" rescue empty},#{"'" + self.escape_characters(date_drawn) + "'"},#{"'" + self.escape_characters(date_received) + "'"},#{"'" + self.escape_characters(date_drawn) + "'"},#{"'" + self.escape_characters(district) + "'"},#{"'" + self.escape_characters(order_location) + "'"},#{ order_location_check },#{"'" + self.escape_characters(priority) + "'"},#{"'" + self.escape_characters(order_status) + "'"},#{ sample_status_check},'not-resolved')"
                        end
                    end
                end

                #patient details
                p_npid = order['patient']['national_patient_id']
                p_fname = order['patient']['first_name']
                p_lname = order['patient']['last_name']
                p_mname = order['patient']['middle_name']
                p_dob = order['patient']['date_of_birth']
                p_phone = order['patient']['phone_number']
                p_gender = order['patient']['gender']
                

                #loading tests and the results
                order['results'].each do |result|
                    #test details
                    test_type = result[0]
                    test_type_id = 0
                    test_type_checker = false
                    measure_id = 0
                    measure_checker = false
                    
                    test_counter = test_counter + 1
                    test_status_id = 0
                    test_status_checker = "resolved"
                                       

                    res = TestType.check_test_type(test_type)

                    if res == true
                        test_type_id = TestType.get_test_type_id(test_type)
                        test_type_checker = true
                    end

                        test_result = result[1]
                        length = test_result.length
                        test_result = test_result[test_result.keys[length - 1]]
                        test_status = test_result['test_status']
                        remarks = escape_characters(test_result['remarks'])
                        datetime_completed = test_result['datetime_completed']
                        datetime_started = test_result['datetime_started']
                        results = test_result['results'] rescue [ ]

                       
                        if !datetime_started.blank? && datetime_completed.blank?
                            datetime_completed = datetime_started
                        end

                        if datetime_completed.blank? && datetime_started.blank?
                            datetime_completed = date_time
                        end

                     
                            begin
                                datetime_completed.to_date rescue date_time
                            rescue ArgumentError
                                datetime_completed = date_time
                            end

                        res = TestStatus.check_test_status(test_status)

                        if res == true
                            test_status_id = TestStatus.get_test_status_id(test_status)                        
                        else
                            test_status_checker = "not-resolved"
                        end
                            puts tracking_number + "-------"        
                        if !results.blank?   
                            if results.length > 0 

                                results.each do |rst,value|
                                    measure = rst
                                    measure_value = escape_characters(value)
                                    res = Measure.check_measure(measure)
                                    measure_checker = false
                                    if res == true
                                        measure_name = measure
                                        measure_id = Measure.get_measure_id(measure_name)
                                        measure_checker = true
                                    end
                                
                                    if sample_data_checker == false ||  test_type_checker == false
                                        if measure_checker == true
                                            empty = "'" + "'"
                                                File.open("#{Rails.root}/public/slave_test_results.sql","a") do |txt| 
                                                
                                                    if measure_counter == 0
                                                        txt.puts "\r" + "(#{"'" + self.escape_characters(tracking_number) + "'"},#{ "'" + test_type  + "'"  },#{"'" + measure_name  + "'" },#{"'" + measure_name + "'"},#{"'" + measure_value + "'" rescue empty},#{"'" + 'resolved' + "'" rescue empty})"
                                                        measure_counter = measure_counter + 1
                                                    else
                                                        txt.puts "\r" + ",(#{"'" + self.escape_characters(tracking_number) + "'"},#{ "'" + test_type  + "'"  },#{"'" + measure_name  + "'" },#{"'" + measure_name + "'"},#{"'" + measure_value + "'" rescue empty},#{"'" + 'resolved' + "'" rescue empty})"
                                                    end
                                                end
                                        else
                                            empty = "'" + "'"
                                            File.open("#{Rails.root}/public/slave_test_results.sql","a") do |txt| 
                                            
                                                if measure_counter == 0
                                                    txt.puts "\r" + "(#{"'" + self.escape_characters(tracking_number) + "'"},#{ "'" + test_type  + "'"  },#{"'" + measure  + "'" },#{"'" + 'not-resolved' + "'"},#{"'" + measure_value + "'" rescue empty},#{"'" + 'not-resolved' + "'" rescue empty})"
                                                    measure_counter = measure_counter + 1
                                                else
                                                    txt.puts "\r" + ",(#{"'" + self.escape_characters(tracking_number) + "'"},#{ "'" + test_type  + "'"  },#{"'" + measure  + "'" },#{"'" + 'not-resolved' + "'"},#{"'" + measure_value + "'" rescue empty},#{"'" + 'not-resolved' + "'" rescue empty})"
                                                end
                                            end
                                        end





                                    elsif  sample_data_checker == true &&  test_type_checker == true
                                        if measure_checker == true
                                            empty = "'" + "'"
                                            File.open("#{Rails.root}/public/master_test_results.sql","a") do |txt| 
                                            test_results_counter = test_results_counter + 1
                                                if  measure_counter1 == 0
                                                    txt.puts "\r" + "(#{test_results_counter},#{test_counter},#{ measure_id },#{"'" + self.escape_characters(measure_value) + "'" },#{"'" + '1' + "'"},#{"'" + datetime_completed + "'" rescue empty rescue empty},#{"'" + datetime_completed + "'" rescue empty rescue empty},#{"'" + datetime_completed + "'" rescue empty rescue empty})"
                                                    measure_counter1 =  measure_counter1 + 1
                                                else
                                                    txt.puts "\r" + ",(#{test_results_counter},#{test_counter},#{ measure_id },#{"'" + self.escape_characters(measure_value) + "'" },#{"'" + '1' + "'"},#{"'" + datetime_completed + "'" rescue empty rescue empty},#{"'" + datetime_completed + "'" rescue empty rescue empty},#{"'" + datetime_completed + "'" rescue empty rescue empty})"
                                                end
                                            end

                                            File.open("#{Rails.root}/public/slave_test_results.sql","a") do |txt| 
                                                
                                                if measure_counter == 0
                                                    txt.puts "\r" + "(#{"'" + self.escape_characters(tracking_number) + "'"},#{ "'" + test_type  + "'"  },#{"'" + measure_name  + "'" },#{"'" + measure_name + "'"},#{"'" + measure_value + "'" rescue empty},#{"'" + 'resolved' + "'" rescue empty})"
                                                    measure_counter = measure_counter + 1
                                                else
                                                    txt.puts "\r" + ",(#{"'" + self.escape_characters(tracking_number) + "'"},#{ "'" + test_type  + "'"  },#{"'" + measure_name  + "'" },#{"'" + measure_name + "'"},#{"'" + measure_value + "'" rescue empty},#{"'" + 'resolved' + "'" rescue empty})"
                                                end
                                            end

                                        else
                                            empty = "'" + "'"
                                            File.open("#{Rails.root}/public/slave_test_results.sql","a") do |txt| 
                                            
                                                if measure_counter == 0
                                                    txt.puts "\r" + "(#{"'" + self.escape_characters(tracking_number) + "'"},#{ "'" + test_type  + "'"  },#{"'" + measure  + "'" },#{"'" + 'not-resolved' + "'"},#{"'" + measure_value + "'" rescue empty},#{"'" + 'not-resolved' + "'" rescue empty})"
                                                    measure_counter = measure_counter + 1
                                                else
                                                    txt.puts "\r" + ",(#{"'" + self.escape_characters(tracking_number) + "'"},#{ "'" + test_type  + "'"  },#{"'" + measure  + "'" },#{"'" + 'not-resolved' + "'"},#{"'" + measure_value + "'" rescue empty},#{"'" + 'not-resolved' + "'" rescue empty})"
                                                end
                                            end
                                        end
                                    end

                                end                
                            else
                                measure_checker = true
                            end
                        else
                            measure_checker = true

                        end

                        if sample_data_checker == false || measure_checker == false
                            if test_type_checker == true && test_status_checker == "resolved"
                                empty = "'" + "'"
                                File.open("#{Rails.root}/public/slave_tests.sql","a") do |txt| 
                                    
                                    if test_Count == 0
                                        txt.puts "\r" + "(#{"'" + self.escape_characters(tracking_number) + "'"},#{ "'" + test_type + "'" },#{ "'" + test_type + "'" },#{ "'" + test_status + "'" },#{ "'" + test_status + "'" },#{"'" + remarks + "'"},#{"'" + datetime_completed + "'" rescue empty},#{"'" + datetime_completed + "'" rescue empty},#{"'" + 'resolved' + "'"} )"
                                        test_Count = test_Count + 1
                                    else
                                        txt.puts "\r" + ",(#{"'" + self.escape_characters(tracking_number) + "'"},#{ "'" + test_type + "'" },#{ "'" + test_type + "'" },#{ "'" + test_status + "'" },#{ "'" + test_status + "'" },#{"'" + remarks + "'"},#{"'" + datetime_completed + "'" rescue empty},#{"'" + datetime_completed + "'" rescue empty},#{"'" + 'resolved' + "'"} )"
                                    end
                                end

                            elsif test_type_checker == true && test_status_checker == "not-resolved"
                                empty = "'" + "'"
                                File.open("#{Rails.root}/public/slave_tests.sql","a") do |txt| 
                                    
                                    if test_Count == 0
                                        txt.puts "\r" + "(#{"'" + self.escape_characters(tracking_number) + "'"},#{ "'" + test_type + "'" },#{ "'" + test_type + "'" },#{ "'" + test_status + "'" },#{"'" + test_status_checker + "'"},#{"'" + remarks + "'"},#{"'" + datetime_completed + "'" rescue empty},#{"'" + datetime_completed + "'" rescue empty},#{"'" + 'not-resolved' + "'"} )"
                                        test_Count = test_Count + 1
                                    else
                                        txt.puts "\r" + ",(#{"'" + self.escape_characters(tracking_number) + "'"},#{ "'" + test_type + "'" },#{ "'" + test_type + "'" },#{ "'" + test_status + "'" },#{"'" + test_status_checker + "'"},#{"'" + remarks + "'"},#{"'" + datetime_completed + "'" rescue empty},#{"'" + datetime_completed + "'" rescue empty},#{"'" + 'not-resolved' + "'"} )"
                                    end
                                end

                            elsif test_type_checker == false && test_status_checker == "resolved"
                                File.open("#{Rails.root}/public/slave_tests.sql","a") do |txt| 
                                    
                                    if test_Count == 0
                                        txt.puts "\r" + "(#{"'" + self.escape_characters(tracking_number) + "'"},#{ "'" + test_type + "'" },#{"'" + 'not-resolved' + "'"},#{ "'" + test_status + "'" },#{ "'" + test_status + "'" },#{"'" + remarks + "'"},#{"'" + datetime_completed + "'" rescue empty},#{"'" + datetime_completed + "'" rescue empty},#{"'" + 'not-resolved' + "'"} )"
                                        test_Count = test_Count + 1
                                    else
                                        txt.puts "\r" + ",(#{"'" + self.escape_characters(tracking_number) + "'"},#{ "'" + test_type + "'" },#{"'" + 'not-resolved' + "'"},#{ "'" + test_status + "'" },#{ "'" + test_status + "'" },#{"'" + remarks + "'"},#{"'" + datetime_completed + "'" rescue empty},#{"'" + datetime_completed + "'" rescue empty},#{"'" + 'not-resolved' + "'"} )"
                                    end
                                end
                            end
                        else
                            if test_type_checker == true && test_status_checker == "resolved"
                                empty = "'" + "'"
                                File.open("#{Rails.root}/public/master_tests.sql","a") do |txt| 
                                
                                    if  master_test_Count == 0
                                        txt.puts "\r" + "(#{test_counter},#{"'" + self.escape_characters(tracking_number) + "'"},#{ test_type_id },#{test_status_id},#{"'" + datetime_completed + "'" rescue empty},#{"'" + '10' + "'"},#{"'" + datetime_completed + "'" rescue empty},#{"'" + datetime_completed + "'" rescue empty})"
                                        master_test_Count =  master_test_Count + 1
                                    else
                                        txt.puts "\r" + ",(#{test_counter},#{"'" + self.escape_characters(tracking_number) + "'"},#{ test_type_id },#{test_status_id},#{"'" + datetime_completed + "'" rescue empty},#{"'" + '10' + "'"},#{"'" + datetime_completed + "'" rescue empty},#{"'" + datetime_completed + "'" rescue empty})"
                                    end
                                end

                                File.open("#{Rails.root}/public/slave_tests.sql","a") do |txt| 
                                    
                                    if test_Count == 0
                                        txt.puts "\r" + "(#{"'" + self.escape_characters(tracking_number) + "'"},#{ "'" + test_type + "'" },#{ "'" + test_type + "'" },#{ "'" + test_status + "'" },#{ "'" + test_status + "'" },#{"'" + remarks + "'"},#{"'" + datetime_completed + "'" rescue empty},#{"'" + datetime_completed + "'" rescue empty},#{"'" + 'resolved' + "'"} )"
                                        test_Count = test_Count + 1
                                    else
                                        txt.puts "\r" + ",(#{"'" + self.escape_characters(tracking_number) + "'"},#{ "'" + test_type + "'" },#{ "'" + test_type + "'" },#{ "'" + test_status + "'" },#{ "'" + test_status + "'" },#{"'" + remarks + "'"},#{"'" + datetime_completed + "'" rescue empty},#{"'" + datetime_completed + "'" rescue empty},#{"'" + 'resolved' + "'"} )"
                                    end
                                end

                            elsif test_type_checker == true && test_status_checker == "not-resolved"
                                empty = "'" + "'"
                                File.open("#{Rails.root}/public/slave_tests.sql","a") do |txt| 
                                    
                                    if test_Count == 0
                                        txt.puts "\r" + "(#{"'" + self.escape_characters(tracking_number) + "'"},#{ "'" + test_type + "'" },#{ "'" + test_type + "'" },#{ "'" + test_status + "'" },#{"'" + test_status_checker + "'"},#{"'" + remarks + "'"},#{"'" + datetime_completed + "'" rescue empty},#{"'" + datetime_completed + "'" rescue empty},#{"'" + 'not-resolved' + "'"} )"
                                        test_Count = test_Count + 1
                                    else
                                        txt.puts "\r" + ",(#{"'" + self.escape_characters(tracking_number) + "'"},#{ "'" + test_type + "'" },#{ "'" + test_type + "'" },#{ "'" + test_status + "'" },#{"'" + test_status_checker + "'"},#{"'" + remarks + "'"},#{"'" + datetime_completed + "'" rescue empty},#{"'" + datetime_completed + "'" rescue empty},#{"'" + 'not-resolved' + "'"} )"
                                    end
                                end

                            elsif test_type_checker == false && test_status_checker == "resolved"
                                File.open("#{Rails.root}/public/slave_tests.sql","a") do |txt| 
                                    
                                    if test_Count == 0
                                        txt.puts "\r" + "(#{"'" + self.escape_characters(tracking_number) + "'"},#{ "'" + test_type + "'" },#{"'" + 'not-resolved' + "'"},#{ "'" + test_status + "'" },#{ "'" + test_status + "'" },#{"'" + remarks + "'"},#{"'" + datetime_completed + "'" rescue empty},#{"'" + datetime_completed + "'" rescue empty},#{"'" + 'not-resolved' + "'"} )"
                                        test_Count = test_Count + 1
                                    else
                                        txt.puts "\r" + ",(#{"'" + self.escape_characters(tracking_number) + "'"},#{ "'" + test_type + "'" },#{"'" + 'not-resolved' + "'"},#{ "'" + test_status + "'" },#{ "'" + test_status + "'" },#{"'" + remarks + "'"},#{"'" + datetime_completed + "'" rescue empty},#{"'" + datetime_completed + "'" rescue empty},#{"'" + 'not-resolved' + "'"} )"
                                    end
                                end
                            end
                        end
                        
                end
            end
            if sample_data_checker == true
                empty = "'" + "'"
                specimen_type_id = SpecimenType.get_specimen_type_id(sample_type)
                specimen_status_id = SpecimenStatus.get_specimen_status_id(order_status)
                ward_id = Ward.get_ward_id(order_location)
                drawer_name = "#{"'" + self.escape_characters(who_order_lname) + "'" rescue empty + "_" + "'" + self.escape_characters(who_order_lname) + "'" rescue empty}"
                dispatcher_name =  "#{"'" + self.escape_characters(dispatcher_fname) + "'" rescue empty + "_" + "'" + self.escape_characters(dispatcher_lname) + "'" rescue empty}"

                    File.open("#{Rails.root}/public/master_orders.sql","a") do |txt|                     
                        if (master_order_counter == 0)
                            txt.puts "\r" + "(#{specimen_type_id},#{1},#{specimen_status_id},#{ward_id},#{"'" + self.escape_characters(tracking_number) + "'"},#{"'" + self.escape_characters(date_drawn) + "'"},#{"'" + self.escape_characters(priority) + "'"},#{"'" + self.escape_characters(who_order_id) + "'" rescue empty},#{drawer_name},#{"'" + self.escape_characters(who_order_phone) + "'" rescue 0},#{receiving_lab},#{art_start_date},#{sending_facility},#{"'" + 'user' + "'"},#{"'" + self.escape_characters(date_drawn) + "'"},#{"'" + district + "'" rescue empty},#{dispatcher_id},#{dispatcher_name},#{dispatcher_phone},#{date_dispatched},#{"'" + self.escape_characters(date_drawn) + "'"},#{"'" + self.escape_characters(date_drawn) + "'"})"
                            master_order_counter = master_order_counter + 1
                        else
                            txt.puts "\r" + ",(#{specimen_type_id},#{1},#{specimen_status_id},#{ward_id},#{"'" + self.escape_characters(tracking_number) + "'"},#{"'" + self.escape_characters(date_drawn) + "'"},#{"'" + self.escape_characters(priority) + "'"},#{"'" + self.escape_characters(who_order_id) + "'" rescue empty},#{drawer_name},#{"'" + self.escape_characters(who_order_phone) + "'" rescue 0},#{receiving_lab},#{art_start_date},#{sending_facility},#{"'" + 'user' + "'"},#{"'" + self.escape_characters(date_drawn) + "'"},#{"'" + district + "'" rescue empty},#{dispatcher_id},#{dispatcher_name},#{dispatcher_phone},#{date_dispatched},#{"'" + self.escape_characters(date_drawn) + "'"},#{"'" + self.escape_characters(date_drawn) + "'"})"
                        end
                    end
            end
            

            #if sample_checker == true
                #insert order details into file
            #    empty = "'" + "'"
            #    File.open("#{Rails.root}/public/orders.sql","a") do |txt| 
                
            #        if (order_counter==0)
            #        txt.puts "\r" + "(#{"'" + self.escape_characters(tracking_number) + "'"},#{sending_facility},#{receiving_lab},#{"'" + self.escape_characters(sample_type) + "'"},#{"'" + self.escape_characters(who_order_fname) + "'" rescue empty},#{"'" + self.escape_characters(who_order_lname) + "'" rescue empty},#{"'" + self.escape_characters(who_order_id) + "'" rescue empty},#{"'" + self.escape_characters(who_order_phone) + "'" rescue 0},#{"'" + self.escape_characters(order['art_start_date']) + "'" rescue empty},#{"'" + self.escape_characters(order['date_dispatched']) + "'" rescue empty},#{"'" + self.escape_characters(date_drawn) + "'"},#{"'" + self.escape_characters(date_received) + "'"},#{"'" + self.escape_characters(date_drawn) + "'"},#{"'" + self.escape_characters(district) + "'"},#{"'" + self.escape_characters(order_location) + "'"},#{"'" + self.escape_characters(priority) + "'"},#{"'" + self.escape_characters(order_status) + "'"})"
            #        order_counter = order_counter + 1
            #        else
            #        txt.puts "\r" + ",(#{"'" + self.escape_characters(tracking_number) + "'"},#{sending_facility},#{receiving_lab},#{"'" + self.escape_characters(sample_type) + "'"},#{"'" + self.escape_characters(who_order_fname) + "'" rescue empty},#{"'" + self.escape_characters(who_order_lname) + "'" rescue empty},#{"'" + self.escape_characters(who_order_id) + "'" rescue empty},#{"'" + self.escape_characters(who_order_phone) + "'" rescue 0},#{"'" + self.escape_characters(order['art_start_date']) + "'" rescue empty},#{"'" + self.escape_characters(order['date_dispatched']) + "'" rescue empty},#{"'" + self.escape_characters(date_drawn) + "'"},#{"'" + self.escape_characters(date_received) + "'"},#{"'" + self.escape_characters(date_drawn) + "'"},#{"'" + self.escape_characters(district) + "'"},#{"'" + self.escape_characters(order_location) + "'"},#{"'" + self.escape_characters(priority) + "'"},#{"'" + self.escape_characters(order_status) + "'"})"
            #        end
            #    end
            #end
        
            appendSemicolon()
          
            
        end  
    
    end



    def self.generate_quater(quater)

        quaters = { 
			"q1" => ["0101","0331"],
			"q2" => ["0401","0630"],
			"q3" => ["0701","0930"],
			"q4" => ["1001","1231"]
		}
        return quaters[quater]
    end


    def self.check_test_type(type)
        res = TestType.find_by_sql("SELECT test_types.id AS test_type_id FROM test_types").first
        if res 
            return res.test_type_id
        else
            return false
        end
    end


end



















