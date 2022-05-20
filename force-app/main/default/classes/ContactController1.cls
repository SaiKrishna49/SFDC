public with sharing class ContactController1 {  
            @AuraEnabled  
            public static string saveContact(Contact contactRec, string file, string fileName) {  
              string contactId;  
              try{  
                Insert contactRec;  
                contactId = contactRec.Id;  
                String base64File = EncodingUtil.urlDecode(file, 'UTF-8');     
                ContentVersion contentVersionRec = new ContentVersion();  
                contentVersionRec.Title = fileName;  
                contentVersionRec.PathOnClient = '/' + fileName;  
                contentVersionRec.FirstPublishLocationId = contactRec.Id;  
                contentVersionRec.VersionData = EncodingUtil.base64Decode(base64File);  
                contentVersionRec.IsMajorVersion = true;  
                Insert contentVersionRec;  
              } catch(Exception ex){  
                system.debug('Exception===>'+ex.getMessage());  
              }  
              return contactId;  
            }    
          }