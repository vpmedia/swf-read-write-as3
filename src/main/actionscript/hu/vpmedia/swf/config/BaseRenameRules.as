package hu.vpmedia.swf.config {
public class BaseRenameRules {
    protected var _action:String;
    protected var _rules:Array;

    public function BaseRenameRules() {
        _action = RenameActions.ALLOW;
        _rules = [];
    }

    public function getAction():String {
        return _action;
    }

    public function setAction(value:String):void {
        _action = value;
    }

    public function addRule(value:BaseRenameRule):void {
        _rules.push(value);
    }

    public function allowRename(id:String):Boolean {
        return BaseRenameRule(_rules[id]).isRenameAllowed();
    }
}
}
