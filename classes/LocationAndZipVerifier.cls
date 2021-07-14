public with sharing class LocationAndZipVerifier {
    @future (callout=true)

    //This will be called in Dev Console
    public static void zipVerifier(String locId) {
        Location_Address_Book__c loc = [Select Id,Zip_Code_Verified__c,State__c,Street__c,Postal_Code__c,City__c from Location_Address_Book__c where Id = :locId];

        //Basic HTTP Block
        Http httpzip = new Http();
        HttpRequest reqzip = new HttpRequest();
        String addzip = 'https://us-zipcode.api.smartystreets.com/lookup?auth-id=b5f1f399-ca32-c6fb-7b9d-7b1a8c8bab6b&auth-token=fKxFM43bq7BSAr2U9cgd&city=&state=&zipcode='+loc.Postal_Code__c;
        reqzip.setEndPoint(addzip);
        reqzip.setMethod('GET');
        HttpResponse respzip= new HttpResponse();
        respzip = httpzip.send(reqzip);


        try {
            if(respzip.getStatusCode() == 200){                                                         //check if the req is successful(code = 200)
                List<Object> resultsZipList = (List<Object>)JSON.deserializeUntyped(respzip.getBody()); //cast Response(JSON) into list of object
                for(Object obj : resultsZipList){                                                       //iterate all the object in list(resultsZipList)
                    Map<String, Object> results = (Map<String, Object>) obj;                            //cast the obj into MAP for easy data manipulation
                    System.debug('results==>'+results);
                    List<Object> zipObject = (List<Object>) results.get('zipcodes');                    //get the Id(zipcodes)
                    System.debug('zipObject==>'+zipObject);
                    if(zipObject!=null){                                                                //if the zipcode Obj != null then
                        LocationVerifier.locationVerifier(locId);                                      
                    }else{                                                                              //print the zipcode in debug
                        System.debug('ZipCode = ' + zipObject);
                        loc.Zip_Code_Verified__c = false;
                        update loc;
                    }
                }
            }
        } 
        
        catch (Exception ex) {
            System.debug('Exception -- ' + ex.getMessage());
        }
    }
}