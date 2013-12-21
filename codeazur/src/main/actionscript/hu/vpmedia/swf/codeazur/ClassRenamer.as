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
import com.codeazur.as3abc.data.NominalType;

import hu.vpmedia.collections.HashMap;
import hu.vpmedia.swf.core.BaseRenameRules;
import hu.vpmedia.swf.core.ClassHierarchy;
import hu.vpmedia.swf.core.IdGenerator;

public class ClassRenamer {
    private var renameRules:BaseRenameRules;
    private var renamedClasses:HashMap;
    private var classList:Array;
    private var classHierarchy:ClassHierarchy;

    public function ClassRenamer() {
    }

    public function rename(abcList:Vector.<ABC>):void {
        var abc:ABC;
        // collect
        renameRules = new BaseRenameRules();
        classHierarchy = new ClassHierarchy();
        classList = [];
        for each (abc in abcList) {
            collectClasses(abc);
        }
        classHierarchy.addClasses(classList);
        // obfuscate
        renamedClasses = new HashMap(false);
        generateObfuscatedNames();
        // rename
        for each (abc in abcList) {
            renameClasses(abc);
        }
    }

    private function collectClasses(abc:ABC):void {
        // trace(this, "collectClasses");
        var className:String;
        for each (var nt:NominalType in abc.types) {
            className = ClassNameUtil.getFullyQualifiedName(nt.name);
            if (renameRules.isAllowedPackage(className) && classList.indexOf(className) == -1) {
                classList.push(className);
            }
        }
        IdGenerator.sortArrayByLength(classList);
        //trace(this, classList);
    }

    private function generateObfuscatedNames():void {
        var n:int = classList.length;
        var i:int;
        for (i = 0; i < n; i++) {
            // ClassNameUtil.getClassName()
        }
    }

    private function renameClasses(abc:ABC):void {
        //trace(this, "renameClasses", classList.length);
    }
}
}
