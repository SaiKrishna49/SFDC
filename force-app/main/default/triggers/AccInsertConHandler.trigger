trigger AccInsertConHandler on Account (After insert) {
    AccInsertCon.Callme(Trigger.new);

}