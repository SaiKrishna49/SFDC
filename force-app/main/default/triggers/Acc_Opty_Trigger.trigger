trigger Acc_Opty_Trigger on Account (after insert) {
    Acc_Opty_Handler.create(Trigger.New);
}