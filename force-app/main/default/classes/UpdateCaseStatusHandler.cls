public class UpdateCaseStatusHandler {
    public static void updateCase(List<Case> csListNew) {        
        Set<Id> csIds = new Set<Id>();
        for(Case cs: csListNew) {
            csIds.add(cs.ParentId);
        }
        List<Case> csList = new List<Case>([Select Id, Status, ParentId From Case Where ParentId In :csIds]);
        if(csIds.size()>0) {
            List<Case> csParentList = new List<Case>([Select Id, Status From Case Where Id In :csIds]);
            List<Case> csUpdateList = new List<Case>();
            for(Case cs: csParentList) {
                integer flag = 0;
                for(Case c: csList) {
                    if(c.ParentId != null) {
                        if(c.ParentId == cs.Id) {
                            if(c.Status == 'Closed') {
                                flag = 1;
                            }                            
                            if(c.Status == 'Escalated') {
                                flag = 2;
                            }
                             if(c.Status == 'Working') {
                                flag = 3;
                            }
                             if(c.Status == 'New') {
                                flag = 4;
                            }
                        }
                    } else {
                        flag = 0;
                    }
                }
                if(flag == 1) {
                    cs.Status = 'Closed';
                    csUpdateList.add(cs);
                } else if(flag == 2) {
                    cs.Status = 'Escalated';
                    csUpdateList.add(cs);
                }  else if(flag == 3){
                    cs.status = 'Working';
                    csUpdateList.add(cs);
                        }   else if(flag == 4){
                            cs.Status = 'New';
                            csUpdateList.add(cs);
                        }           
            }
            if(csUpdateList.size()>0) {
                update csUpdateList;
            }
        }        
    }
}