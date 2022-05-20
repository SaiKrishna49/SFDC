global class SubmitforApprovalOnOpp {
// we need to add webservice keyword before method  we are calling from javascript
    webservice static void controllerMethod(String oppId)
    {
        
   /*     Map<Id,ContentDocumentLink> opportunityAttachments = new Map<Id,ContentDocumentLink>();
        list<ContentDocumentLink> conList=[SELECT ContentDocumentId,LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId =:oppId];
        for(ContentDocumentLink opp:conList)
        {
            opportunityAttachments.put(opp.LinkedEntityId,opp);
            
        }
        
       
        System.debug('opportunityAttachments'+ opportunityAttachments);
        system.debug('opportunityAttachments size=='+opportunityAttachments.size());
  // For each opportunity being created or modified...
  for(opportunity oppAtt : [Select Id,StageName, (Select ParentId FROM Attachments) FROM Opportunity WHERE Id = :oppId]){
      system.debug('!opportunityAttachments.containsKey(oppAtt.id)='+ !opportunityAttachments.containsKey(oppAtt.id));
    if(oppAtt.StageName=='Closed Won' && // If it is changing to closed/won...
      !opportunityAttachments.containsKey(oppAtt.id)) { // Or the attachment list has no entries...
          system.debug('add error');
      oppAtt.StageName.addError('You must first attach a file to this opportunity before changing to Closed/Won.'); // So we prevent saving here.
      }else {
          Approval.ProcessSubmitRequest approvalRequest = new Approval.ProcessSubmitRequest();
            approvalRequest.setComments('Offer Submitted for approval');
            approvalRequest.setObjectId(oppAtt.Id);
            Approval.ProcessResult approvalResult = Approval.process(approvalRequest);
            System.debug('offer submitted for approval successfully: '+approvalResult .isSuccess());
      }
     
  }
        
    }
}*/
        Map<Id,ContentDocumentLink> opportunityAttachments = new Map<Id,ContentDocumentLink>();
        list<ContentDocumentLink> attList=[SELECT ContentDocumentId,LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId  =:oppId];
        for(ContentDocumentLink opp:attList)
        {
            opportunityAttachments.put(opp.LinkedEntityId,opp);
           /*  if(!opportunityAttachments.containsKey(opp.id)){
              opp.StageName.addError('You must first attach a file to this opportunity before changing to Closed/Won.');
        }*/
       }
        
       
        System.debug('opportunityAttachments'+ opportunityAttachments);
        system.debug('SubmitforApprovalOnOpp');
       
        system.debug('oppId=='+oppId);
        for(opportunity oppAtt : [Select Id,StageName, (Select ParentId FROM Attachments) FROM Opportunity WHERE Id = :oppId]){
            system.debug('oppAtt=='+oppAtt);
            system.debug('oppAtt.Attachments.size()=='+oppAtt.Attachments.size());
            if(oppAtt.Attachments.size() > 0){
                system.debug('oppAtt.Attachments.size()=='+oppAtt.Attachments.size());
            Approval.ProcessSubmitRequest approvalRequest = new Approval.ProcessSubmitRequest();
            approvalRequest.setComments('Offer Submitted for approval');
            approvalRequest.setObjectId(oppAtt.Id);
            Approval.ProcessResult approvalResult = Approval.process(approvalRequest);
            System.debug('offer submitted for approval successfully: '+approvalResult .isSuccess());
     // return 'True';
        }else{
            //oppAtt.StageName.adderror('add attachments');
        }  
       
        }         
        //else {
            //oppAtt.adderror('add attachments');
           //  return 'False';
        }
          
    }
//}
//



/*
 * 
 * set<Id> oppId=new set<Id>();
        for(Opportunity opp:newRecordList)
        {
            oppId.add(opp.Id);
        }
        
        Map<Id,ContentDocumentLink> opportunityAttachments = new Map<Id,ContentDocumentLink>();
        list<ContentDocumentLink> conList=[SELECT ContentDocumentId,LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId IN :oppId];
        for(ContentDocumentLink opp:conList)
        {
            opportunityAttachments.put(opp.LinkedEntityId,opp);
            
        }
        
       
        System.debug('opportunityAttachments'+ opportunityAttachments);
  // For each opportunity being created or modified...
  for(Opportunity opp:newRecordList) {
    if(opp.StageName=='Closed Won' && // If it is changing to closed/won...
      !opportunityAttachments.containsKey(opp.id)) { // Or the attachment list has no entries...
      opp.StageName.addError('You must first attach a file to this opportunity before changing to Closed/Won.'); // So we prevent saving here.
    }
  }
    }
*/