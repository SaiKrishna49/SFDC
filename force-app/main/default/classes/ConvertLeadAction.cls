global class ConvertLeadAction {
  @InvocableMethod(label='Convert Leads')
  global static void convertLeads(List<ConvertLeadActionRequest> requests) {
   
   system.debug('I am from Process builder apex class'); 
  }

 

  global class ConvertLeadActionRequest {
    @InvocableVariable(required=true)
    global ID leadId;

    @InvocableVariable(required=true)
    global String convertedStatus;

    @InvocableVariable
    global ID accountId;

    @InvocableVariable
    global ID contactId;

    @InvocableVariable
    global Boolean overWriteLeadSource;

    @InvocableVariable
    global Boolean createOpportunity;

    @InvocableVariable
    global String opportunityName;

    @InvocableVariable
    global ID ownerId;

    @InvocableVariable
    global Boolean sendEmailToOwner;
  }



  class ConvertLeadActionException extends Exception {}
}