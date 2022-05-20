public class Controller {

    @AuraEnabled
    public static void processData(String fileData,String sobjectName,List<String> fields) {

       System.debug('fileData:::'+filedata);
       System.debug('sobjectName:::'+sobjectName);
       System.debug('fields:::'+fields);
       
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(sobjectName);
        try{
            if(fileData!=null){ 
                String[] fileLines = new String[]{};
               fileLines = fileData.split('\n');
                //for content
                List<sObject> myList = new List<sObject>();
                for (Integer i=1,j=fileLines.size();i<j;i++){
                  String[] inputvalues = new String[]{};
                  inputvalues = fileLines[i].split(',');
                  sObject obj = targetType.newSObject();
                   integer rowsize=inputvalues.size();
                   //System.debug('rowsize::'+rowsize);
                   //System.debug('fields size'+fields.size());
                   for(integer l=0;l<rowsize-1;l++){
                       system.debug('fields.get(l)'+fields.get(l)); 
                       if(String.isNotBlank(inputvalues[l]) )
                       {
                          String value= inputvalues[l].length()>255 ? inputvalues[l].substring(0,254) : inputvalues[l];
                            obj.put(fields.get(l),value);
                       }else{
                            obj.put(fields.get(l),'');
                       }
                   
                      
                   }
             //   System.debug('Obj::::'+obj);
                   myList.add(obj);

               }
                insert myList;
            }
              
        }catch(Exception e){
             System.debug('exception'+e);   
        }
       
    }
}