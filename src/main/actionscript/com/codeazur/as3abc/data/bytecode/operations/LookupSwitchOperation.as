package com.codeazur.as3abc.data.bytecode.operations
{
	import __AS3__.vec.Vector;
	
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.bytecode.Marker;
	import com.codeazur.as3abc.data.bytecode.MarkerManager;
	
	public class LookupSwitchOperation extends AbstractOperation
	{
		public var defaultMarker:Marker;
		public var caseMarkers:Vector.<Marker>;
		
		public function LookupSwitchOperation(code:int)
		{
			super(code);
		}
		
		override public function readOperands(bytes:ABCData):void
		{
			var markers:MarkerManager = block.markers;
			var i:int, count:int;
					
			defaultMarker = markers.putMarkerAt(position + bytes.readS24());
					
			count = bytes.readU30() + 1;		
			caseMarkers = new Vector.<Marker>(count, true);

			for (i = 0; i < count; ++i) {
				caseMarkers[i] = markers.putMarkerAt(position + bytes.readS24());
			}
		}

	}
}