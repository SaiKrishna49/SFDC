public class CSVHeader  {

    @AuraEnabled
    public String column_name {get; set;}

    @AuraEnabled
    public String column_type {get; set;}

    public CSVHeader(String column_name, String column_type) {
        this.column_name = column_name;
        this.column_type = column_type;
    } 

    public CSVHeader(String column_name) {
        this.column_name = column_name;
        this.column_type = '';
    }
}