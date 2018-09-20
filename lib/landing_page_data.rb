module LandingPageData

    $option = ""
    $verified = 5
    $completed = 4
    $pending = 2
    $rejected  = 8
    $current_month = 0
    $previous_month = 0
    $started = 3
    $drawn = 9

    def self.setter(option)
        $option = option
    end

    def self.get_verified_tests
        $previous_month = '2016-06'
        $current_month =  '2016-07'
        res = Test.find_by_sql("SELECT count(*) AS total_verified FROM tests 
                                INNER JOIN orders ON orders.id = tests.order_id
                                WHERE orders.health_facility='#{$option}'
                                AND (tests.test_status_id ='#{$verified}' AND substr(tests.time_created,1,7)='#{$current_month}')
        ")

        if !res.blank?
            current_verified  = res[0]['total_verified']
        end


        res = Test.find_by_sql("SELECT count(*) AS total_verified FROM tests 
                INNER JOIN orders ON orders.id = tests.order_id
                WHERE orders.health_facility='#{$option}'
                AND (tests.test_status_id ='#{$verified}' AND substr(tests.time_created,1,7)='#{$previous_month}')
        ")

        if !res.blank?
            previous_verified  = res[0]['total_verified']
        end
       
        return [current_verified,previous_verified,$current_month,$previous_month]
    end


    def self.get_completed_tests
        $previous_month = '2016-06'
        $current_month =  '2016-07'
        res = Test.find_by_sql("SELECT count(*) AS total_verified FROM tests 
                                INNER JOIN orders ON orders.id = tests.order_id
                                WHERE orders.health_facility='#{$option}'
                                AND (tests.test_status_id ='#{$completed}' AND substr(tests.time_created,1,7)='#{$current_month}')
        ")

        if !res.blank?
            current_verified  = res[0]['total_verified']
        end


        res = Test.find_by_sql("SELECT count(*) AS total_verified FROM tests 
                INNER JOIN orders ON orders.id = tests.order_id
                WHERE orders.health_facility='#{$option}'
                AND (tests.test_status_id ='#{$completed}' AND substr(tests.time_created,1,7)='#{$previous_month}')
        ")

        if !res.blank?
            previous_verified  = res[0]['total_verified']
        end
       
        return [current_verified,previous_verified,$current_month,$previous_month]
    end

    def self.retrieve_total_orders
        $previous_month = '2016-06'
        $current_month =  '2016-07'
        res = Test.find_by_sql("SELECT count(*) AS total_verified FROM tests 
                                INNER JOIN orders ON orders.id = tests.order_id
                                WHERE orders.health_facility='#{$option}'
                                AND substr(tests.time_created,1,7)='#{$current_month}'
        ")

        if !res.blank?
            current_verified  = res[0]['total_verified']
        end


        res = Test.find_by_sql("SELECT count(*) AS total_verified FROM tests 
                INNER JOIN orders ON orders.id = tests.order_id
                WHERE orders.health_facility='#{$option}'
                AND substr(tests.time_created,1,7)='#{$previous_month}'
        ")

        if !res.blank?
            previous_verified  = res[0]['total_verified']
        end
       
        return [current_verified,previous_verified,$current_month,$previous_month]
    end


    def self.retrieve_pending_tests
        $previous_month = '2016-06'
        $current_month =  '2016-07'
        res = Test.find_by_sql("SELECT count(*) AS total_verified FROM tests 
                                INNER JOIN orders ON orders.id = tests.order_id
                                WHERE orders.health_facility='#{$option}'
                                AND (tests.test_status_id ='#{$pending}' AND substr(tests.time_created,1,7)='#{$current_month}')
        ")

        if !res.blank?
            current_verified  = res[0]['total_verified']
        end

        res = Test.find_by_sql("SELECT count(*) AS total_verified FROM tests 
                INNER JOIN orders ON orders.id = tests.order_id
                WHERE orders.health_facility='#{$option}'
                AND (tests.test_status_id ='#{$drawn}' AND substr(tests.time_created,1,7)='#{$current_month}')
        ")

        if !res.blank?
        current_verified  = current_verified +  res[0]['total_verified'].to_i
        end


        res = Test.find_by_sql("SELECT count(*) AS total_verified FROM tests 
                INNER JOIN orders ON orders.id = tests.order_id
                WHERE orders.health_facility='#{$option}'
                AND (tests.test_status_id ='#{$pending}' AND substr(tests.time_created,1,7)='#{$previous_month}')
        ")

        if !res.blank?
            previous_verified  = res[0]['total_verified']
        end


        res = Test.find_by_sql("SELECT count(*) AS total_verified FROM tests 
                INNER JOIN orders ON orders.id = tests.order_id
                WHERE orders.health_facility='#{$option}'
                AND (tests.test_status_id ='#{$drawn}'  AND substr(tests.time_created,1,7)='#{$previous_month}')
        ")

        if !res.blank?
            previous_verified  = previous_verified +  res[0]['total_verified'].to_i
        end


       
        return [current_verified,previous_verified,$current_month,$previous_month]
    end

    def self.retrieve_rejected_tests
        $previous_month = '2016-06'
        $current_month =  '2016-07'
        res = Test.find_by_sql("SELECT count(*) AS total_verified FROM tests 
                                INNER JOIN orders ON orders.id = tests.order_id
                                WHERE orders.health_facility='#{$option}'
                                AND (tests.test_status_id ='#{$started}' AND substr(tests.time_created,1,7)='#{$current_month}')
        ")

        if !res.blank?
            current_verified  = res[0]['total_verified']
        end


        res = Test.find_by_sql("SELECT count(*) AS total_verified FROM tests 
                INNER JOIN orders ON orders.id = tests.order_id
                WHERE orders.health_facility='#{$option}'
                AND (tests.test_status_id ='#{$started}' AND substr(tests.time_created,1,7)='#{$previous_month}')
        ")

        if !res.blank?
            previous_verified  = res[0]['total_verified']
        end
       
        return [current_verified,previous_verified,$current_month,$previous_month]
    end


    def self.get_period
        $current_month = Time.now
        $previous_month = Time.now - 1.month   
        
        $current_month = $current_month.to_s[0..6]
        $previous_month = $previous_month.to_s[0..6]
    end

    def self.get_site_code
        res = Site.where(:name => $option)[0]
        return res['id']
    end

    def self.retrieve_site_sync_updates
        site_code = LandingPageData.get_site_code
        res = SiteSyncFrequency.find_by_sql("SELECT count(*) AS down_time FROM site_sync_frequencies
                                            WHERE site='#{site_code}' AND (substr(site_sync_frequencies.created_at,1,7) = '#{$current_month}'
                                            AND status ='0')"
                                        )

        if !res.blank?
            down_time_count = res[0]['down_time']
        end


        res = SiteSyncFrequency.find_by_sql("SELECT count(*) AS up_time FROM site_sync_frequencies
                                            WHERE site='#{site_code}' AND (substr(site_sync_frequencies.created_at,1,7) = '#{$current_month}'
                                            AND status ='1')"
                                        )

        if !res.blank?
            up_time_count = res[0]['up_time']
        end
      
        total_current = down_time_count.to_i + up_time_count.to_i
        current_uptime =   "%.1f" %  ((up_time_count.to_f/total_current.to_f) * 100)
        current_downtime = "%.1f" % ((down_time_count.to_f/total_current.to_f) * 100)
        

        res = SiteSyncFrequency.find_by_sql("SELECT count(*) AS down_time FROM site_sync_frequencies
                                            WHERE site='#{site_code}' AND (substr(site_sync_frequencies.created_at,1,7) = '#{$previous_month}'
                                            AND status ='0')"
                                        )

        if !res.blank?
            down_time_count = res[0]['down_time']
        end


        res = SiteSyncFrequency.find_by_sql("SELECT count(*) AS up_time FROM site_sync_frequencies
                                            WHERE site='#{site_code}' AND (substr(site_sync_frequencies.created_at,1,7) = '#{$previous_month}'
                                            AND status ='1')"
                                        )

        if !res.blank?
            up_time_count = res[0]['up_time']
        end

        total_current = down_time_count.to_i + up_time_count.to_i
        previous_uptime = "%.1f" %  ((up_time_count.to_f/total_current.to_f) * 100)
        previous_downtime = "%.1f" % ((down_time_count.to_f/total_current.to_f) * 100)

        return [[current_uptime,current_downtime],[previous_uptime,previous_downtime],$current_month,$previous_month,LandingPageData.get_current_site_sync_status,LandingPageData.get_last_site_sync]
    end


    def self.get_current_site_sync_status
        res = Site.where(:name => $option)[0]
        return res['sync_status']
    end

    def self.get_last_site_sync
        site_code = LandingPageData.get_site_code
        res = SiteSyncFrequency.find_by_sql("SELECT * FROM site_sync_frequencies WHERE site='#{site_code}' AND status='1' ORDER BY created_at DESC LIMIT 1")
        if !res.blank?
            return res[0]['created_at']
        else
            return nil
        end
    end

    def self.retrieve_lab_departments_tests
        data = {}
        res = TestCategory.find_by_sql("SELECT * FROM test_categories")
        if !res.blank?
            res.each do |cat|
                id = cat['id']
                da = Test.find_by_sql("SELECT count(*) AS total_count FROM tests INNER JOIN test_types
                                ON test_types.id = tests.test_type_id 
                                WHERE test_types.test_category_id='#{id}'
                                AND 
                                substr(tests.created_at,1,7) = '#{$current_month}'
                ")
                curent_count = da[0]['total_count']

                da = Test.find_by_sql("SELECT count(*) AS total_count FROM tests INNER JOIN test_types
                                ON test_types.id = tests.test_type_id 
                                WHERE test_types.test_category_id='#{id}'
                                AND 
                                substr(tests.created_at,1,7) = '#{$current_month}'
                ")
                previous_count = da[0]['total_count']

                data[cat['name']] =  [curent_count,previous_count]
            end
            
            return data
        end
    end

end
