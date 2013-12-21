package hu.vpmedia.utils {
public class SWFReportParser {
    public var packages:Array;
    public var classes:Array;
    public var sourceNamespaces:Array;
    public var excludeClasses:Array;
    public var excludePackages:Array;

    public function SWFReportParser() {
        sourceNamespaces = [];
        excludeClasses = [];
        excludePackages = [];
    }

    public function parseXML(xml:XML):void {
        packages = [];
        classes = [];
        var list:XMLList = xml..script;
        //trace(list);
        var fcq:String;
        var tmp:Array;
        var paqage:String;
        var clazz:String;
        var canUse:Boolean;
        var i:int;
        var n:int;
        for each (var node:XML in list) {
            //trace(node);
            fcq = node.def.@id;
            if (fcq.indexOf(":") > -1) {
                tmp = fcq.split(":");
                paqage = tmp[0];
                clazz = tmp[1];
            }
            else {
                tmp = null;
                paqage = null;
                clazz = fcq;
            }
            canUse = false;
            if (paqage) {
                n = sourceNamespaces.length;
                for (i = 0; i < n; i++) {
                    if (paqage.indexOf(sourceNamespaces[i]) == 0 && excludePackages.indexOf(paqage) == -1) {
                        canUse = true;
                    }
                }
            }
            //trace(canUse, paqage, clazz);
            if (canUse) {
                if (paqage && packages.indexOf(paqage) == -1) {
                    packages.push(paqage);
                }
                if (clazz && classes.indexOf(clazz) == -1 && excludeClasses.indexOf(clazz) != 0) {
                    classes.push(clazz);
                }
            }
        }
    }
}
}
