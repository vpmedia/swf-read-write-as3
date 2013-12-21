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

package hu.vpmedia.swf.zero {
import flash.utils.ByteArray;

import hu.vpmedia.collections.HashMap;

import zero.swf.SWF;
import zero.swf.avm2.ABCClass;
import zero.swf.avm2.ABCTrait;
import zero.swf.utils.getDocClass;

public class SWFReaderWrapper {
    public var swf:SWF;
    public var abcTagList:Vector.<*>;
    public var abcList:Vector.<*>;
    public var abcTagMap:HashMap;
    public var symbolTagList:Vector.<*>;

    public function SWFReaderWrapper() {
    }

    public function parse(data:ByteArray):void {
        abcList = new Vector.<*>();
        abcTagList = new Vector.<*>();
        abcTagMap = new HashMap(false);
        symbolTagList = new Vector.<*>();
        swf = new SWF();
        trace(this, "parse", swf);
        swf.initBySWFData(data, null);
        var docClass:ABCClass = getDocClass(swf);
        trace(docClass);
        if (docClass) {
            for each(var trait:ABCTrait in docClass.ctraitV) {
            }

        }
    }
}
}
