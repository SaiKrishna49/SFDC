public class LeadEmail {
    Public static void sendEmail(list<lead> leads){
        list<messaging.SingleEmailMessage> mails = new list<messaging.SingleEmailMessage>();
        For(lead l: leads){
            messaging.SingleEmailMessage msg = new messaging.SingleEmailMessage();
            string[] toadd = new string[]{l.Email};
                msg.setToAddresses(toadd);
            msg.setSubject('Lead acknowledgment');
            //msg.setHtmlBody('lead is created with lastname '+ l.LastName +'phone number is '+ l.Phone'+....');
            string body = 'Dear customer <br/>';
            body = body+'We have created lead with lastname:'+l.LastName;
            body = body+ 'first name:'+l.FirstName;
            msg.setHtmlBody(body);
            mails.add(msg);
            
        }
        messaging.sendEmail(mails);
    }
    
}