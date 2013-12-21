package abstraction.abc.traits {
import abstraction.abc.MethodInfo;
import abstraction.abc.Multiname;

public class FunctionTrait extends Trait {
    public var slot_id:int,
            function_info:MethodInfo

    public function FunctionTrait(name:Multiname, kind:int) {
        super(name, kind)
    }

    override public function fastInit(...args):void {
        slot_id = args[0]
        function_info = args[1]
    }
}
}