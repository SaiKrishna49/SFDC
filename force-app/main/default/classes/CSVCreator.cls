public class CSVCreator  {
    
    private static List<String> separateCommas(String input){
        List<String> results = input.split(',');
        
        for(String result : results) {
            result = result.trim();
        }
        
        return results;
    }
    
    @AuraEnabled
    public static CSVObject getCSVObject(String csv_str) {
        List<String> lines_raw = csv_str.split('\n');
        List<String> headers_raw = separateCommas(lines_raw[0]);
        List<List<String>> lines = new List<List<String>>();
        List<CSVHeader> headers = new List<CSVHeader>();
        lines_raw.remove(0);
        
        //Handling fields with commas
        
        for(String line : lines_raw) {
            List<String> line_sep = separateCommas(line);
            List<String> fields = new List<String>();
            Boolean makeCompositeField = false;
            String compositeField;
            for(String field : line_sep) {
                if (field.startsWith('"') && field.endsWith('"')) {
                    fields.add(field.trim());
                } else if (field.startsWith('"')) {
                    makeCompositeField = true;
                    compositeField = field;
                } else if (field.endsWith('"')) {
                    compositeField += ',' + field;
                    fields.add(compositeField.trim());
                    makeCompositeField = false;
                } else if (makeCompositeField) {
                    compositeField +=  ',' + field;
                } else {
                    fields.add(field.trim());
                }
            }
            lines.add(fields);
        }
        
        for(String header : headers_raw) {
            headers.add(new CSVHeader(header));
        }
        
        return new CSVObject(headers, lines);
    }
    
    @AuraEnabled
    public static string insertData(String strfromle){
        String returnresponse ='';
        List<Account> AccoutnListtoInsert = new List<Account>();
        //system.debug('strfromle = ' + strfromle);
        List<fieldWrapper> datalist = (List<fieldWrapper>)JSON.deserialize(strfromle, List<fieldWrapper>.class);
        //system.debug('datalist = ' + datalist);
        //system.debug('datalistSize = ' + datalist.size());
        for(fieldWrapper wrapper: datalist){
            Account acc =new  Account();
            acc.Name = wrapper.Name;
            acc.Phone = wrapper.phone;
            acc.AccountNumber = wrapper.AccountNumber;
            AccoutnListtoInsert.add(acc);            
        }
        
        if(AccoutnListtoInsert.size() > 0){
            try {
                insert AccoutnListtoInsert;
                returnresponse = 'SUCCESS';
            }
            catch(Exception ex){
                returnresponse = 'ERROR';
            }
        }
        return returnresponse;
    }
    
    public class fieldWrapper{        
        public String Name;        
        public String AccountNumber;        
        public String phone;
        
    } 
    
    /* for export data into csv file  */
    @AuraEnabled
    public static list <Account> fetchContact(){      
        List <Account> returnConList = new List < Account > ();        
        for(Account Acc: [SELECT Name, phone, AccountNumber From Account ]) {
            returnConList.add(Acc);
        }
        return returnConList;
    }
    /*to dynamic */
    @AuraEnabled
    public static boolean ImportData(String csvData){
        system.debug('csvData-->'+csvData);
        try{
            List<Contact> listToSaveContact = (List<Contact>)JSON.deserialize(csvData, List<Contact>.class);
            system.debug('ac-->'+listToSaveContact);
            if(!listToSaveContact.IsEmpty()){
                insert listToSaveContact;
                return true;
            }else{
                return false;
            }
        }catch(exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
    
}