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
import flash.geom.Rectangle;
import flash.utils.ByteArray;

import hu.vpmedia.collections.HashMap;
import hu.vpmedia.swf.core.IBaseSWFReader;

import zero.swf.SWF;
import zero.swf.avm2.ABCClass;
import zero.swf.avm2.ABCTrait;
import zero.swf.utils.getDocClass;

public class SWFReaderWrapper implements IBaseSWFReader {
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
        var swf:SWF = new SWF();
        swf.initBySWFData(data, null);
        var docClass:ABCClass = getDocClass(swf);
        if (docClass) {
            for each(var trait:ABCTrait in docClass.ctraitV) {
                if (trait.name.name == "name") {
                    if (trait.vkindAndVIndex) {
                        var name:String = trait.vkindAndVIndex.value;
                    }
                    break;
                }
            }

        }
    }

    public function getCode():uint {
        return 0;
    }

    public function isActionScript3():Boolean {
        return true;
    }

    public function hasMetadata():Boolean {
        return false;
    }

    public function useNetwork():Boolean {
        return true;
    }

    //
    public function getNumFrames():uint {
        return swf.FrameCount;
    }

    public function getVersion():uint {
        return swf.Version;
    }

    public function getRectangle():Rectangle {
        return null;
    }

    public function getFrameRate():Number {
        return swf.FrameRate;
    }

    public function isCompressed():Boolean {
        return false;
    }
}
}
