@isTest
private class LocationAndZipVerifier_Test {
    public static testMethod void testZip(){

        Location_Address_Book__c loc = new Location_Address_Book__c(
            Name = '3301 South Greenfield Rd',
            Street__c = '3301 South Greenfield Rd',
            City__c = 'Gilbert',
            State__c = 'AZ',
            Postal_Code__c = '85297',
            Country__c = 'United States of America'
        );
        insert loc;

        try{
            Test.setMock(HttpCalloutMock.class, new ZipMock());
            Test.startTest();

            LocationAndZipVerifier.zipVerifier(loc.Id);
            
            Test.stopTest();
        }catch(Exception ex){
            System.debug('Exception -- ' + ex.getMessage());
        }

    }
    public static testMethod void testLoc(){
        Location_Address_Book__c loc = new Location_Address_Book__c(
            Name = '3301 South Greenfield Rd',
            Street__c = '3301 South Greenfield Rd',
            City__c = 'Gilbert',
            State__c = 'AZ',
            Postal_Code__c = '85297',
            Country__c = 'United States of America'
        );
        insert loc;

        try{
            Test.setMock(HttpCalloutMock.class, new LocationMock());
            Test.startTest();

            LocationVerifier.locationVerifier(loc.Id);
            
            Test.stopTest();
        }catch(Exception ex){
            System.debug('Exception -- ' + ex.getMessage());
        }
        Location_Address_Book__c retrievedVerified = [Select Zip_Code_Verified__c, Verified__c from Location_Address_Book__c where Id =: loc.Id];
        System.assertEquals(true,retrievedVerified.Verified__c);
        System.assertEquals(true,retrievedVerified.Zip_Code_Verified__c);
    }
}
