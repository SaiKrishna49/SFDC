public class ReportFilterClass {
    public static void fltrReport(){

    
// Get the report ID
List <Report> reportList = [SELECT Id,DeveloperName FROM Report where 
    DeveloperName = 'New_Contacts_Accounts_Report_GqC'];
String reportId = (String)reportList.get(0).get('Id');

// Get the report metadata
Reports.ReportDescribeResult describe = Reports.ReportManager.describeReport(reportId);
Reports.ReportMetadata reportMd = describe.getReportMetadata();
        Reports.ReportMetadata reportMetadata =
          Reports.ReportManager.describeReport(reportId).getReportMetadata();

// Override filter and run report
Reports.ReportFilter filter = reportMd.getReportFilters()[0];
        system.debug('filter='+reportMd.getReportFilters());
filter.setValue('web');
        reportMetadata.setReportFilters(new List<Reports.ReportFilter> {filter});
        system.debug('filter='+filter);
Reports.ReportResults results = Reports.ReportManager.runReport(reportId, reportMd);
        system.debug('filter='+filter);
        system.debug('results=='+results);
       // Reports.ReportResults results = Reports.ReportManager.runReport(reportId, reportMd);
Reports.ReportFactWithSummaries factSum = 
    (Reports.ReportFactWithSummaries)results.getFactMap().get('T!T');
        system.debug('factSum=='+factSum);
        
        
   }}      
        
        
        
        
        
        
        
        
       /* Reports.reportResults results1 = Reports.ReportManager.runReport(reportId, true);

// Get the first down-grouping in the report
Reports.Dimension dim = results1.getGroupingsDown();
Reports.GroupingValue groupingVal = dim.getGroupings()[0];
System.debug('Key: ' + groupingVal.getKey());
System.debug('Label: ' + groupingVal.getLabel());
System.debug('Value: ' + groupingVal.getValue());

// Construct a fact map key, using the grouping key value
String factMapKey = groupingVal.getKey() + '!T';

// Get the fact map from the report results
Reports.ReportFactWithDetails factDetails =
    (Reports.ReportFactWithDetails)results.getFactMap().get(factMapKey);

// Get the first summary amount from the fact map
//Reports.SummaryValue sumVal = factDetails.getAggregates()[0];
//System.debug('Summary Value: ' + sumVal.getLabel());

// Get the field value from the first data cell of the first row of the report
Reports.ReportDetailRow detailRow = factDetails.getRows()[0];
System.debug(detailRow.getDataCells()[0].getLabel());*/