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
	import org.libspark.swfassist.swf.tags.AbstractTagVisitor;
	import org.libspark.swfassist.swf.structures.SWF;
	import flash.display.Sprite;
	import org.libspark.swfassist.flash.display.ShapeDrawer;
	import org.libspark.swfassist.swf.tags.Tag;
	import org.libspark.swfassist.swf.tags.Tags;
	import flash.utils.Dictionary;
	import org.libspark.swfassist.swf.tags.ShowFrame;
	import org.libspark.swfassist.swf.tags.DefineSprite;
	import org.libspark.swfassist.swf.tags.DefineShape;
	import org.libspark.swfassist.swf.tags.DefineShape2;
	import org.libspark.swfassist.swf.tags.DefineShape3;
	import org.libspark.swfassist.swf.tags.DefineShape4;
	import org.libspark.swfassist.swf.tags.DefineFont;
	import org.libspark.swfassist.swf.tags.DefineFont2;
	import org.libspark.swfassist.swf.tags.DefineFont3;
	import org.libspark.swfassist.swf.tags.DefineText;
	import org.libspark.swfassist.swf.tags.DefineText2;
	import org.libspark.swfassist.swf.tags.PlaceObject;
	import org.libspark.swfassist.swf.tags.PlaceObject2;
	import org.libspark.swfassist.swf.tags.PlaceObject3;
	import org.libspark.swfassist.swf.tags.RemoveObject;
	import org.libspark.swfassist.swf.tags.RemoveObject2;
	import org.libspark.swfassist.flash.display.FlashGraphics;
	import org.libspark.swfassist.swf.structures.TextRecord;
	import org.libspark.swfassist.swf.structures.GlyphEntry;
	import org.libspark.swfassist.swf.tags.DefineFontAlignZones;
	import org.libspark.swfassist.swf.structures.ZoneRecord;
	import org.libspark.swfassist.swf.structures.ZoneData;

	public class AnimationCollector extends AbstractTagVisitor
	{
		private var _isMaster:Boolean = true;
		private var _timeline:Timeline = new Timeline();
		private var _dictionary:Dictionary = new Dictionary();
		private var _fontInfo:Dictionary = new Dictionary();
		private var _sprites:Array = [];
		
		public function draw(dest:Sprite, drawer:ShapeDrawer, frame:uint):void
		{
			var container:NamedContainer = new NamedContainer();
			
			dest.addChild(container);
			
			for (var i:uint = 1; i <= frame; ++i) {
				internalDraw(container, drawer, i);
			}
		}
		
		public function drawFrame(dest:Sprite, drawer:ShapeDrawer, frame:uint):void
		{
			var container:NamedContainer = dest.numChildren > 0 ? dest.getChildAt(0) as NamedContainer : null;
			
			if (!container) {
				container = new NamedContainer();
				dest.addChild(container);
			}
			
			internalDraw(container, drawer, frame);
		}
		
		private function internalDraw(dest:NamedContainer, drawer:ShapeDrawer, frameNumber:uint):void
		{
			if (_isMaster) {
				for each (var sprite:AnimationSprite in _sprites) {
					drawAnimationSprite(sprite, drawer);
				}
			}
			
			var frame:Frame = _timeline.getFrame(frameNumber);
			
			if (!frame) {
				return;
			}
			
			for each (var tag:Tag in frame.tags) {
				if (tag is PlaceObject2 || tag is PlaceObject3) {
					drawPlaceObject2(PlaceObject2(tag), dest, drawer);
					continue;
				}
				if (tag is RemoveObject2) {
					drawRemoveObject2(RemoveObject2(tag), dest);
					continue;
				}
				if (tag is RemoveObject) {
					drawRemoveObject(RemoveObject(tag), dest);
					continue;
				}
			}
		}
		
		private function drawPlaceObject2(tag:PlaceObject2, dest:NamedContainer, drawer:ShapeDrawer):void
		{
			var isNewCharacter:Boolean = false;
			var character:NamedSprite;
			
			if (tag.hasCharacter) {
				character = getCharacter(tag.characterId, drawer);
				if (tag.isMove) {
					var removed:NamedSprite = removeObject(dest, tag.depth);
					if (removed) {
						character.transform = removed.transform;
					}
				}
				isNewCharacter = true;
			}
			else {
				if (tag.isMove) {
					character = dest.getChildByDepth(tag.depth);
				}
			}
			
			if (character) {
				character.depth = tag.depth;
				if (isNewCharacter) {
					if (character is AnimationSprite) {
						drawAnimationSprite(AnimationSprite(character), drawer);
						_sprites.push(character);
					}
					dest.addChild(character);
				}
				if (tag.hasMatrix) {
					character.transform.matrix = tag.matrix.toNativeMatrix();
					character.transform = character.transform;
				}
				/*
				if (tag.hasColorTransform) {
					character.transform.colorTransform = tag.colorTransform.toNativeColorTransform();
					character.transform = character.transform;
				}
				*/
			}
		}
		
		private function drawAnimationSprite(sprite:AnimationSprite, drawer:ShapeDrawer):void
		{
			if (sprite.numFrames == 1) {
				if (sprite.frameNumber != 0) {
					return;
				}
				sprite.frameNumber = 1;
			}
			else if (++sprite.frameNumber > sprite.numFrames) {
				sprite.frameNumber = 1;
				if (sprite.numChildren > 0) {
					removeAnimationSprites(Sprite(sprite.removeChildAt(0)));
				}
			}
			sprite.animation.drawFrame(sprite, drawer, sprite.frameNumber);
		}
		
		private function removeObject(container:NamedContainer, depth:uint):NamedSprite
		{
			var sprite:NamedSprite = container.removeChildByDepth(depth);
			
			if (sprite) {
				removeAnimationSprites(sprite);
			}
			
			return sprite;
		}
		
		private function removeAnimationSprites(sprite:Sprite):void
		{
			for (var i:uint = 0; i < sprite.numChildren; ++i) {
				removeAnimationSprites(Sprite(sprite.getChildAt(i)));
			}
			if (sprite is AnimationSprite) {
				removeAnimationSprite(AnimationSprite(sprite));
			}
		}
		
		private function removeAnimationSprite(sprite:AnimationSprite):void
		{
			var index:int = _sprites.indexOf(sprite);
			if (index >= 0) {
				_sprites.splice(index, 1);
			}
		}
		
		private function drawPlaceObject(tag:PlaceObject, dest:NamedContainer, drawer:ShapeDrawer):void
		{
			return;
		}
		
		private function drawRemoveObject2(tag:RemoveObject2, dest:NamedContainer):void
		{
			removeObject(dest, tag.depth);
		}
		
		private function drawRemoveObject(tag:RemoveObject, dest:NamedContainer):void
		{
			removeObject(dest, tag.depth);
		}
		
		private function getCharacter(id:uint, drawer:ShapeDrawer):NamedSprite
		{
			var tag:Object = _dictionary[id];
			
			if (tag) {
				if (tag is DefineShape) {
					return drawDefineShape(DefineShape(tag), drawer);
				}
				if (tag is DefineText) {
					return drawDefineText(DefineText(tag), drawer);
				}
				if (tag is Animation) {
					return new AnimationSprite(id, Animation(tag).collector, Animation(tag).tag.numFrames);
				}
			}
			
			return new NamedSprite(id);
		}
		
		private function drawDefineShape(tag:DefineShape, drawer:ShapeDrawer):NamedSprite
		{
			var sprite:NamedSprite = new NamedSprite(tag.shapeId);
			
			FlashGraphics(drawer.graphics).graphics = sprite.graphics;
			
			drawer.draw(tag.shapes);
			
			return sprite;
		}
		
		private function drawDefineText(tag:DefineText, drawer:ShapeDrawer):NamedSprite
		{
			var sprite:NamedSprite = new NamedSprite(tag.characterId);
			
			var text:Sprite = drawTextRecords(tag.textRecords, drawer);
			
			text.transform.matrix = tag.textMatrix.toNativeMatrix();
			text.transform = text.transform;
			
			sprite.addChild(text);
			
			return sprite;
		}
		
		private function drawTextRecords(records:Array, drawer:ShapeDrawer):Sprite
		{
			var sprite:Sprite = new Sprite();
			
			for each (var record:TextRecord in records) {
				drawTextRecord(record, sprite, drawer);
			}
			
			return sprite;
		}
		
		private function drawTextRecord(record:TextRecord, dest:Sprite, drawer:ShapeDrawer):void
		{
			if (record.hasFont) {
				var font:DefineFont = _dictionary[record.fontId];
				if (font) {
					/**
					var align:DefineFontAlignZones = _fontInfo[record.fontId];
					var zoneTable:Array = align ? align.zoneTable : null;
					/**/
					var glyphTable:Array = font.glyphShapeTable;
					var x:Number = record.hasXOffset ? record.xOffset / 20 : 0;
					var y:Number = record.hasYOffset ? record.yOffset / 20 : 0;
					for each (var entry:GlyphEntry in record.glyphEntries) {
						var index:uint = entry.glyphIndex;
						var glyphX:Number = x;
						var glyphY:Number = y;
						/**
						var glyphWidth:Number = 0;
						var glyphHeight:Number = 0;
						if (zoneTable) {
							var zone:ZoneRecord = zoneTable[index];
							if (zone.zoneMaskX) {
								glyphX += ZoneData(zone.zoneData[0]).alignmentCoordinate;
								glyphWidth = ZoneData(zone.zoneData[0]).range;
							}
							if (zone.zoneMaskY) {
								glyphY += ZoneData(zone.zoneData[1]).alignmentCoordinate;
								glyphHeight = ZoneData(zone.zoneData[1]).range;
							}
							trace(glyphX, glyphWidth, glyphY, glyphHeight);
						}
						/**/
						var glyph:Sprite = new Sprite();
						glyph.x = glyphX;
						glyph.y = glyphY;
						FlashGraphics(drawer.graphics).graphics = glyph.graphics;
						drawer.draw(glyphTable[index]);
						dest.addChild(glyph);
						/**
						x = glyphX + glyphWidth + entry.glyphAdvance / 20;
						/**/
						x += entry.glyphAdvance / 20;
					}
				}
			}
		}
		
		public override function visitDefineSprite(tag:DefineSprite):void
		{
			var collector:AnimationCollector = new AnimationCollector();
			collector._isMaster = false;
			collector._dictionary = _dictionary;
			collector._sprites = _sprites;
			tag.tags.visit(collector);
			var animation:Animation = new Animation();
			animation.tag = tag;
			animation.collector = collector;
			_dictionary[tag.spriteId] = animation;
		}
		
		public override function visitShowFrame(tag:ShowFrame):void
		{
			_timeline.newFrame();
		}
		
		public override function visitDefineShape(tag:DefineShape):void
		{
			_dictionary[tag.shapeId] = tag;
		}
		
		public override function visitDefineShape2(tag:DefineShape2):void
		{
			_dictionary[tag.shapeId] = tag;
		}
		
		public override function visitDefineShape3(tag:DefineShape3):void
		{
			_dictionary[tag.shapeId] = tag;
		}
		
		public override function visitDefineShape4(tag:DefineShape4):void
		{
			_dictionary[tag.shapeId] = tag;
		}
		
		public override function visitDefineFont(tag:DefineFont):void
		{
			_dictionary[tag.fontId] = tag;
		}
		
		public override function visitDefineFont2(tag:DefineFont2):void
		{
			_dictionary[tag.fontId] = tag;
		}
		
		public override function visitDefineFont3(tag:DefineFont3):void
		{
			_dictionary[tag.fontId] = tag;
		}
		
		public override function visitDefineFontAlignZones(tag:DefineFontAlignZones):void
		{
			_fontInfo[tag.fontId] = tag;
		}
		
		public override function visitDefineText(tag:DefineText):void
		{
			_dictionary[tag.characterId] = tag;
		}
		
		public override function visitDefineText2(tag:DefineText2):void
		{
			_dictionary[tag.characterId] = tag;
		}
		
		public override function visitPlaceObject(tag:PlaceObject):void
		{
			_timeline.currentFrame.addTag(tag);
		}
		
		public override function visitPlaceObject2(tag:PlaceObject2):void
		{
			_timeline.currentFrame.addTag(tag);
		}
		
		public override function visitPlaceObject3(tag:PlaceObject3):void
		{
			_timeline.currentFrame.addTag(tag);
		}
		
		public override function visitRemoveObject(tag:RemoveObject):void
		{
			_timeline.currentFrame.addTag(tag);
		}
		
		public override function visitRemoveObject2(tag:RemoveObject2):void
		{
			_timeline.currentFrame.addTag(tag);
		}
	}
}

import org.libspark.swfassist.swf.tags.Tag;
import flash.display.Sprite;
import flash.display.DisplayObject;
import org.libspark.swfassist.inprogress.swf.AnimationCollector;
import org.libspark.swfassist.swf.tags.DefineSprite;
	

class Timeline
{
	public function Timeline()
	{
		newFrame();
	}
	
	private var _frames:Array = [];
	private var _current:Frame;
	
	public function get currentFrame():Frame
	{
		return _current;
	}
	
	public function newFrame():void
	{
		_current = new Frame();
		_frames.push(_current);
	}
	
	public function getFrame(frame:uint):Frame
	{
		if (frame > _frames.length) {
			return null;
		}
		return _frames[frame - 1];
	}
}

class Frame
{
	public var tags:Array = [];
	
	public function addTag(tag:Tag):void
	{
		tags.push(tag);
	}
}

class NamedSprite extends Sprite
{
	public function NamedSprite(id:uint = 0)
	{
		this.id = id;
	}
	
	public var id:uint;
	public var depth:uint;
}

class NamedContainer extends Sprite
{
	public override function addChild(child:DisplayObject):DisplayObject
	{
		if (child is NamedSprite) {
			var depth:uint = NamedSprite(child).depth;
			
			for (var i:uint = 0; i < numChildren; ++i) {
				var c:NamedSprite = getChildAt(i) as NamedSprite;
				if (c && c.depth < depth) {
					return addChildAt(child, getChildIndex(c) + 1);
				}
			}
		}
		
		return super.addChild(child);
	}
	
	public function getChildByDepth(depth:uint):NamedSprite
	{
		for (var i:uint = 0; i < numChildren; ++i) {
			var c:NamedSprite = getChildAt(i) as NamedSprite;
			if (c && c.depth == depth) {
				return c;
			}
		}
		return null;
	}
	
	public function removeChildByDepth(depth:uint):NamedSprite
	{
		for (var i:uint = 0; i < numChildren; ++i) {
			var c:NamedSprite = getChildAt(i) as NamedSprite;
			if (c && c.depth == depth) {
				removeChild(c);
				return c;
			}
		}
		return null;
	}
}

class Animation
{
	public var tag:DefineSprite;
	public var collector:AnimationCollector;
}

class AnimationSprite extends NamedSprite
{
	public function AnimationSprite(id:uint, animation:AnimationCollector, numFrames:uint)
	{
		super(id);
		
		this.animation = animation;
		this.numFrames = numFrames;
	}
	
	public var frameNumber:uint = 0;
	public var numFrames:uint = 0;
	public var animation:AnimationCollector;
}