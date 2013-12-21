package hu.vpmedia.collections {
import flash.utils.Dictionary;

public class HashMap implements IBaseMap {
    //----------------------------------
    //  Variables
    //----------------------------------
    /**
     *
     * @default
     */
    protected var _map:Dictionary;

    //----------------------------------
    //  Constructor
    //----------------------------------
    /**
     *
     * @param useWeakReferences
     */
    public function HashMap(useWeakReferences:Boolean = true) {
        _map = new Dictionary(useWeakReferences);
    }

    //----------------------------------
    //  Methods
    //----------------------------------
    /**
     *
     * @param key
     * @param value
     */
    public function put(key:*, value:*):void {
        _map[key] = value;
    }

    /**
     *
     * @param table
     */
    public function putAll(table:Dictionary):void {
        for (var prop:* in table) {
            put(prop, table[prop]);
        }
    }

    /**
     *
     * @param entry
     */
    public function putEntry(entry:Object):void {
        put(entry.key, entry.value);
    }

    /**
     *
     * @param key
     */
    public function remove(key:*):void {
        _map[key] = undefined;
        delete _map[key];
    }

    /**
     *
     * @param key
     * @return
     */
    public function containsKey(key:*):Boolean {
        //return _map.hasOwnProperty( key );
        return _map[key] != null;
    }

    /**
     *
     * @param value
     * @return
     */
    public function containsValue(value:*):Boolean {
        for (var key:* in _map) {
            if (_map[key] == value) {
                return true;
            }
        }
        return false;
    }

    /**
     *
     * @param value
     * @return
     */
    public function getKey(value:*):* {
        var identifier:* = undefined;
        for (var key:* in _map) {
            if (_map[key] == value) {
                identifier = key;
                break;
            }
        }
        return identifier;
    }

    /**
     *
     * @return
     */
    public function getKeys():Array {
        var keys:Array = [];
        for (var key:* in _map) {
            keys.push(key);
        }
        return keys;
    }

    /**
     *
     * @param key
     * @return
     */
    public function getValue(key:*):* {
        return _map[key];
    }

    /**
     *
     * @return
     */
    public function getValues():Array {
        var values:Array = [];
        for (var key:* in _map) {
            values.push(_map[key]);
        }
        return values;
    }

    /**
     *
     * @return
     */
    public function size():int {
        var length:int = 0;
        for (var key:* in _map) {
            length++;
        }
        return length;
    }

    /**
     *
     * @return
     */
    public function isEmpty():Boolean {
        return size() <= 0;
    }

    /**
     *
     */
    public function reset():void {
        for (var key:* in _map) {
            _map[key] = undefined;
        }
    }

    /**
     *
     */
    public function clear():void {
        for (var key:* in _map) {
            remove(key);
        }
    }

    /**
     *
     * @return
     */
    public function getEntries():Array {
        var list:Array = [];
        for (var key:* in _map) {
            list.push({key: key, value: _map[key]});
        }
        return list;
    }
}
}
