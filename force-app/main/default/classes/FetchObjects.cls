public with sharing class FetchObjects 
{
    public list<Selectoption> lstOptions {get;set;}
    public String selectedObject{get;set;}
    public Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    public List<Selectoption> lstfieldname{get;set;}
    public List<Sobject> lstObject{get;set;}
    public List<String> lstSelectedFields{get;set;}
    public FetchObjects()
    {
        try
        {
            lstOptions = new List<Selectoption>();
            lstfieldname=new List<Selectoption>();
            lstObject=new List<Sobject>();
            lstOptions.add(new Selectoption('','--None--'));
            for(Schema.Sobjecttype objSobject: schemaMap.values())
            {           
                if(objSobject.getDescribe().isQueryable())          
                    lstOptions.add(new Selectoption(objSobject.getDescribe().getname(),objSobject.getDescribe().getLabel()));
            }
            lstOptions.sort();
        }
        catch(Exception e)
        {
            
        }
    }

    public void getFields()
    {
        try
        {
            lstfieldname.clear();
            Map<String,schema.Sobjectfield> mapFields=schemaMap.get(selectedObject).getDescribe().fields.getMap();     
            for(schema.Sobjectfield objSobjectFeild:mapFields.values())
                lstfieldname.add(new Selectoption(objSobjectFeild.getDescribe().getname(),objSobjectFeild.getDescribe().getLabel ()));
            
            lstfieldname.sort();
        }
        catch(Exception e)
        {
            
        }
    }
    
    public void getRecords()
    {
        try
        {
            lstObject.clear();
            String strQuery = 'Select Id ' ;            
            for(String field : lstSelectedFields)  
            {  
                //if(field.toLowerCase() != 'id' && field.toLowerCase() != '--None--')  
                strQuery += ','+ field + ' ' ;  
            }           
            strQuery += ' from ' + selectedObject+' LIMIT 10' ;    
            lstObject = Database.query(strQuery) ;
            if(lstObject.isEmpty())
                Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'There is No Records!!'));
        } 
        catch(Exception e)
        {
            list<Period> lstPeriods=new List<Period>();
            lstPeriods=[Select p.Type,p.StartDate,p.Id,p.EndDate From Period p];
            system.debug('******'+lstPeriods);
            //system.debug('&&&&&&&'+Opportunity.SObjectType.getDescribe().isMergeable());
        }
    }
}