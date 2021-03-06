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
import com.codeazur.as3abc.data.ABCNamespace;
import com.codeazur.as3abc.data.multinames.ABCQName;
import com.codeazur.as3abc.data.multinames.Multiname;

public class ClassNameUtil {
    public function ClassNameUtil() {
    }

    // ABCQName
    public static function getFullyQualifiedName(qname:ABCQName):String {
        var packageName:String = qname.abcNamespace.name;
        var className:String = qname.name;
        return (!packageName || packageName == "") ? className : packageName + "." + className;
    }

    public static function getClassName(qname:ABCQName):String {
        var className:String = qname.name;
        return className;
    }

    // Multiname
    public static function getFullyQualifiedNameOfMultiname(multiname:Multiname):String {
        var packageName:String = multiname.namespaceSet[0].name;
        var className:String = multiname.name;
        return (!packageName || packageName == "") ? className : packageName + "." + className;
    }

    // ABCNamespace
    public static function getClassNameOfABCNamespace(namespace:ABCNamespace):String {
        var ns:String = namespace.name;
        var p:int = ns.lastIndexOf(':');
        return p > 0 ? ns.substring(p + 1) : ns;
    }

    public static function getFullyQualifiedNameOfABCNamespace(namespace:ABCNamespace):String {
        var ns:String = namespace.name;
        var p:int = ns.lastIndexOf(':');
        if (p > 0) {
            var packageName:String = ns.substring(0, p);
            var className:String = ns.substring(p + 1);
            return (packageName || packageName == "") ? className : packageName + "." + className;
        }
        else {
            return ns;
        }
    }
}
}
