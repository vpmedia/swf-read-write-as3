package hu.vpmedia.collections {
import flash.errors.IllegalOperationError;

public class StringIterator {
    protected var _source:String;
    protected var _delimiter:String;
    protected var _list:Array;
    protected var _cursor:int;

    //----------------------------------
    //  Constructor
    //----------------------------------
    public function StringIterator(source:String, delimiter:String) {
        if (!source) {
            throw new IllegalOperationError();
        }
        _source = source;
        _delimiter = delimiter;
        _list = source.split(delimiter);
        _cursor = 0;
    }

    //----------------------------------
    //  Methods
    //----------------------------------
    public function size():int {
        return _list.length;
    }

    public function hasNext():Boolean {
        return _cursor < _list.length;
    }

    public function hasPrevious():Boolean {
        return _cursor >= 0 && _list.length;
    }

    public function next():String {
        var token:String;
        if (hasNext()) {
            token = _list[_cursor];
            _cursor++;
        }
        return token;
    }

    public function previous():String {
        _cursor = _cursor >= _list.length ? _list.length - 1 : _cursor;
        return _list[_cursor--];
    }

    public function reset():void {
        _cursor = 0;
    }

    public function position():int {
        return _cursor;
    }
}
}
