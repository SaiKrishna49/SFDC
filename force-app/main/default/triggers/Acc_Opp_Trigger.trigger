trigger Acc_Opp_Trigger on Account (after insert) {
	Acc_Opp_Handler.callme(Trigger.new);
}