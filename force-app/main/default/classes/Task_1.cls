public class Task_1 
{
    Public static void callme(list<contact> con)
    {
        Set<id> ConIdSet = new set<id>();
        if(trigger.isInsert)
        {
            for(Contact c : con)
        {
            ConIdSet.add(c.id);
        }
        }
        
    }
}


/*
 * 
 * trigger SendEmail on Sent_Feedback__c (after insert) {
   
        set<id> ContactId = new set<id>();
 
  // Step 0: Create a master list to hold the emails we'll send
  List<Messaging.SingleEmailMessage> mails =
  new List<Messaging.SingleEmailMessage>();
 
  for (Sent_Feedback__c myContact : Trigger.new) {
    
    if (myContact.Contact__c != null )
    {
          ContactId.add(myContact.Contact__c);
    }
         Contact con = [Select firstname,lastname,email,id,name,MobilePhone from Contact where id in :ContactId];
      // Step 1: Create a new Email
      Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
   
      // Step 2: Set list of people who should get the email
      List<String> sendTo = new List<String>();
      sendTo.add(con.email);
      mail.setToAddresses(sendTo);
   
      // Step 3: Set who the email is sent from
      mail.setReplyTo('utkarsha.up10@gmail.com');
      mail.setSenderDisplayName('Utz patil');
   
      // (Optional) Set list of people who should be CC'ed
      List<String> ccTo = new List<String>();
      ccTo.add('puja.patil@aress.com');
      mail.setCcAddresses(ccTo);
 
      // Step 4. Set email contents - you can use variables!
      mail.setSubject('URGENT BUSINESS PROPOSAL');
      String body = 'Dear ' + con.FirstName;
     
      mail.setHtmlBody(body);
   
      // Step 5. Add your email to the master list
      mails.add(mail);
        Messaging.sendEmail(mails);
    }
  }
  // Step 6: Send all emails in the master list
  // 
  */