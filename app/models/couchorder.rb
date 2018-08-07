class Couchorder < CouchRest::Model::Base
    property :_id, String
    design do

        view :by__id
   
        view :generic,
            :map => "function(doc) {
                       if (doc['_id'].match(/^X/)) {
                         emit([doc['date_time']]);
                       }
                   }"
    end

end
