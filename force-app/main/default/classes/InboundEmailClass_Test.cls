@istest
public class InboundEmailClass_Test {
    @istest
    public static void testmethod1(){
        Contact Con = new Contact();
        con.LastName = 'test';
        con.Email = 'testaddress@email.com';
        Insert con;
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        email.subject = 'Create Contact';
        email.fromAddress = 'testaddress@email.com';
        email.plainTextBody = 'email body';
        InboundEmailClass  testInbound =new InboundEmailClass ();
        testInbound.handleInboundEmail(email, env);
    }
}

/*  Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
    //  email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
     */