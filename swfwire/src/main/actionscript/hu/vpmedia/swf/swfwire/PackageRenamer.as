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
import com.swfwire.decompiler.abc.tokens.MultinameToken;
import com.swfwire.decompiler.abc.tokens.NamespaceToken;

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
        renameRules = new BaseRenameRules();
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

    private function collectPackages(abc:ABCFile):void {
        trace(this, "collectPackages");
        trace("\tNamespaces:");
        for each (var ns:NamespaceToken in abc.cpool.namespaces) {
            if (ns.kind == NamespaceToken.KIND_PackageNamespace && packageList.indexOf(ns.name) == -1) {
                trace(ns);
            }
        }
        trace("\tMultinames:");
        for each (var mn:MultinameToken in abc.cpool.multinames) {
            trace(mn);
        }
        IdGenerator.sortArrayByLength(packageList);
    }

    private function renamePackages(abc:ABCFile):void {
        trace(this, "renamePackages", packageList.length);
    }
}
}
