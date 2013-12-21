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
import com.swfwire.decompiler.SWF10Reader;
import com.swfwire.decompiler.SWFByteArray;
import com.swfwire.decompiler.SWFReadResult;
import com.swfwire.decompiler.abc.ABCFile;
import com.swfwire.decompiler.data.swf.SWF;
import com.swfwire.decompiler.data.swf.records.RectangleRecord;
import com.swfwire.decompiler.data.swf.tags.MetadataTag;
import com.swfwire.decompiler.data.swf.tags.SWFTag;
import com.swfwire.decompiler.data.swf.tags.SetBackgroundColorTag;
import com.swfwire.decompiler.data.swf10.tags.ProductInfoTag;
import com.swfwire.decompiler.data.swf8.tags.FileAttributesTag;
import com.swfwire.decompiler.data.swf9.tags.DoABCTag;
import com.swfwire.decompiler.data.swf9.tags.SymbolClassTag;

import flash.geom.Rectangle;
import flash.utils.ByteArray;

import hu.vpmedia.collections.HashMap;
import hu.vpmedia.swf.core.IBaseSWFReader;

public class SWFWireReader implements IBaseSWFReader {
    private var swfReader:SWF10Reader;
    public var swf:SWF;
    public var abcTagList:Vector.<DoABCTag>;
    public var abcList:Vector.<ABCFile>;
    public var abcTagMap:HashMap;
    public var symbolTagList:Vector.<SymbolClassTag>;

    public function SWFWireReader() {
    }

    public function parse(data:ByteArray):void {
        abcTagList = new Vector.<DoABCTag>();
        abcList = new Vector.<ABCFile>();
        abcTagMap = new HashMap(false);
        symbolTagList = new Vector.<SymbolClassTag>();
        swfReader = new SWF10Reader();
        var swfBA:SWFByteArray = new SWFByteArray(data);
        var swfReadResult:SWFReadResult = swfReader.read(swfBA);
        swf = swfReadResult.swf;
        processTags();
    }

    public function getBackgroundColor():uint {
        return 0;
    }

    public function getFileLength():uint {
        return swf.header.uncompressedSize;
    }

    //
    public function getNumFrames():uint {
        return swf.header.frameCount;
    }

    public function getVersion():uint {
        return swf.header.fileVersion;
    }

    public function getRectangle():Rectangle {
        var rect:RectangleRecord = swf.header.frameSize;
        var result:Rectangle = new Rectangle(rect.xMin, rect.yMin, rect.xMax, rect.yMax);
        return result;
    }

    public function getFrameRate():Number {
        return swf.header.frameRate;
    }

    public function isCompressed():Boolean {
        return true;
    }

    protected function processTags():void {
        var tags:Vector.<SWFTag> = swf.tags;
        var n:int = swf.tags.length;
        var i:int;
        for (i = 0; i < n; i++) {
            var t:SWFTag = tags[i];
            read(t);
        }
    }

    private function read(t:SWFTag):void {
        trace(t.header.type, t);
        switch (t.header.type) {
            case 76:
                var symbolTag:SymbolClassTag = SymbolClassTag(t);
                symbolTagList.push(symbolTag);
                break;
            case 82:
                var abcTag:DoABCTag = DoABCTag(t);
                var abc:ABCFile = abcTag.abcFile;
                // abcTagList.push(abcTag);
                abcList.push(abc);
                abcTagMap.put(abc, abcTag);
                break;
            case 69:
                var fileAttributesTag:FileAttributesTag = FileAttributesTag(t);
                break;
            case 77:
                //metadata
                var metadataTag:MetadataTag = MetadataTag(t);
                break;
            case 9:
                //bgc
                var backgroundColorTag:SetBackgroundColorTag = SetBackgroundColorTag(t);
                break;
            case 41:
                //product info tag
                var productInfoTag:ProductInfoTag = ProductInfoTag(t);
                break;
        }
    }
}
}
