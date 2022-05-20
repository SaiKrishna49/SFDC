public class selectedSizeWorkaround {

  public  ApexPages.StandardSetController setCon{get; set;}

    public selectedSizeWorkaround(ApexPages.StandardSetController controller) {
        setCon = controller;
    }

    public integer getMySelectedSize() {
        return setCon.getSelected().size();
    }
    public integer getMyRecordsSize() {
        return setCon.getRecords().size();
    }
}