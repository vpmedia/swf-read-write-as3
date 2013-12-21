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
import com.codeazur.as3swf.SWF;
import com.codeazur.as3swf.tags.ITag;
import com.codeazur.as3swf.tags.TagDoABC;
import com.codeazur.as3swf.tags.TagFileAttributes;
import com.codeazur.as3swf.tags.TagSymbolClass;

import flash.utils.ByteArray;

import hu.vpmedia.collections.HashMap;

public class SWFReaderWrapper {
    public var swf:SWF;
    public var abcList:Vector.<ABC>;
    public var abcTagMap:HashMap;
    //public var symbolTagList:Vector.<TagSymbolClass>;

    public function SWFReaderWrapper() {
    }

    public function parse(data:ByteArray):void {
        abcList = new Vector.<ABC>();
        abcTagMap = new HashMap(false);
        //symbolTagList = new Vector.<TagSymbolClass>();
        swf = new SWF(data);
        //trace(swf);
        processTags();
    }

    protected function processTags():void {
        const tags:Vector.<ITag> = swf.tags;
        const n:int = swf.tags.length;
        for (var i:int = 0; i < n; i++) {
            const t:ITag = tags[i];
            switch (t.type) {
                case TagSymbolClass.TYPE:
                    const symbolTag:TagSymbolClass = TagSymbolClass(t);
                    //symbolTagList.push(symbolTag);
                    break;
                case TagDoABC.TYPE:
                    const abcTag:TagDoABC = TagDoABC(t);
                    const abc:ABC = new ABC(abcTag.bytes);
                    // abcTagList.push(abcTag);
                    abcList.push(abc);
                    abcTagMap.put(abc, abcTag);
                    break;
                case TagFileAttributes.TYPE:
                    const fileAttribTag:TagFileAttributes = TagFileAttributes(t);
                    break;
            }
        }
    }
}
}
