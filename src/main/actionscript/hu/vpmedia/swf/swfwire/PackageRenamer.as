/*
 * =BEGIN CLOSED LICENSE
 *
 *  Copyright(c) 2013 Andras Csizmadia.
 *  http://www.vpmedia.eu
 *
 *  For information about the licensing and copyright please
 *  contact Andras Csizmadia at andras@vpmedia.eu.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 *
 * =END CLOSED LICENSE
 */

package hu.vpmedia.swf.swfwire {
import com.swfwire.decompiler.abc.ABCFile;

import hu.vpmedia.collections.HashMap;
import hu.vpmedia.swf.core.BaseRenameRules;
import hu.vpmedia.swf.core.IdGenerator;
import hu.vpmedia.swf.core.PackageHierarchy;

public class PackageRenamer {
    private var renameRules:BaseRenameRules;
    private var renamedPackages:HashMap;
    private var packageList:Array;
    private var packageHierarchy:PackageHierarchy;

    public function PackageRenamer() {
    }

    public function rename(abcList:Vector.<ABCFile>):void {
        var abc:ABCFile;
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

    private function collectPackages(abc:ABCFile):void {
        // trace(this, "collectPackages");
        /*trace("\tNamespaces:");
         for each (var ns:NamespaceToken in abc.cpool.namespaces)
         {
         if(ns.kind == NamespaceToken.KIND_PackageNamespace  && packageList.indexOf(ns.name) == -1)
         {
         trace(ns.kind, ns.name);
         }
         }*/
        /*  trace("\tMultinames:");
         for each (var mn:MultinameToken in abc.cpool.multinames)
         {
         trace(mn.kind, mn.data);
         }*/
        /* var packageName:String;

         for each (var ns:NamespaceToken in abc.cpool.namespaces)
         {
         packageName = ns.name;
         if(isAllowed(packageName)&& isValid(packageName) && ns.kind == NamespaceToken.KIND_PackageNamespace  && packageList.indexOf(packageName) == -1)
         {
         //trace(ns.name);
         packageList.push(packageName);
         }
         }*/
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

    private function renamePackages(abc:ABCFile):void {
        trace(this, "renamePackages", packageList.length);
        /*
         var packageName:String;
         var obfuscatedPackageName:String;

         for each (var ns:NamespaceToken in abc.cpool.namespaces)
         {
         packageName = ns.name;
         obfuscatedPackageName = renamedPackages.getValue(packageName);
         if(isAllowed(packageName) && isValid(packageName) && ns.kind == NamespaceToken.KIND_PackageNamespace && packageList.indexOf(packageName) != -1)
         {
         //trace(ns.name);
         ns.name = obfuscatedPackageName;
         // trace("\t", packageName, "=>", obfuscatedPackageName);
         }
         }*/
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
        return packageName.indexOf("flash.") != 0 && packageName.indexOf("mx.") != 0 && packageName.indexOf("spark.") != 0;
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
