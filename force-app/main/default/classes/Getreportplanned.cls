public class Getreportplanned{
@AuraEnabled
public static string Getreportplanned(String AccId){
Report repRec=[SELECT Id,Name,DeveloperName from Report ];//where DeveloperName=:system.Label];
string reportPlannedId=repRec.Id;
string filterId=String.valueOf(AccId).substring(0, 15);
// Retrieves report metadata
Reports.ReportDescribeResult describe = Reports.ReportManager.describeReport(reportPlannedId);
Reports.ReportMetadata reportMd = describe.getReportMetadata();
// Add/Override filters
Reports.ReportFilter filterlist = reportMd.getReportFilters()[0];
filterlist .setValue(filterId);
//and Run report
Reports.ReportResults reportResult = Reports.ReportManager.runReport(reportPlannedId,reportMd);
system.debug('ReportResultsJSON'+JSON.serialize(reportResult));
return JSON.serialize(reportResult);
}
}