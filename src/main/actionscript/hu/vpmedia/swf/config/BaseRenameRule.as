package hu.vpmedia.swf.config {
public class BaseRenameRule {
    protected var _action:String;

    public function BaseRenameRule() {
        _action = RenameActions.ALLOW;
    }

    public function isRenameAllowed():Boolean {
        return _action == RenameActions.ALLOW;
    }
}
}
