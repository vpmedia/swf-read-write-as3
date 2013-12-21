package hu.vpmedia.swf.codeazur.renamers {
import com.codeazur.as3abc.ABC;
import com.codeazur.as3abc.data.ABCNamespace;

import hu.vpmedia.collections.HashMap;
import hu.vpmedia.swf.config.BaseRenameRules;
import hu.vpmedia.swf.core.renamers.BaseRenamer;
import hu.vpmedia.swf.core.renamers.PackageHierarchy;
import hu.vpmedia.swf.utils.IdGenerator;

public class PackageRenamer extends BaseRenamer {
    private var renameRules:BaseRenameRules;
    private var renamedPackages:HashMap;
    private var packageList:Array;
    private var packageHierarchy:PackageHierarchy;

    public function PackageRenamer() {
    }

    public function rename(abcList:Vector.<ABC>):void {
        var abc:ABC;
        // collect
        packageHierarchy = new PackageHierarchy();
        packageList = [];
        for each (abc in abcList) {
            collectPackages(abc);
        }
        packageHierarchy.addPackages(packageList);
        // obfuscate
        renamedPackages = new HashMap(false);
        generateObfuscatedNames("");
        // rename
        for each (abc in abcList) {
            renamePackages(abc);
        }
    }

    private function generateObfuscatedNames(parent:String):void {
        var obfuscatedParentPackage:String = "";
        if (parent != "") {
            obfuscatedParentPackage = renamedPackages.getValue(parent);
        }
        //trace(this, "generateObfuscatedNames", parent);
        var childPackages:Array = packageHierarchy.getChildPackages(parent);
        if (!childPackages) {
            //trace(this, "error", parent);
            return;
        }
        var n:int = childPackages.length;
        var i:int;
        for (i = 0; i < n; i++) {
            var childPackage:String = childPackages[i];
            var separator:String = (parent == "" ? "" : ".");
            var packageName:String = parent + separator + childPackage;
            var obfuscatedPackageName:String = obfuscatedParentPackage + separator + (isAllowed(packageName) ? IdGenerator.next(childPackage) : childPackage);
            //trace(packageName, obfuscatedPackageName);
            renamedPackages.put(packageName, obfuscatedPackageName);
            generateObfuscatedNames(packageName);
        }
    }

    private function collectPackages(abc:ABC):void {
        // trace(this, "collectPackages");
        var packageName:String;
        for each (var ns:ABCNamespace in abc.constantPool.namespaces) {
            packageName = ns.name;
            if (isAllowed(packageName) && isValid(packageName) && ns.kind == ABCNamespace.PACKAGE_NAMESPACE && packageList.indexOf(packageName) == -1) {
                //trace(ns.name);
                packageList.push(packageName);
            }
        }
        /*for each (var nt:NominalType in abc.types)
         {
         packageName = nt.name.abcNamespace.name;
         if(isAllowed(packageName)&& isValid(packageName) && packageList.indexOf(packageName) == -1)
         {
         // trace("\t", packageName);
         packageList.push(packageName);
         }
         } */
        IdGenerator.sortArrayByLength(packageList);
    }

    private function renamePackages(abc:ABC):void {
        trace(this, "renamePackages", packageList.length);
        var packageName:String;
        var obfuscatedPackageName:String;
        for each (var ns:ABCNamespace in abc.constantPool.namespaces) {
            packageName = ns.name;
            obfuscatedPackageName = renamedPackages.getValue(packageName);
            if (isAllowed(packageName) && isValid(packageName) && ns.kind == ABCNamespace.PACKAGE_NAMESPACE && packageList.indexOf(packageName) != -1) {
                //trace(ns.name);
                ns.name = obfuscatedPackageName;
                // trace("\t", packageName, "=>", obfuscatedPackageName);
            }
        }
        /*for each (var nt:NominalType in abc.types)
         {
         packageName = nt.name.abcNamespace.name;
         if(isAllowed(packageName) && isValid(packageName) && packageList.indexOf(packageName) != -1)
         {
         obfuscatedPackageName = renamedPackages.getValue(packageName);
         nt.name.abcNamespace.name = obfuscatedPackageName;
         //trace("\t", packageName, "=>", obfuscatedPackageName);
         }
         }*/
    }

    private function isValid(packageName:String):Boolean {
        return (packageName && packageName != "");
    }

    private function isAllowed(packageName:String):Boolean {
        // TODO: validate by RenameActionRule
        return packageName.indexOf("flash.") != 0 && packageName.indexOf("flashx.") != 0 && packageName.indexOf("mx.") != 0 && packageName.indexOf("spark.") != 0 && packageName.indexOf("__AS3__.") != 0;
    }

    public function getObfuscatedName(packageName:String):String {
        return renamedPackages.getValue(packageName);
    }

    public function getPackages():Array {
        return packageList;
    }

    public function getObfuscationMap():HashMap {
        return renamedPackages;
    }
}
}
