public with sharing class QATemplateController {

    public QATemplateController(ApexPages.StandardController controller) {

    }

        public List<QATemplate__c> QAtemplateTmp = new List<QATemplate__c>();
        public QATemplateController(){
        }
        public List<selectOption> QATemplateList{
                get{
                        QAtemplateTmp = [Select id, Name FROM QATemplate__c];
                        QATemplateList = new List<selectOption>();
                        for(QATemplate__c tmp : QAtemplateTmp){
                                QATemplateList.add(new selectOption(tmp.id, tmp.Name));
                        }
                        return QATemplateList;
                }
                set;
        }
}