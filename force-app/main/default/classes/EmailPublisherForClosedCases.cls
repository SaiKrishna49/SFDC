global class EmailPublisherForClosedCases implements QuickAction.QuickActionDefaultsHandler {
    global void onInitDefaults(QuickAction.QuickActionDefaults[] defaults) {
        QuickAction.SendEmailQuickActionDefaults sendEmailDefaults = (QuickAction.SendEmailQuickActionDefaults)defaults.get(0);
        EmailMessage emailMessage = (EmailMessage)sendEmailDefaults.getTargetSObject(); 
        Case c = [SELECT Id,CaseNumber,Status FROM Case WHERE Id=:sendEmailDefaults.getContextId()];
        if (c.Status != null && c.Status.equals('Closed')) { 
            emailMessage.ToAddress = 'test@gmail.com';
        }        
    } 
}