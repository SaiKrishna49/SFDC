public class csvImportExport {
   /* for import data into sobject and insert data from csv file  */ 
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
            
           /* Attachment attachment = new Attachment();
            attachment.Body = Blob.valueOf(wrapper.Text);
            attachment.Name = 'csvFileforJASONResponse.csv';
            attachment.ParentId = '0015g00000bTVthAAG';
            insert attachment;
            system.debug('Attachment'+attachment);*/
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
        public String Text;
        
        
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
    
}



/*
 * 
 * trigger AddNote on Lead (after insert) {
    List<ContentNote> nte = new List<ContentNote>();
    List<ContentDocumentLink> lnk = new List<ContentDocumentLink>();
    for(Lead lds : Trigger.new){
        ContentNote cnt = new ContentNote();
        cnt.Content = Blob.valueof(lds.Sales_Notes__c);
        cnt.Title = 'Creation Note';
        nte.add(cnt);
    }
    
    if(nte.size()>0){
        insert nte;
    }
    for(Lead lds : Trigger.new){
        ContentDocumentLink clnk = new ContentDocumentLink();
        clnk.LinkedEntityId = lds.Id;
        clnk.ContentDocumentId = nte[0].Id;
        clnk.ShareType = 'I';
        lnk.add(clnk);
    }
    
    if(nte.size()>0){
        insert lnk;
    }
}
*/