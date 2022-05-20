/**************************************************************************/  
  //The Birthday Emailer  
  //  
  //This class can be scheduled to run nightly to send emails to Contacts   
  //or Person Accounts on their birthday  
 //   
  //Emails will only be sent to contacts that meet the following conditions:  
  // *the Birthday or Anniversary field is filled out  
  // *the Email Opt Out is unchecked  
  // *the "send birthday email" checkbox is checked  
  // *the Email is not blank  
  //  
  //Feel free to edit this code, or change the email templates.  
  //  
  /***************************************************************************/  
   
// public class BirthdayEmail {
   
 global class BirthdayEmail implements Schedulable{    
     
     //mandatory function called by the Apex Scheduler  
     global void execute(SchedulableContext SC) {  
       sendmail(); // our main function that does the email sending  
     }//end execute()  
   
    //Get email addresses of people with birthdays and who are to receive emails  
     public List<Id> getBirthdayEmailAddresses(Integer Month, Integer Day)   
     {   
         List<Id> mailToIds = new List<Id>();  
           
        //find a list of contacts with birthdays today  
        Contact[] c = [SELECT Id, email, Birthdate  
                FROM Contact   
                WHERE email <> '' AND   
                DAY_IN_MONTH(Birthdate) = : Day   
                AND CALENDAR_MONTH(Birthdate) = : Month    
                ];  
        
        //add the list of contacts to a list      
        for(Contact recipient : c) {  
              
            //If( contacts who's birthday is today can receive emails AND has the "Send Birthday Email" checked)  
            //{ add to birthday email recipient list }  
            //   
              
            System.Debug('\n*******Found Birthday Recipient');  
                        
           // if (recipient.Send_Birthday_Email__c == true && recipient.HasOptedOutOfEmail == false)  
           // {  
              mailToIds.add(recipient.Id);  // add to email contact array  
              System.Debug('\n*******Recipient: '+ recipient.email);  
              //and add to Chatter Array  
                 
          //  } else {  
              //Just add to chatter array  
              System.Debug('\n*******NO Recipient');  
            // }  
            
        }  
    
        //return the list  
        return mailToIds;  
      }//end getBirthdayEmailAddresses()  
   
     public void sendMail()   
      {  
        //define variables       
        String debugAddress = 'eyewell@salesforce.com';  
        String BirthdayEmailTemplateName = 'Happy_Birthday';  
        String AnniversaryEmailTemplateName = 'Celebrating_your_Anniversary';        
        String debugMessage;  
        String[] toAddresses;  
    
        Integer DayOfEvent  = date.today().day();  
        Integer MonthOfEvent = date.today().month();  
    
    
        // build the Birthday list  
    
        //get the list of people with birthdays - this can justifiably come back empty, on a day when no contacts were born   
        List<Id> BirthdayIdsList = getBirthdayEmailAddresses(MonthOfEvent,DayOfEvent);  
    
        //Set the templates  
        EmailTemplate birthdayTemplate = [select Id,Name,Subject,body from EmailTemplate where DeveloperName = :BirthdayEmailTemplateName];  
        
       //EmailTemplate anniversaryTemplate = [select Id,Name,Subject,body from EmailTemplate where name like :temp+'%'];  
        //If we have a template, and we have a list of email addresses, then send the email  
        if(birthdayTemplate != null && BirthdayIdsList.isEmpty() == false)  
        {  
    
          Messaging.MassEmailMessage birthdayMail = new Messaging.MassEmailMessage();  
      
          birthdayMail.setTargetObjectIds(BirthdayIdsList);  
          birthdayMail.setTemplateId(birthdayTemplate.Id);  
          birthdayMail.setUseSignature(false);  
          birthdayMail.setSaveAsActivity(true);  
    
          // Send the email  
          try {  
            Messaging.sendEmail(new Messaging.MassEmailMessage[] { birthdayMail });  
          }catch(Exception e)  
          {  
            System.Debug(e);  
          }  
          
        }  
        else  
        {  
          System.Debug('BirthdayEmail:sendMail(): Either an email template could not be found, or no Contact has a birthday today');  
        }//end if  
            
      }//end sendMail()   
      
  }//end class BirthdayEmail