public with sharing class LocationVerifier {
    public static void locationVerifier(String locId){
        Location_Address_Book__c loc = [Select Id,Zip_Code_Verified__c,State__c,Street__c,Postal_Code__c,City__c from Location_Address_Book__c where Id = :locId];
        
        //Basic HTTP Block
        //EncodingUtil.urlEncode convert space into ASCI
        Http httpst = new Http();
        HttpRequest reqst = new HttpRequest();
        String addst = 'https://us-street.api.smartystreets.com/street-address?auth-id=b5f1f399-ca32-c6fb-7b9d-7b1a8c8bab6b&auth-token=fKxFM43bq7BSAr2U9cgd&'
        +'street=' + EncodingUtil.urlEncode(loc.Street__c, 'UTF-8') 
        +'&city='+ EncodingUtil.urlEncode(loc.City__c, 'UTF-8')
        +'&state='+EncodingUtil.urlEncode(loc.State__c, 'UTF-8');
        reqst.setEndPoint(addst);
        reqst.setMethod('GET');
        HttpResponse respst= new HttpResponse();
        respst = httpst.send(reqst); 
        System.debug('respst.getStatusCode()==>'+respst.getStatusCode());
        
        try {
            if(respst.getStatusCode() == 200){                                                      //check if the req is successful(code = 200)
            
                String respstBody = respst.getBody();                                               //for checking the length of response body
                Integer zipCode;                                                                    //variable for zipcode
                
                List<Object> resultsList = (List<Object>)JSON.deserializeUntyped(respstBody);       //casting responseBody(JSON) in a list of object
                System.debug('resultsList==>'+resultsList);
                for(Object obj : resultsList){                                                      //iterate all the object in list(resultsZipList)
                    Map<String, Object> results = (Map<String, Object>) obj;                        //casting the object into map
                    System.debug('results==>'+results);
                    Map<String, Object> result = (Map<String, Object>)results.get('components');    //casting the object that has a id of components
                    System.debug('result==>'+result);
                    zipCode = integer.valueof(result.get('zipcode'));                               //getting the object that has id of zipcode
                    System.debug('zipCode==>' + zipCode);
                    System.debug('loc.PostalCode==>'+loc.Postal_Code__c);
                }
                if(respstBody.length()>2 && zipCode==integer.valueof(loc.Postal_Code__c)){          //if the resp has value and zipCode = loc.Postal_Code__c
                    loc.Verified__c = true;                                                         //then the address is is verified
                    loc.Zip_Code_Verified__c = true;
                }else{
                    loc.Verified__c = false;
                    loc.Zip_Code_Verified__c = false;
                }
                update loc;                                                                         //Updating the checkbox fields
            }
        } 
        catch (Exception ex) {
            System.debug('Exception -- ' + ex.getMessage());
        }
    }
}
