trigger childCase on Case (after insert) {
   list<case> caselist = new list<case>();
    
    for(case cse : trigger.new){
        case c = new case();
       c.ParentId = cse.Id;
       c.Origin = 'web';
       c.Status = 'working';
       c.Description='created automatically  from childcase trigger with id=cse.Id';
        caselist.add(c);
        
    }
    Insert caselist;
}