trigger OppUpdAccTigger on Opportunity (after insert) {
    OppUpdAcc.callme(Trigger.new);

}