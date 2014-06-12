public class ITrigger_T_Module extends ITrigger.Module {

	public override void initBeforeInsert()  { Context.addAll(NList); }
	public override void initBeforeUpdate()  { Context.addAll(NList); }
	public override void initBeforeDelete()  { Context.addAll(OList); }

	public override void initAfterInsert()   { Context.addAll(NList); }
	public override void initAfterUpdate()   { Context.addAll(NList); }
	public override void initAfterDelete()   { Context.addAll(OList); }
	public override void initAfterUndelete() { Context.addAll(NList); }
}