trigger Products on Product2 (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    new ITrigger()
            .bind(ITrigger_T_Module.class)
            .manage();
}