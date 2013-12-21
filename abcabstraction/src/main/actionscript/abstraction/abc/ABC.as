package abstraction.abc {
import flash.utils.*;

/**
 * An abstraction of ActionScript bytecode, sometimes called action block code.  Its definitions
 * can be modified, deleted, and added to via ABC instances and assembled back into a ByteArray
 * using ABCWriter.  These can be created manually or from an existing ByteArray with ABCReader.
 */
public class ABC {
    public static const Int:int = 0x03,
            UInt:int = 0x04,
            Double:int = 0x06,
            Utf8:int = 0x01,
            True:int = 0x0b,
            False:int = 0x0a,
            Null:int = 0x0c,
            Undefined:int = 0x00,
            Namespace:int = 0x08,
            PackageNamespace:int = 0x16,
            PackageInternalNs:int = 0x17,
            ProtectedNamespace:int = 0x18,
            ExplicitNamespace:int = 0x19,
            StaticProtectedNs:int = 0x1a,
            PrivateNs:int = 0x05

    public static const ClassSealed:int = 0x01,
            ClassFinal:int = 0x02,
            ClassInterface:int = 0x04,
            ClassProtectedNs:int = 0x08

    public var abcname:String,
            flags:uint,
            length:uint

    public var useless:Boolean = false

    public var minor_version:uint,
            major_version:uint,
            int_count:int,
            uint_count:int,
            double_count:int,
            string_count:int,
            namespace_count:int,
            ns_set_count:int,
            multiname_count:int,
            method_count:int,
            metadata_count:int,
            class_count:int,
            script_count:int,
            method_body_count:int

    public var int_pool:Array,
            uint_pool:Array,
            double_pool:Array,
            string_pool:Array,
            namespace_pool:Array,
            ns_set_pool:Array,
            multiname_pool:Array,
            method_info_pool:Array,
            metadata_pool:Array,
            instance_info_pool:Array,
            class_info_pool:Array,
            script_info_pool:Array,
            method_body_info_pool:Array

    public function ABC() {
        // a constructor would have too many arguments
    }

    public function initPools():void { // TODO: move this to the constructor and modify ABCReader to reflect this init
        int_pool = [0]
        uint_pool = [0]
        double_pool = [0.0]
        string_pool = [
            { toString: function ():String {
                return ''
            }}
        ]
        namespace_pool = [new ABCNamespace(ABC.PackageNamespace, '')]
        ns_set_pool = [
            [new ABCNamespace(ABC.PackageNamespace, '')]
        ]
        multiname_pool = [Multiname.Any]
        method_info_pool = []
        metadata_pool = []
        instance_info_pool = []
        class_info_pool = []
        script_info_pool = []
        method_body_info_pool = []
    }

    public static function readFrom(bytes:ByteArray):ABC {
        return new ABCReader(bytes).getABC()
    }

    public function toString():String {
        return '[ABC ' + abcname + ' (' + length + ' bytes, ' + method_body_info_pool.length + ' functions)]'
    }

    public function get inspect():String {
        return new ABCInspector(this).inspect
    }
}
}