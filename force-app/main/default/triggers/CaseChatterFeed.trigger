trigger CaseChatterFeed on ContentDocumentLink (after insert) {
//trigger AttachFileToCaseFeed on Attachment (before insert) {  
    ID caseId;  
    list<FeedItem> listOfFeedFiles = new List<FeedItem>();  
    
    if(Trigger.isBefore){
    
        for(ContentDocumentLink attachment : trigger.new){
           string checkIfCase = string.valueof(attachment.LinkedEntityId);
         
           if(checkIfCase.startsWith('500')){ 
                //Adding a Content post
                //caseId = attachment.ParentId;
                FeedItem post = new FeedItem();
                post.ParentId = caseId; //eg. Opportunity id, custom object id..
                post.Body = 'Attachment added';
                post.Type = 'ContentPost';
                //post.ContentData = attachment.body; 
                //post.ContentFileName = attachment.Name;
                //post.Title = ContentDocumentLink.title;
                listOfFeedFiles.add(post);          
           }
        }
    }
    
    if(listOfFeedFiles!=null){
        insert listOfFeedFiles; 
    }   
}