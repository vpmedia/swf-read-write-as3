package hu.vpmedia.collections {
import flash.utils.Dictionary;

public interface IBaseMap extends IBaseCollection {
    function put(key:*, value:*):void;

    function putAll(table:Dictionary):void;

    function putEntry(entry:Object):void;

    function remove(key:*):void;

    function containsKey(key:*):Boolean;

    function containsValue(value:*):Boolean;

    function getKey(value:*):*;

    function getValue(key:*):*;

    function getKeys():Array;

    function getValues():Array;

    function reset():void;

    function clear():void;

    function getEntries():Array;
}
}
