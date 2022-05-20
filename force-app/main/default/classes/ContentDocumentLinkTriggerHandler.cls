public class ContentDocumentLinkTriggerHandler {
    public void handleInsert(List<ContentDocumentLink> records) {
        
        String caseKeyPrefix = '500';
        Map<Id, case> cases = new Map<Id, case>();

        for (ContentDocumentLink record : records) {
            if (String.valueOf(record.LinkedEntityId).startsWith(caseKeyPrefix)) {
                cases.put(
                    record.LinkedEntityId,
                    new case(Id=record.LinkedEntityId, HasAttachments__c=true)
                );
            }
        }

        update cases.values();
    }

    public void handleDelete(List<ContentDocumentLink> records) {
        
        String caseKeyPrefix = '500';
        Set<Id> casesIds = new Set<Id>();

        for (ContentDocumentLink record : records) {
            if (String.valueOf(record.LinkedEntityId).startsWith(caseKeyPrefix)) {
                casesIds.add(record.LinkedEntityId);
            }
        }

        List<AggregateResult> attachmentPercase = [
            SELECT COUNT(Id), LinkedEntityId
            FROM ContentDocumentLink
            WHERE LinkedEntityId IN: casesIds
            GROUP BY LinkedEntityId
        ];

        Set<Id> casesWithAttachments = new Set<Id>();

        for (AggregateResult ar : attachmentPercase) {
            casesWithAttachments.add(Id.valueOf(String.valueOf(ar.get('expr0'))));
        }

        Map<Id, case> cases = new Map<Id, case>();

        for (ContentDocumentLink record : records) {
            if (!casesWithAttachments.contains(record.LinkedEntityId)) {
                cases.put(
                    record.LinkedEntityId,
                    new case(Id=record.LinkedEntityId, HasAttachments__c=false)
                );
            }
        }

        update cases.values();
    }
}