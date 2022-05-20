/**************************************************************************************************
*** Class Name             : InboundEmailClass
*** Class Description      : This class will be invoked when an inbound call is given from specified email address, 
							 to make the field  HasOptedOutOfEmail to true.								
*** Author                 : Krishna
*** Class Created Date     : 11-JAN-2022
**************************************************************************************************/
public class InboundEmailClass implements messaging.InboundEmailHandler {
    public messaging.InboundEmailResult handleInboundEmail(messaging.InboundEmail email,messaging.InboundEnvelope env)
    {
        messaging.InboundEmailResult result=new messaging.InboundEmailResult();
        list<contact> updateConList = new list<contact>();
        try{
            string frmaddess=email.fromAddress;
            for(contact conRec : [SELECT Id, Name, Email, HasOptedOutOfEmail FROM Contact WHERE Email = :frmaddess AND hasOptedOutOfEmail = false]){
                conRec.HasOptedOutOfEmail = true;
                updateConList.add(conRec);  
            }
            UPDATE updateConList;
            system.debug('updateConList='+updateConList);
            result.success=true;
        }catch(exception e){
            result.success=false;
            SYSTEM.debug('exception='+ e);
        }
        SYSTEM.debug('result='+result);
        return result;   
    }
}