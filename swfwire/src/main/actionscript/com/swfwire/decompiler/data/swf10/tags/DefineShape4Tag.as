package com.swfwire.decompiler.data.swf10.tags
{
	import com.swfwire.decompiler.data.swf.records.RectangleRecord;
	import com.swfwire.decompiler.data.swf.records.ShapeWithStyleRecord;
	import com.swfwire.decompiler.data.swf.tags.SWFTag;
	
	public class DefineShape4Tag extends SWFTag
	{
		public var shapeId:uint;
		public var shapeBounds:RectangleRecord;
		public var edgeBounds:RectangleRecord;
		public var reserved:uint;
		public var usesFillWindingRule:Boolean;
		public var usesNonScalingStrokes:Boolean;
		public var usesScalingStrokes:Boolean;
		public var shapes:ShapeWithStyleRecord;

		public function DefineShape4Tag(shapeId:uint = 0, shapeBounds:RectangleRecord = null, edgeBounds:RectangleRecord = null, reserved:uint = 0, usesFillWindingRule:Boolean = false, usesNonScalingStrokes:Boolean = false, usesScalingStrokes:Boolean = false, shapes:ShapeWithStyleRecord = null)
		{
			if(shapeBounds == null)
			{
				shapeBounds = new RectangleRecord();
			}
			if(edgeBounds == null)
			{
				edgeBounds = new RectangleRecord();
			}
			if(shapes == null)
			{
				shapes = new ShapeWithStyleRecord();
			}

			this.shapeId = shapeId;
			this.shapeBounds = shapeBounds;
			this.edgeBounds = edgeBounds;
			this.reserved = reserved;
			this.usesFillWindingRule = usesFillWindingRule;
			this.usesNonScalingStrokes = usesNonScalingStrokes;
			this.usesScalingStrokes = usesScalingStrokes;
			this.shapes = shapes;
		}
	}
}