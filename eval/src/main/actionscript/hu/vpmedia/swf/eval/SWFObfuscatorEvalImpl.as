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

package hu.vpmedia.swf.eval {
import com.hurlant.eval.CompiledESC;

import flash.utils.ByteArray;

import hu.vpmedia.swf.core.IBaseSWFObfuscator;

public class SWFObfuscatorEvalImpl implements IBaseSWFObfuscator {
    private var esc:CompiledESC = new CompiledESC;
    //private var swfReader:SWFReaderWrapper;

    public function SWFObfuscatorEvalImpl() {
        //swfReader = new SWFReaderWrapper();
        super();
    }

    public function obfuscate(data:ByteArray):ByteArray {
        trace(this, "obfuscate");
        /*swfReader.parse(data);
         var a:Array = swfReader.abcTagMap.getValues();
         var n:int = a.length;
         for (var i:int = 0; i < n; i++) {
         var bs:ABCByteStream = new ABCByteStream(a[i].bytes);
         trace(bs);
         trace(ABCDump.dump(bs.getBytes()));
         }
         processTags();*/
        return data;
    }

    private function processTags():void {
    }

    private function writeBackTags():void {
    }
}
}
