trigger DemoAcc on Account (before insert) 
{
    for(account acc : trigger.new)
    {
        system.debug('  trigger.new=='+   trigger.new);
        system.debug('  acc.Name=before Mr.='+   acc.Name);
        acc.Name = 'Mr.'+ acc.Name;
        system.debug('  acc.Name=After Mr.='+   acc.Name);
       // Insert acc;
        system.debug('  acc.Name=After Insert acc='+   acc.Name);
    }
    
}