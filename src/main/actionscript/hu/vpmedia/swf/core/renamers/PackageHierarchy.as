package hu.vpmedia.swf.core.renamers {
import hu.vpmedia.collections.HashMap;
import hu.vpmedia.collections.StringIterator;

public class PackageHierarchy {
    private var childPackageMap:HashMap;

    public function PackageHierarchy() {
        childPackageMap = new HashMap(false);
    }

    public function addPackages(packages:Array):void {
        var n:int = packages.length;
        var i:int;
        for (i = 0; i < n; i++) {
            var packageParts:Array = splitPackageParts(packages[i]);
            if (packageParts.length > 0) {
                addChildPackages(packageParts);
            }
        }
    }

    private function addChildPackages(packageParts:Array):void {
        // trace(this, "addChildPackages", packageParts);
        var parent:String = "";
        var n:int = packageParts.length;
        var i:int;
        for (i = 0; i < n; i++) {
            var childPackages:Array;
            var packagePart:String = packageParts[i];
            if (!childPackageMap.getValue(parent))
                childPackageMap.put(parent, []);
            childPackages = childPackageMap.getValue(parent);
            if (childPackages.indexOf(packagePart) == -1)
                childPackages.push(packagePart);
            if (parent != "")
                parent = parent + ".";
            parent = parent + packagePart;
        }
    }

    private function splitPackageParts(packageName:String):Array {
        var result:Array = [];
        if (packageName) {
            var st:StringIterator = new StringIterator(packageName, ".");
            while (st.hasNext()) {
                result.push(st.next());
            }
        }
        return result;
    }

    public function getChildPackages(packageName:String):Array {
        return childPackageMap.getValue(packageName);
    }
}
}
