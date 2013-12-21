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

package hu.vpmedia.swf.codeazur {
import com.codeazur.as3abc.ABC;
import com.codeazur.as3abc.data.ABCNamespace;

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

    public function getPackageList():Array {
        return packageList;
    }

    public function getPackageMap():HashMap {
        return renamedPackages;
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
            var obfuscatedPackageName:String = obfuscatedParentPackage + separator + (renameRules.isAllowedPackage(packageName) ? IdGenerator.next(childPackage) : childPackage);
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
            if (renameRules.isAllowedPackage(packageName) && ns.kind == ABCNamespace.PACKAGE_NAMESPACE && packageList.indexOf(packageName) == -1) {
                //trace(ns.name);
                packageList.push(packageName);
            }
        }
        IdGenerator.sortArrayByLength(packageList);
    }

    private function renamePackages(abc:ABC):void {
        trace(this, "renamePackages", packageList.length);
        for each (var ns:ABCNamespace in abc.constantPool.namespaces) {
            var packageName:String = ns.name;
            if (renameRules.isAllowedPackage(packageName) && ns.kind == ABCNamespace.PACKAGE_NAMESPACE && packageList.indexOf(packageName) > -1) {
                //trace(ns.name);
                ns.name = renamedPackages.getValue(packageName);
                trace(packageName, "=>", ns.name);
            }
        }
    }
}
}
