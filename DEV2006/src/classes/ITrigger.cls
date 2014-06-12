/**
 * Intellio Trigger
 *
 * @company   Intellio - Solutions Cloud
 * @author    Jean-Philippe Monette <jp.monette@intellio.ca>
 * @since     2014-01-31
 */
public class ITrigger {

/** ===========================================================================
 *  Trigger Logic Handlers
 *  ======================================================================== */

    /**
     * Binding module if it is enabled
     * @param   Type    Type of class
     * @return  IModule
     * @access  public
     */
    public ITrigger bind(Type R)
    {
        Modules.add(R);
        return this;
    }

    /**
     * Manage trigger execution
     * @return  void
     * @access  public
     */
    public void manage()
    {
        if(Modules.isEmpty()) return;

        Savepoint sp = Database.setSavepoint();

        try {
            if(Trigger.isBefore)
                if(Trigger.isInsert)      beforeInsert();
                else if(Trigger.isUpdate) beforeUpdate();
                else                      beforeDelete();
            else
                if(Trigger.isInsert)      afterInsert();
                else if(Trigger.isUpdate) afterUpdate();
                else if(Trigger.isDelete) afterDelete();
                else                      afterUndelete();
        }

        catch(Exception e)
        {
            Trigger.new[0].addError(e.getMessage());
            System.debug('Exception caught in ITrigger');
        }
    }

    private void beforeInsert()  { for(Type R : Modules) build(R).handleBeforeInsert(); }
    private void beforeUpdate()  { for(Type R : Modules) build(R).handleBeforeUpdate(); }
    private void beforeDelete()  { for(Type R : Modules) build(R).handleBeforeDelete(); }

    private void afterInsert()   { for(Type R : Modules) build(R).handleAfterInsert(); }
    private void afterUpdate()   { for(Type R : Modules) build(R).handleAfterUpdate(); }
    private void afterDelete()   { for(Type R : Modules) build(R).handleAfterDelete(); }
    private void afterUndelete() { for(Type R : Modules) build(R).handleAfterUndelete(); }

    /**
     * Building and constructing ModuleInterface instance
     * @param   Type                ModuleInterface name
     * @return  ModuleInterface     Instantiated class
     * @access  private
     */
    private ModuleInterface build(Type R)
    { 
        return ((ModuleInterface) R.newInstance())
            .construct(Trigger.new, Trigger.old, Trigger.newMap, Trigger.oldMap);
    }

    Type[] Modules = new Type[]{};

/** ===========================================================================
 *  Module Interfaces & Virtual Classes
 *  ======================================================================== */

    /**
     * ModuleInterface interface
     */
    public interface ModuleInterface
    {
        void initBeforeInsert();
        void initBeforeUpdate();
        void initBeforeDelete();
        void initAfterInsert();
        void initAfterUpdate();
        void initAfterDelete();
        void initAfterUndelete();       

        void beforeInsert();
        void beforeUpdate();
        void beforeDelete();
        void afterInsert();
        void afterUpdate();
        void afterDelete();
        void afterUndelete();

        void handleBeforeInsert();
        void handleBeforeUpdate();
        void handleBeforeDelete();
        void handleAfterInsert();
        void handleAfterUpdate();
        void handleAfterDelete();
        void handleAfterUndelete();

        Module construct(SObject[] NL, SObject[] OL, Map<ID, SObject> NM, Map<ID, SObject> OM);
    }

    /**
     * Module Virtual class
     */
    public virtual class Module implements ModuleInterface
    {
        public SObject[] Context = new SObject[]{};

        public SObject[] NList, OList;
        public Map<ID, SObject> NMap, OMap;

        public Boolean isError = false;

        public virtual void initBeforeInsert(){}
        public virtual void initBeforeUpdate(){}
        public virtual void initBeforeDelete(){}

        public virtual void initAfterInsert(){}
        public virtual void initAfterUpdate(){}
        public virtual void initAfterDelete(){}
        public virtual void initAfterUndelete(){}

        public virtual void beforeInsert(){}
        public virtual void beforeUpdate(){}
        public virtual void beforeDelete(){}

        public virtual void afterInsert(){}
        public virtual void afterUpdate(){}
        public virtual void afterDelete(){}
        public virtual void afterUndelete(){}

        public void handleBeforeInsert()
        {
            initBeforeInsert();
            if(Context.size() > 0) beforeInsert();
        }

        public void handleBeforeUpdate()
        {
            initBeforeUpdate();
            if(Context.size() > 0) beforeUpdate();
        }

        public void handleBeforeDelete()
        {
            initBeforeDelete();
            if(Context.size() > 0) beforeDelete();
        }

        public void handleAfterInsert()
        {
            initAfterInsert();
            if(Context.size() > 0) afterInsert();
        }

        public void handleAfterUpdate()
        {
            initAfterUpdate();
            if(Context.size() > 0) afterUpdate();
        }

        public void handleAfterDelete()
        {
            initAfterDelete();
            if(Context.size() > 0) afterDelete();
        }

        public void handleAfterUndelete()
        {
            initAfterUndelete();
            if(Context.size() > 0) afterUndelete();
        }

        public virtual Module construct(SObject[] NL, SObject[] OL, Map<ID, SObject> NM, Map<ID, SObject> OM)
            { NList = NL; OList = OL; NMap = NM; OMap = OM; return this; }
    }
}