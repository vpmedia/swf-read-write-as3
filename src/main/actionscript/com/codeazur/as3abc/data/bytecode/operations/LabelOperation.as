package com.codeazur.as3abc.data.bytecode.operations
{
	import com.codeazur.as3abc.ABCData;
	
	public class LabelOperation extends AbstractOperation
	{
		public function LabelOperation(code:int)
		{
			super(code);
		}

		override public function readOperands(bytes:ABCData):void
		{
			block.markers.putMarkerAt(position);
		}
	}
}