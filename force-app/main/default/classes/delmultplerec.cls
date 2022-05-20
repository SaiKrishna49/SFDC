public class delmultplerec {
  public id asgn{get;set;}
  public case csel = new case();
  public delmultplerec(apexpages.standardsetcontroller setcse){}
  Public pagereference delmultplerec() {
      system.debug('hidden val is..!!' +asgn);
        try{
            system.debug('delete rec is..!!' +csel);
            delete [select id from case where id =: asgn];          
            return NULL;
        }catch(exception e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            return NULL;
     }
  }
}