import { LightningElement, wire } from 'lwc';
//import getAccounts from '@salesforce/apex/tableController.getAccounts';
import apiResponse from '@salesforce/apex/ZenDeskApiClass.apiResponse';
import {exportCSVFile} from 'c/utils'
export default class CsvDemo extends LightningElement {
   /* accountData
    @wire(getAccounts)
    accountHandler({data}){
        if(data){
            console.log(data)
            this.accountData = data
        }
    }*/
  //  [{"url":"https://abc9425.zendesk.com/api/v2/tickets/1.json","id":1,"external_id":null,"via":{"channel":"sample_ticket","source":{"from":{},"to":{},"rel":null}},"created_at":"2022-02-09T07:17:15Z","updated_at":"2022-02-09T07:17:15Z","type":"incident","subject":"Sample ticket: Meet the ticket","raw_subject":"Sample ticket: Meet the ticket","description":"Hi there,\n\nI’m sending an email because I’m having a problem setting up your new product. Can you help me troubleshoot?\n\nThanks,\n The Customer\n\n","priority":"normal","status":"open","recipient":null,"requester_id":392033012557,"submitter_id":1907381549753,"assignee_id":1907381549753,"organization_id":null,"group_id":4420323299089,"collaborator_ids":[],"follower_ids":[],"email_cc_ids":[],"forum_topic_id":null,"problem_id":null,"has_incidents":false,"is_public":true,"due_at":null,"tags":["sample","support","zendesk"],"custom_fields":[],"satisfaction_rating":null,"sharing_agreement_ids":[],"comment_count":1,"fields":[],"followup_ids":[],"ticket_form_id":4420336835985,"brand_id":4420323297169,"allow_channelback":false,"allow_attachments":true}]
    userData= [
        {
            url:"https://abc9425.zendesk.com/api/v2/tickets/1.json",
            id:1,
            external_id:"null",
            via_channel:"sample_ticket",
            via_source_rel: "",
            created_at : "2022-02-09T07:17:15Z",
            updated_at : "2022-02-09T07:17:15Z",
            type : "incident",
            subject : "Sample ticket: Meet the ticket",
            raw_subject : "Sample ticket: Meet the ticket",
            description : "Hi there, I’m sending an email because I’m having a problem setting up your new product. Can you help me troubleshoot?Thanks The Customer",
            priority : "normal",
            status : "open",
            recipient : "",
            requester_id: "392033012557",
            submitter_id : "1907381549753",
            assignee_id : "1907381549753",
            organization_id : "",
            group_id : "4420323299089",
            forum_topic_id : "",
            problem_id : "",
            has_incidents : "FALSE",
            is_public : "TRUE",
            due_at : " ",
            tags_0: " sample",
            tags_1 : "support ",
            tags_2 : "zendesk ",
            satisfaction_rating : " ",
            comment_count : "1",
            ticket_form_id : "4420336835985",
            brand_id : "4420323297169",
            allow_channelback : "FALSE",
            allow_attachments : "TRUE",
        }
    ]

    headers = {
        url:"url",
        id:"id",
        external_id:"external_id",
        via_channel:"via/channel",
        via_source_rel: "via/source/rel",
        created_at:"created_at",
        updated_at:"updated_at",
        type:"type",
        subject:"subject",
        raw_subject:"raw_subject",
        description:"description",
        priority:"priority",
        status:"status",
        recipient:"recipient",
        requester_id:"requester_id",
        submitter_id:"submitter_id",
        assignee_id:"assignee_id",
        organization_id:"organization_id",
        group_id:"group_id",
        forum_topic_id:"forum_topic_id",
        problem_id:"problem_id",
        has_incidents:"has_incidents",
        is_public:"is_public",
        due_at:"due_at",
        tags_0:"tags/0",
        tags_1:"tags/1",
        tags_2:"tags/2",
        satisfaction_rating:"satisfaction_rating",
        comment_count:"comment_count",
        ticket_form_id:"ticket_form_id",
        brand_id:"brand_id",
        allow_channelback:"allow_channelback",
        allow_attachments:"allow_attachments"
    }

    accountHeaders ={
        Id:"Record Id",
        Name:"Name",
        AnnualRevenue:"Annual Revenue",
        Industry:"Industry",
        Phone:"Phone"

    }
    downloadUserDetails(){
        console.log("download triggered.")
        exportCSVFile(this.headers, this.userData, "user detail")
    }
    downloadAccountData(){
        exportCSVFile(this.accountHeaders, this.accountData, "accounts detail")
    }
}