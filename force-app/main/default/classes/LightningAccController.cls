public class LightningAccController {
	@AuraEnabled
    public static list<Contact> RelatedList(Id recordId)
    {
        List<Contact> Conlist = [Select id, name,firstname,lastname from Contact where AccountId=: recordId ];
        return Conlist;
    }
}