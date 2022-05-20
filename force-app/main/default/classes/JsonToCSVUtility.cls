/**
* JsonToCSVUtility Class
* This class has helper functiones to convert json string to csv
* @author - Manish Choudhari

source code url: https://gist.github.com/choudharymanish8585/41f77ec2eee6967513b570e210c3e59c

* */
public class JsonToCSVUtility {
    
    public static Integer MAX_ROW = 0;
    
    /**
* Recursive function to process json kev value pair to create Map<String, List<Object>>
* @param jsonObject - JSON object to process
* @param columnRowMAp - This will be final outcome after process key value pairs of a map
* @param prefix - Prefix will be used to append key in front of inner object values
* @param typeColumn - This will be used to create verticle type columns
* @author - Manish Choudhari
* */
    public static Map<String, List<Object>> processJsonObject(Object jsonObject, Map<String, List<Object>> columnRowMap, String prefix, Set<String> typeColumns){
        if(jsonObject != null){
            //Json processing starts from here
            if(isMap(jsonObject)){
                //Get object map from json
                Map<String, Object> jsonObjectMap = (Map<String, Object>) jsonObject;
                //Iterate over each object
                for(String k : jsonObjectMap.keySet()){
                    Object obj = jsonObjectMap.get(k);
                    //Check if this key has an a Map as value
                    if(isMap(obj)){
                        //Process the object by calling the funtion recusively
                        processJsonObject(obj, columnRowMap, (prefix+k+'__'), typeColumns);
                    }
                    // Check if this key has a List as value
                    else if(isList(obj)){
                        //Add a type column record
                        addNewValue(columnRowMap, prefix+'type', prefix+k, typeColumns);
                        //Add new type column in set
                        typeColumns.add(prefix+'type');
                        processJsonObject(obj, columnRowMap, (prefix), typeColumns);
                        //Remove the type column from set
                        typeColumns.remove(prefix+'type');
                    }
                    //Normal key value pair
                    else{
                        //Push value inside the columnRowMap
                        addNewValue(columnRowMap, prefix+k, obj, typeColumns);
                    }
                }
            } else if(isList(jsonObject)){
                //Get object list from json
                List<Object> jsonObjectList = (List<Object>) jsonObject;
                //Iterate over each object
                for (Object obj : jsonObjectList) {
                    //Check if this key has an a Map or List as value
                    if(isMap(obj) || isList(obj)){
                        //Process the object by calling the funtion recusively
                        processJsonObject(obj, columnRowMap, (prefix), typeColumns);
                    }
                    //Normal key value pair
                    else{
                        //Push value inside the columnRowMap
                        addNewValue(columnRowMap, prefix, obj, typeColumns);
                    }
                }
            }
        }
        return columnRowMap;
    }
    
    /**
* This function accepts a json string and returns csv string
* @author - Manish Choudhari
* */
    public static String getCSVString(String jsonString){
        //Get JSON object from json string
        system.debug('jsonString  getCSVString=='+ jsonString);
        Object jsonObject = JSON.deserializeUntyped(jsonString);
        //Output map for column and rows
        Map<String, List<Object>> columnRowMap = new Map<String, List<Object>>();
        //Get column row map
        //Map<String, List<Object>> columnRowMap = getColumnAndRows(jsonString);
        columnRowMap = processJsonObject(jsonObject, columnRowMap, '', new Set<String>());
        
        //String for csv body
        String csvBody = '';
        //String for column header
        String columns = '';
        //List of string for each row
        List<String> rows = new List<String>();
        //filling with blank rows
        for(Integer i=0; i<MAX_ROW; i++){
            rows.add('');
        }
        //Iterating over column row map
        for(String column : columnRowMap.keySet()){
            //Adding column header
            columns += column+',';
            //Getting records from a column
            List<Object> objectList = columnRowMap.get(column); //Get record in the column
            //Iterating over records from a columns
            for(Integer i=0; i<MAX_ROW; i++){
                //Get row value from rows list, if does not exist, it will throw an exception
                String row = rows.get(i);
                try{
                    Object obj = objectList.get(i);
                    //Getting record String value from the object. 
                    String record = obj != null ? (obj.toString()+',') : 'null,';
                    //Append the value in the row
                    row += record;
                    //Replace the existing row value with new one
                    rows.set(i, row);
                } catch(System.ListException e){
                    //Exception ocurred, means no record exist, add a comma for blank value
                    row += ',';
                    rows.set(i, row);
                } 
            }
        }
        csvBody = columns.removeEnd(',') + '\n'; //Add column header in csv body
        //Adding csv rows
        for(String row : rows){
            csvBody += row.removeEnd(',') + '\n';
        }
        system.debug('csvBody=='+csvBody);
 Attachment attachment = new Attachment();
                attachment.Body = Blob.valueOf(csvBody) ;//Blob.valueOf(res.getBody());
                attachment.Name = 'ZenDeskApiClass.csv';
                attachment.ParentId = '0015g00000bU9JcAAK';
                insert attachment;
                system.debug('Attachment'+attachment);
        return csvBody;
    }
    
    /**
* Check if an object is a MAP<String, Object>
* @author Manish Choudhari
* */
    public static Boolean isMap(Object obj){
        return (obj instanceof Map<String, Object>);
    }
    
    /**
* Check if an object is a List<Object>
* @author Manish Choudhari
* */
    public static Boolean isList(Object obj){
        return (obj instanceof List<Object>);
    }
    
    /**
* Add new value inside columnRowMap
* @author - Manish Choudhari
* */
    public static void addNewValue(Map<String, List<Object>> columnRowMap, String key, Object obj, Set<String> typeColumns){
        //Push value inside the columnRowMap
        if(columnRowMap.keySet().contains(key)){
            columnRowMap.get(key).add(obj);
            //Find maximum number of rows within a column
            if(columnRowMap.get(key).size() > MAX_ROW){
                MAX_ROW = columnRowMap.get(key).size();
                for(String typeColumn : typeColumns){
                    //Add null record in place of type column
                    columnRowMap.get(typeColumn).add('');
                }
            }
        } else{
            columnRowMap.put(key, new List<Object>{obj});
        }
    }
    
}