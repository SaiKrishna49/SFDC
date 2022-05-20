public class LeadConTriggerHandler 
{
	public static void createCon(list<lead> leads)
    {
        list<contact> conlist = new list<contact>();
        for(lead l: leads)
        {
            contact con = new contact();
            con.LastName = l.LastName;
            con.FirstName = l.FirstName;
            con.Phone = l.Phone;
            con.Email = l.Email;
            con.Description = 'Contact is created from lead with lead ID ='+ l.Id;
            conlist.add(con);
        }
        insert conlist;
    }
}