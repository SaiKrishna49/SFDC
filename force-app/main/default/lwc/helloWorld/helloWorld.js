import { LightningElement } from 'lwc';

export default class HelloWorld extends LightningElement {
    greeting = 'WORLD';
    changehandler(event){
        this.greeting = event.target.value();
    }
}