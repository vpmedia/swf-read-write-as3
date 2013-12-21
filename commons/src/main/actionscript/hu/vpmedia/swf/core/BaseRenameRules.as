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

package hu.vpmedia.swf.core {
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

    public function isAllowedPackage(packageName:String):Boolean {
        // TODO: validate by RenameActionRule
        return packageName && packageName != ""
                && packageName.indexOf("flash.") != 0
                && packageName.indexOf("flashx.") != 0
                && packageName.indexOf("mx.") != 0
                && packageName.indexOf("spark.") != 0
                && packageName.indexOf("__AS3__.") != 0;
    }
}
}
