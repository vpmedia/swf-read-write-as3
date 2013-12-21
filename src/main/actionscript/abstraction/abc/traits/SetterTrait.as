package abstraction.abc.traits {
import abstraction.abc.MethodInfo;
import abstraction.abc.Multiname;

public class SetterTrait extends Trait {
    public var disp_id:int, // most likely a displacement ID for an object's virtual function table
            method:MethodInfo

    public function SetterTrait(name:Multiname, kind:int) {
        super(name, kind)
    }

    override public function fastInit(...args):void {
        disp_id = args[0]
        method = args[1]
    }
}
}