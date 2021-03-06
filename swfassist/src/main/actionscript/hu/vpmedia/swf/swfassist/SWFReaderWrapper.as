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

package hu.vpmedia.swf.swfassist {
import flash.utils.ByteArray;

import hu.vpmedia.collections.HashMap;
import hu.vpmedia.utils.SWFUtil;

import org.libspark.swfassist.io.ByteArrayInputStream;
import org.libspark.swfassist.io.DataInput;
import org.libspark.swfassist.swf.io.ReadingContext;
import org.libspark.swfassist.swf.io.SWFReader;
import org.libspark.swfassist.swf.structures.SWF;
import org.libspark.swfassist.swf.tags.AbstractTag;
import org.libspark.swfassist.swf.tags.DoABC;
import org.libspark.swfassist.swf.tags.SymbolClass;
import org.libspark.swfassist.swf.tags.TagCodeConstants;

public class SWFReaderWrapper {
    public var swf:SWF;
    public var swfReader:SWFReader = new SWFReader();
    public var context:ReadingContext = new ReadingContext();
    public var abcTagList:Vector.<DoABC>;
    public var abcList:Vector.<DoABC>;
    public var abcTagMap:HashMap;
    public var symbolTagList:Vector.<SymbolClass>;

    public function SWFReaderWrapper() {
    }

    public function parse(data:ByteArray):void {
        abcList = new Vector.<DoABC>();
        abcTagList = new Vector.<DoABC>();
        abcTagMap = new HashMap(false);
        symbolTagList = new Vector.<SymbolClass>();
        var input:DataInput = new ByteArrayInputStream(SWFUtil.clone(data));
        context.needsABCData = true;
        swf = swfReader.readSWF(input, context);
        processTags();
    }

    protected function processTags():void {
        var tags:Array = swf.tags.tags;
        var n:int = swf.tags.numTags;
        var i:int;
        for (i = 0; i < n; i++) {
            var t:AbstractTag = tags[i];
            read(t);
        }
    }

    protected function read(t:AbstractTag):void {
        switch (t.code) {
            case TagCodeConstants.TAG_SYMBOL_CLASS:
                var symbolTag:SymbolClass = SymbolClass(t);
                symbolTagList.push(symbolTag);
                break;
            case TagCodeConstants.TAG_DO_ABC:
                var abcTag:DoABC = DoABC(t);
                abcList.push(abcTag);
                abcTagList.push(abcTag);
                break;
        }
    }
}
}
