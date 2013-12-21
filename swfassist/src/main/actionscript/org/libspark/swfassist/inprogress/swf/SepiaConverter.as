/*
 * Copyright(c) 2007 the Spark project.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
 * either express or implied. See the License for the specific language
 * governing permissions and limitations under the License.
 */

package org.libspark.swfassist.inprogress.swf
{
	import org.libspark.swfassist.swf.structures.CXForm;
	import org.libspark.swfassist.swf.structures.FillStyle;
	import org.libspark.swfassist.swf.structures.FillStyleArray;
	import org.libspark.swfassist.swf.structures.FillStyleTypeConstants;
	import org.libspark.swfassist.swf.structures.Gradient;
	import org.libspark.swfassist.swf.structures.GradientRecord;
	import org.libspark.swfassist.swf.structures.LineStyle;
	import org.libspark.swfassist.swf.structures.LineStyle2;
	import org.libspark.swfassist.swf.structures.LineStyleArray;
	import org.libspark.swfassist.swf.structures.MorphFillStyle;
	import org.libspark.swfassist.swf.structures.MorphFillStyleArray;
	import org.libspark.swfassist.swf.structures.MorphGradient;
	import org.libspark.swfassist.swf.structures.MorphGradientRecord;
	import org.libspark.swfassist.swf.structures.MorphLineStyle;
	import org.libspark.swfassist.swf.structures.MorphLineStyle2;
	import org.libspark.swfassist.swf.structures.MorphLineStyles;
	import org.libspark.swfassist.swf.structures.RGB;
	import org.libspark.swfassist.swf.structures.ShapeRecord;
	import org.libspark.swfassist.swf.structures.ShapeWithStyle;
	import org.libspark.swfassist.swf.structures.StyleChangeRecord;
	import org.libspark.swfassist.swf.structures.TextRecord;
	import org.libspark.swfassist.swf.tags.AbstractTagVisitor;
	import org.libspark.swfassist.swf.tags.DefineEditText;
	import org.libspark.swfassist.swf.tags.DefineShape;
	import org.libspark.swfassist.swf.tags.DefineShape2;
	import org.libspark.swfassist.swf.tags.DefineShape3;
	import org.libspark.swfassist.swf.tags.DefineShape4;
	import org.libspark.swfassist.swf.tags.DefineSprite;
	import org.libspark.swfassist.swf.tags.DefineText;
	import org.libspark.swfassist.swf.tags.DefineText2;
	import org.libspark.swfassist.swf.tags.PlaceObject2;
	import org.libspark.swfassist.swf.tags.PlaceObject3;
	import org.libspark.swfassist.swf.tags.SetBackgroundColor;

	public class SepiaConverter extends AbstractTagVisitor
	{
		private static const R_FACTOR:uint = uint(0.298912 * 1024);
		private static const G_FACTOR:uint = uint(0.586611 * 1024);
		private static const B_FACTOR:uint = uint(0.114478 * 1024);
		private static const YR_FACTOR:Number = 240 / 255;
		private static const YG_FACTOR:Number = 200 / 255;
		private static const YB_FACTOR:Number = 145 / 255;
		
		private function convertRGB(rgb:RGB):void
		{
			/**/
			var y:uint = (rgb.red * R_FACTOR + rgb.green * G_FACTOR + rgb.blue * B_FACTOR) >> 10;
			
			rgb.red = y * YR_FACTOR;
			rgb.green = y * YG_FACTOR;
			rgb.blue = y * YB_FACTOR; 
			/**
			rgb.red = 0xff - rgb.red;
			rgb.green = 0xff - rgb.green;
			rgb.blue = 0xff - rgb.blue;
			/**/
		}
		
		private function convertCXForm(form:CXForm):void
		{
			if (form.hasAddition) {
				/**/
				var y:uint = (form.redAddition * R_FACTOR + form.greenAddition * G_FACTOR + form.blueAddition * B_FACTOR) >> 10;
				
				form.redAddition = y * YR_FACTOR;
				form.greenAddition = y * YG_FACTOR;
				form.blueAddition = y * YB_FACTOR;
				/**/
			}
		}
		
		public override function visitPlaceObject2(tag:PlaceObject2):void
		{
			if (tag.hasColorTransform) {
				convertCXForm(tag.colorTransform);
			}
		}
		
		public override function visitPlaceObject3(tag:PlaceObject3):void
		{
			visitPlaceObject2(tag);
		}
		
		public override function visitSetBackgroundColor(tag:SetBackgroundColor):void
		{
			convertRGB(tag.backgroundColor);
		}
		
		private function visitFillStyleArray(list:FillStyleArray):void
		{
			for each (var style:FillStyle in list.fillStyles) {
				visitFillStyle(style);
			}
		}
		
		private function visitFillStyle(style:FillStyle):void
		{
			if (style.fillStyleType == FillStyleTypeConstants.SOLID_FILL) {
				convertRGB(style.color);
			}
			if (style.fillStyleType == FillStyleTypeConstants.LINEAR_GRADIENT_FILL ||
			    style.fillStyleType == FillStyleTypeConstants.RADIAL_GRADIENT_FILL) {
				visitGradient(style.gradient);
			}
		}
		
		private function visitLineStyleArray(list:LineStyleArray):void
		{
			for each (var style:LineStyle in list.lineStyles) {
				if (style is LineStyle2) {
					visitLineStyle2(LineStyle2(style));
				}
				else {
					visitLineStyle(style);
				}
			}
		}
		
		private function visitLineStyle(style:LineStyle):void
		{
			convertRGB(style.color);
		}
		
		private function visitLineStyle2(style:LineStyle2):void
		{
			if (!style.hasFill) {
				convertRGB(style.color);
			}
			else {
				visitFillStyle(style.fillType);
			}
		}
		
		private function visitShapeWithStyle(shape:ShapeWithStyle):void
		{
			visitFillStyleArray(shape.fillStyles);
			visitLineStyleArray(shape.lineStyles);
			
			for each (var record:ShapeRecord in shape.shapeRecords) {
				if (record is StyleChangeRecord) {
					var st:StyleChangeRecord = StyleChangeRecord(record);
					if (st.stateNewStyles) {
						visitFillStyleArray(st.fillStyles);
						visitLineStyleArray(st.lineStyles);
					}
				}
			}
		}
		
		public override function visitDefineShape(tag:DefineShape):void
		{
			visitShapeWithStyle(tag.shapes);
		}
		
		public override function visitDefineShape2(tag:DefineShape2):void
		{
			visitShapeWithStyle(tag.shapes);
		}
		
		public override function visitDefineShape3(tag:DefineShape3):void
		{
			visitShapeWithStyle(tag.shapes);
		}
		
		public override function visitDefineShape4(tag:DefineShape4):void
		{
			visitShapeWithStyle(tag.shapes);
		}
		
		private function visitGradient(gradient:Gradient):void
		{
			for each (var record:GradientRecord in gradient.gradientRecords) {
				visitGradientRecord(record);
			}
		}
		
		private function visitGradientRecord(record:GradientRecord):void
		{
			convertRGB(record.color);
		}
		
		private function visitMorphFillStyleArray(list:MorphFillStyleArray):void
		{
			for each (var style:MorphFillStyle in list.fillStyles) {
				visitMorphFillStyle(style);
			}
		}
		
		private function visitMorphFillStyle(style:MorphFillStyle):void
		{
			if (style.fillStyleType == FillStyleTypeConstants.SOLID_FILL) {
				convertRGB(style.startColor);
				convertRGB(style.endColor);
			}
			if (style.fillStyleType == FillStyleTypeConstants.LINEAR_GRADIENT_FILL ||
			    style.fillStyleType == FillStyleTypeConstants.RADIAL_GRADIENT_FILL) {
				visitMorphGradient(style.gradient);
			}
		}
		
		private function visitMorphGradient(gradient:MorphGradient):void
		{
			for each (var record:MorphGradientRecord in gradient.gradientRecords) {
				visitMorphGradientRecord(record);
			}
		}
		
		private function visitMorphGradientRecord(gradient:MorphGradientRecord):void
		{
			convertRGB(gradient.startColor);
			convertRGB(gradient.endColor);
		}
		
		private function visitMorphLineStyles(list:MorphLineStyles):void
		{
			for each (var style:MorphLineStyle in list.lineStyles) {
				if (style is MorphLineStyle2) {
					visitMorphLineStyle2(MorphLineStyle2(style));
				}
				else {
					visitMorphLineStyle(style);
				}
			}
		}
		
		private function visitMorphLineStyle(style:MorphLineStyle):void
		{
			convertRGB(style.startColor);
			convertRGB(style.endColor);
		}
		
		private function visitMorphLineStyle2(style:MorphLineStyle2):void
		{
			if (!style.hasFill) {
				convertRGB(style.startColor);
				convertRGB(style.endColor);
			}
			else {
				visitMorphFillStyle(style.fillType);
			}
		}
		
		public override function visitDefineText(tag:DefineText):void
		{
			for each (var record:TextRecord in tag.textRecords) {
				visitTextRecord(record);
			}
		}
		
		private function visitTextRecord(record:TextRecord):void
		{
			if (record.hasColor) {
				convertRGB(record.textColor);
			}
		}
		
		public override function visitDefineText2(tag:DefineText2):void
		{
			visitDefineText(tag);
		}
		
		public override function visitDefineEditText(tag:DefineEditText):void
		{
			if (tag.hasTextColor) {
				convertRGB(tag.textColor);
			}
		}
		
		public override function visitDefineSprite(tag:DefineSprite):void
		{
			tag.tags.visit(this);
		}
	}
}