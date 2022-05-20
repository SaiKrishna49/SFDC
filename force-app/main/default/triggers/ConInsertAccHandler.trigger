trigger ConInsertAccHandler on Contact (After insert) {
    ConInsertAcc.callme(Trigger.new);
}