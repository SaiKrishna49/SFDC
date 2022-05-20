public with sharing class TranslationController {
public string LanguageChoosen{get;set;}
public List<selectoption> Langlist {get;set;}
public TranslationController(ApexPages.StandardController controller) {
LanguageChoosen='en';
Langlist = new List<selectOption>();
Langlist.add(new selectOption('en','English'));
Langlist.add(new selectOption('it','Italian'));
Langlist.add(new selectOption('es','Spanish'));
Langlist.add(new selectOption('de','German'));
Langlist.add(new selectOption('fr','French'));
}
}