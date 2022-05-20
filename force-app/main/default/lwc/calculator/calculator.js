import { LightningElement } from 'lwc';

export default class CalcFull extends LightningElement {
    calcResult = '';
    calcExpression = '';
    clrExpression = false;
    prevOper = '';
    operations = {
        current: 0,
        '=': function(){
            return this.current;
        },
        '+': function(n){
            this.current += parseInt(n);
            return this;
        },
        '-': function(n){
            this.current -= parseInt(n);
            return this;
        },
        '*': function(n){
            this.current *= parseInt(n);
            return this;
        },
        '/': function(n){
            this.current /= parseInt(n);
            return this;
        }
    }

    get showResult(){
        return this.operations.current;
    }

    handleClick(event){
        if (this.clrExpression){
            this.calcExpression = '';
            this.calcResult = '';
            this.operations.current = 0;
            this.clrExpression = false;
        }
        this.calcExpression = this.calcExpression + event.target.label;
        if (event.target.label === "CLR"){
            this.calcResult = '';
            this.calcExpression = '';
            this.operations.current = 0;
        }
        else if (event.target.label === "+"){
            if (this.operations.current === 0)
            {
                this.operations.current = parseInt(this.calcResult);
            }
            else{
                this.calcResult = this.operations[this.prevOper](this.calcResult);
            }
            this.prevOper = '+';
            this.calcResult = '';
        }
        else if (event.target.label === "-"){
            if (this.operations.current === 0)
            {
                this.operations.current = parseInt(this.calcResult);
            }
            else{
                this.calcResult = this.operations[this.prevOper](this.calcResult);
            }
            this.prevOper = '-';
            this.calcResult = '';
        }
        else if (event.target.label === "*"){
            if (this.operations.current === 0)
            {
                this.operations.current = parseInt(this.calcResult);
            }
            else{
                this.calcResult = this.operations[this.prevOper](this.calcResult);
            }
            this.prevOper = '*';
            this.calcResult = '';
        }
        else if (event.target.label === "/"){
            if (this.operations.current === 0)
            {
                this.operations.current = parseInt(this.calcResult);
            }
            else{
                this.calcResult = this.operations[this.prevOper](this.calcResult);
            }
            this.prevOper = '/';
            this.calcResult = '';
        }
        else if (event.target.label === "="){
            this.calcResult = this.operations[this.prevOper](this.calcResult);
            this.calcResult = this.operations['=']();
            this.clrExpression = true;
        }
        else{
            this.calcResult = this.calcResult + event.target.label;
            
        }
    }
}