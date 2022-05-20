trigger CONTENTDOCUMENTDELETE on ContentDocument (after insert,after update, after delete) {
    system.debug('ContentDocument trigger');
    set<id> cdocid = new set<id>(); // Contentdocument ids 
   
    set<id> clinkparids = new set<id>(); // linkedentity id from contentdocumentlink (parentid)
    if(trigger.isafter && (trigger.isinsert || trigger.isupdate)){
        for(contentDocument cd : trigger.new){
            cdocid.add(cd.id);
        }
    }
    if(trigger.isafter &&trigger.isdelete){
        for(ContentDocument cd : trigger.old){
           cdocid.add(cd.id); 
        }
    }
    list<ContentDocumentLink> clinks = [select Id, LinkedEntityId, ContentDocumentId from ContentDocumentLink where ContentDocumentId IN :cdocid];
    for(ContentDocumentLink cl : clinks){
        clinkparids.add(cl.LinkedEntityId);
    }
    
    list<case> caselist = [select id,(select Id, LinkedEntityId, ContentDocumentId from ContentDocumentLinks) from case where id IN :clinkparids];
    for(case c:caselist){
        integer exsiz = c.ContentDocumentLinks.size();// existing count
        integer cdocsiz = cdocid.size();// deleted record id count
        integer coutsiz = exsiz - cdocsiz;
         c.AttachmentCount__c = coutsiz;
        system.debug('coutsiz='+ coutsiz);
    }
    update caselist;
}