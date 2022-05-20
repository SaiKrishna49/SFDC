({
/*    convertArrayOfObjectsToCSV : function(component,objectRecords,fieldList){
        var csvStringResult, counter, columnDivider, lineDivider;
        var keys=[];
        if (objectRecords == null || !objectRecords.length) {
            return null;
        }
        
        columnDivider = ',';
        lineDivider = '\n';
        for(var i=0;i<fieldList.length;i++){
            keys.push(fieldList[i]);
        }
        JSON.stringify(keys);
        
        csvStringResult = '';
        csvStringResult += keys.join(columnDivider);
        csvStringResult += lineDivider;
        
        for(var i=0; i < objectRecords.length; i++){
            counter = 0;
            
            for(var sTempkey in keys) {
                
                var skey = keys[sTempkey] ;
                if(counter > 0){
                    csvStringResult += columnDivider;
                }
                
                csvStringResult += objectRecords[i][skey];
                counter++;
                
            }
            csvStringResult += lineDivider;
            
        }
        return csvStringResult;
    },*/
})