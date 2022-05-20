public class CaseSelectClassController {
    public List<wrapcase> wrapCaseList {get; set;}
    public List<Case> DeleteList{get;set;}
    public caseselectclasscontroller(){
        if(wrapCaseList == null) {
            wrapCaseList = new List<wrapcase>();
            for(case c: [select Id,OwnerId, AccountId,CaseNumber, Reason, ClosedDate,Status,Origin from case limit 10]) {
                // As each case is processed we create a new wrapcase object and add it to the wrapcaseList
                wrapcaseList.add(new wrapcase(c));
            }
    }
    }
    public void processSelected() {
    DeleteList = new List<case>();
 
        for(wrapcase wrapcaseObj : wrapcaseList) {
            if(wrapcaseObj.selected == true) {
                DeleteList.add(wrapcaseObj.cse);
            }
        }
    }
 
    // This is our wrapper/container class. In this example a wrapper class contains both the standard salesforce object Account and a Boolean value
    public class wrapcase {
        public case cse {get; set;}
        public Boolean selected {get; set;}
 
        public wrapcase(case c) {
            cse = c;
            selected = false;
        }
    }
 

}