global class EmailAttachmentForFlow {
    //class to get multiple inputs from flow
    global class flowInput {                  
        @InvocableVariable(required=true)
        global String eMail;
        
        @InvocableVariable
        global String ccMail;
        
        @InvocableVariable(required=true)
        global String eSubject;
        
        @InvocableVariable
        global String ebody;
         
        @InvocableVariable
        global id currentRecordId;
        
        @InvocableVariable
        global boolean sendAttachment;
         
    }
    
    //invocable method
    @InvocableMethod(label='Email with Attachments' description='Used to send email alert along with attachments on the record.') 
    
    global static void currentRecordID(flowInput[] currentInput){      
        
        system.debug('List of Ids = '+currentInput);
        
            ID rId;
        
          for(flowInput singleID :currentInput ){
                
             //fetching record id
             rId = singleID.currentRecordId;                            
                
            system.debug('recordID= '+singleID + ' rID = '+rId);
                
            //Get the obbject of the record id
            sobject sO = rId.getSobjectType().newsobject(rId);
            
            system.debug('sO='+sO);
            
        }
        
        
          Set<id> contentDocumentSet    = new set<id>();  
        
          //Get all content document link where linkedEntityid=: rID. 
          for(ContentDocumentLink doc : [SELECT ContentDocumentId,ContentDocument.title,Id,LinkedEntityId,ShareType FROM ContentDocumentLink WHERE LinkedEntityId =:rID ] )  {
              contentDocumentSet.add(doc.ContentDocumentId);
        }
        
  //Get all related contentVersion file
          List<ContentVersion> contentVersionFile = [SELECT VersionData, title, FileType FROM ContentVersion WHERE ContentDocumentId IN :contentDocumentSet AND IsLatest = true];
         
        
            system.debug('Attachment List = '+ contentDocumentSet +'ConventVersion File = '+contentVersionFile);
        
        //New email message method
        Messaging.SingleEmailMessage mail= new Messaging.SingleEmailMessage();    
        
        //defining list of email attachments
        List<Messaging.EmailFileAttachment> attach= new list< Messaging.EmailFileAttachment>();
        
        
        //For each content version file get the file name, extension, version and add into the attachment list called 'attach'
        for(ContentVersion file : contentVersionFile){
             Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                efa.setFileName(file.title+'.'+file.FileType);
               efa.setBody(file.VersionData);
               attach.add(efa);
            }  
        
                
              
            //List of TO email id's 
              List<string> sendTo = new list<string>();
                      
                        for(String emailId : currentInput[0].eMail.split(',')){
                            if(emailId !=Null){
                                sendTo.add(emailId.trim());
                            }
                            
                        }    
                  
              system.debug('send TO = '+sendTo);  
                    mail.setToAddresses(sendTo);        
              
        //List of CC email id's:
        
        if(currentInput[0].ccMail!=Null  && currentInput[0].ccMail.trim() != ''){           
			 system.debug('ccMail '+currentInput[0].ccMail );
            List<string> ccSendTo = new list<string>();
            
                    for(String ccEmailId : currentInput[0].ccMail.split(',')){
                        if(ccEmailId!=Null){
                            ccSendTo.add(ccEmailId.trim());
                        }
                        
                    }
              
              mail.setCcAddresses(ccSendTo);
                    system.debug('cc : '+ccSendTo);    
        }
            
                 //Email Body
                     mail.setPlainTextBody(currentInput[0].eBody);
        
            //Email subject
              mail.setSubject(currentInput[0].eSubject);
        
            //Attachment
                   if(currentInput[0].sendAttachment ==True){
                            mail.setFileAttachments(attach);            
                    }
              
                    
            //Send Email
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }

}