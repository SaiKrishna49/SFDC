trigger ContentDocumentLinkUpdate on ContentDocumentLink (after insert, after update, after delete) {
    
    List<ContentDocumentLink> cdls = ( Trigger.new == null ? Trigger.old : Trigger.new );
    
    set<id> parentIds = new set<id>();
    if(trigger.isafter &&trigger.isdelete){
        for(ContentDocumentLink cd : trigger.old){
            parentIds.add(cd.LinkedEntityId); 
        }
    }
    
    for ( ContentDocumentLink cdl : cdls ) {
        parentIds.add( cdl.LinkedEntityId );
    }
    list<case> caselist = [select id,(select Id, LinkedEntityId, ContentDocumentId from ContentDocumentLinks) 
                           from case where id IN :parentIds];
    for(case c:caselist){
        system.debug('Case for loop');
        integer exsitsize = c.ContentDocumentLinks.size();// existing count
        system.debug('c.ContentDocumentLinks.size()'+ c.ContentDocumentLinks.size());
        integer ContentDocumentsize = parentIds.size();// deleted record id count
       integer count= database.countQuery('select count() from ContentDocumentLinks where lastmodifieddate = THIS_WEEK and isdeleted = true all rows');
            system.debug('deleted:' + count);
         
           // c.Deleted_Attachment_Count__c = ContentDocumentsize;
        
        system.debug('ContentDocumentsize'+parentIds.size() );
        integer coutsize = exsitsize - ContentDocumentsize;
        system.debug('coutsize'+ coutsize);
        c.AttachmentCount__c = exsitsize;
        system.debug('AttachmentCount__c'+ c.AttachmentCount__c);
    }
    
    update caselist;
    
}
    




















    /*for ( List<Case> cases : [ SELECT Id, ( SELECT Id FROM ContentDocumentLinks ) FROM Case WHERE Id IN :parentIds] ) {
        
        for ( Case c : cases ) {
            c.In_Progress__c = ( c.ContentDocumentLinks.size() > 0 );
            c.AttachmentCount__c = c.ContentDocumentLinks.size() ; 
        }
        
        update cases;
        
    }
=============
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /* 
  Map<Id,List<ContentDocumentLink>> parent = new Map<Id,List<ContentDocumentLink>>();
  set<id> attids = new set<id>();
     
   if(Trigger.new<>null){
       for(ContentDocumentLink c:Trigger.new){
           case l;
           if(c.LinkedEntityId != null)
               attids.add(c.LinkedEntityId);
       }
           
   }else if(Trigger.old != null){
       for(ContentDocumentLink c:Trigger.old){
           if(c.LinkedEntityId<>null)      
               attids.add(Trigger.oldMap.get(c.id).LinkedEntityId);
       }
   }
   if(attids.size()>0){
       try{
           List<ContentDocumentLink> a = new List<ContentDocumentLink>();
           Map<id,Case> testmap = new Map<id,case>([select id,AttachmentCount__c from case where id IN: attids]);
           a = [select id,LinkedEntityId from ContentDocumentLink where LinkedEntityId IN:attids];
           
           for(ContentDocumentLink at: a){
               List<ContentDocumentLink> llist = new List<ContentDocumentLink>();
               if(parent.get(at.LinkedEntityId) == null){
                   llist = new List<ContentDocumentLink>();
                   llist.add(at);
                   parent.put(at.LinkedEntityId,llist);
               }else if(parent.get(at.LinkedEntityId) != null){
                   llist = new List<ContentDocumentLink>();
                   llist = parent.get(at.LinkedEntityId);
                   llist.add(at);
                   parent.put(at.LinkedEntityId,llist);
               }
           }
           
           for(Id i: attids){
               if(testmap.get(i) != null && parent.get(i) != null){
                  testmap.get(i).AttachmentCount__c = parent.get(i).size(); 
               
               }else if(testmap.get(i) != null && parent.get(i) == null){
                  testmap.get(i).AttachmentCount__c = 0; 
               }
           }
       
           update testmap.values();
           System.Debug(testmap.values());
       }catch(Exception e){}
    }

}   
    
    */