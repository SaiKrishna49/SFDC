Public class TrainingStatus{
    public static void UpdateStatus(list<Traning__c> newStatusList){
        for(Traning__c VarStatus : newStatusList){
            if(VarStatus.Age__c > 30 & VarStatus.Experience__c > 8){
                VarStatus.Status__c = 'selected' ; 
                } else{ 
                    VarStatus.Status__c = 'rejected';
               }
             }
         }
    }