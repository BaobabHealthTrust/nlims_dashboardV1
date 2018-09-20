Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#login"


  get "/report/moh_report" => "report#moh_report"
  get "report/retrieve_data_moh_report" => "report#retrieve_data_moh_report"
  get "/report/retrieve_landing_page_data" => "report#retrieve_landing_page_data"
  get "/report/retrieve_total_orders"    => "report#retrieve_total_orders"
  get "/report/retrieve_completed_tests" => "report#retrieve_completed_tests"
  get "/report/retrieve_pending_tests"   => "report#retrieve_pending_tests"
  get "/report/retrieve_rejected_tests"  => "report#retrieve_rejected_tests"
  get "/report/retrieve_site_sync_updats" => "report#retrieve_site_sync_updats"
  get "/report/retrieve_lab_departments_tests" => "report#retrieve_lab_departments_tests"


  get "/setting/settings"       => "setting#settings"
  get "/setting/migrate_data"   => "setting#migrate_data"
  get "/setting/migrate"        => "setting#migrate"
  get "/testcatelog/specimen_types" => "testcatelog#specimen_types"
  get "/testcatelog/test_types"     => "testcatelog#test_types"
  get "/load_specimen_test_types"   => "testcatelog#specimen_test_types"
  get "/home"                       => "home#home"
  post "/authenticate"              => "home#authenticate"
  get  "/authenticate"              => "home#authenticate"
  get  "/unresolved_specimen"       => "testcatelog#unresolved_specimen"
  get  "/unresolved_test_types"     => "testcatelog#unresolved_test_types"
  get  "/unresolved_measures"       => "testcatelog#unresolved_measures"
  get  "/resolve_specimen_types"    => "testcatelog#resolve_specimen"
  post "/add_resolved"              => "testcatelog#add_resolved"
  get  "/add_resolved"              => "testcatelog#add_resolved"
  post "/merge_resolved"            => "testcatelog#merge_resolved"
  get  "/resolve_test_types"        => "testcatelog#resolve_test_types"
  get  "/test_Categories"           => "testcatelog#test_Categories"
  post "/home/add_account"       => "home#add_account"
  get  "/home/get_location"      => "home#get_location"



end
