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

package hu.vpmedia.swf.abstraction {
import abstraction.abc.ABCInspector;
import abstraction.swf.SWFReader;
import abstraction.swf.tags.DoABC2Tag;
import abstraction.swf.tags.Tag;

import flash.utils.ByteArray;

public class SWFReaderWrapper {
    public var swf:SWFReader;
    public var abcTagList:Vector.<DoABC2Tag>;

    public function SWFReaderWrapper() {
    }

    public function parse(data:ByteArray):void {
        abcTagList = new Vector.<DoABC2Tag>();
        swf = new SWFReader(data);
        trace(this, "parse", swf);
        for each(var t:Tag in swf.swf.tags) {
            if (t is DoABC2Tag) {
                var abct:DoABC2Tag = t as DoABC2Tag
                abcTagList.push(abct);
                var inspector:ABCInspector = new ABCInspector(abct.getABC());
                //trace(inspector.inspect)
            }
        }
        trace("Number of found ABC Tags: " + abcTagList.length);
    }
}
}
