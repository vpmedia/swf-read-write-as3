package hu.vpmedia.swf.utils {
import flash.utils.ByteArray;

public class IdGenerator {
    public function IdGenerator() {
    }

    public static function generateTranslations(originalNames:Array):Array {
        var renamedNames:Array = [];
        var n:int = originalNames.length;
        var i:int;
        for (i = 0; i < n; i++) {
            var s:String = "";
            while ((s == "") || (renamedNames.indexOf(s) > -1)) {
                s = IdGenerator.randomString(originalNames[i].length);
            }
            renamedNames[i] = s;
        }
        return renamedNames;
    }

    public static function sortArrayByLength(inArray:Array):void {
        inArray.sort(function (a:String, b:String):int {
            var aL:int = a.length, bL:int = b.length;
            if (aL < bL)
                return 1;
            else if (aL > bL)
                return -1;
            return 0;
        });
    }

    public static function randomString(length:int):String {
        var s:String = "";
        // while (s.length < length) s += String.fromCharCode (33 + int (32 * Math.random ()));
        while (s.length < length)
            s += String.fromCharCode(65 + int(25 * Math.random()));
        return s;
    }

    public static function findString(data:ByteArray, string:String):Boolean {
        var i:int = 0;
        while (data.bytesAvailable) {
            var char:int = data.readByte();
            if (char == string.charCodeAt(i)) {
                i++;
                if (i == string.length) {
                    // we found match
                    data.position -= string.length;
                    return true;
                }
            }
            else {
                i = 0;
            }
        }
        return false;
    }

    public static function next(oldName:String):String {
        if (!oldName) {
            return null;
        }
        var result:String = randomString(oldName.length);
        return result;
    }
}
}
