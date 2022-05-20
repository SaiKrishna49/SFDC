({
    convertArrayOfObjectsToCSV : function(component,objectRecords,fieldList){
        var csvStringResult, counter, columnDivider, lineDivider;
        var keys=[];
        if (objectRecords == null || !objectRecords.length) {
            return null;
        }
        
        columnDivider = ',';
        lineDivider = '\n';
        if(!fieldList.includes("Id")){
            keys.push("Id");
        }

        for(var i=0;i<fieldList.length;i++){
            keys.push(fieldList[i]);
        }
        JSON.stringify(keys);
        
        csvStringResult = '';
        csvStringResult += keys.join(columnDivider);
        alert('keys.join(columnDivider)='+keys.join(columnDivider));
        
        csvStringResult += lineDivider;
        alert('csvStringResult='+csvStringResult);
                for(var i=0; i < objectRecords.length; i++){
            counter = 0;
            
            for(var sTempkey in keys) {
                
                var skey = keys[sTempkey] ;
                alert('keys[sTempkey]='+keys[sTempkey]);
                if(counter > 0){
                    csvStringResult += columnDivider;
                }
                
                csvStringResult += objectRecords[i][skey];
                counter++;
                
            }
                    alert('csv string result=='+csvStringResult);
            csvStringResult += lineDivider;
            
        }
        console.log('csvStringResult==' + csvStringResult);
        return csvStringResult;
    },
})