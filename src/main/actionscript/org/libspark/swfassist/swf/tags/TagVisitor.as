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

package org.libspark.swfassist.swf.tags
{
	public interface TagVisitor
	{
		function visitUnknwon(tag:Unknown):void;
		function visitPlaceObject(tag:PlaceObject):void;
		function visitPlaceObject2(tag:PlaceObject2):void;
		function visitPlaceObject3(tag:PlaceObject3):void;
		function visitRemoveObject(tag:RemoveObject):void;
		function visitRemoveObject2(tag:RemoveObject2):void;
		function visitShowFrame(tag:ShowFrame):void;
		function visitSetBackgroundColor(tag:SetBackgroundColor):void;
		function visitFrameLabel(tag:FrameLabel):void;
		function visitProtect(tag:Protect):void;
		function visitEnd(tag:End):void;
		function visitExportAssets(tag:ExportAssets):void;
		function visitImportAssets(tag:ImportAssets):void;
		function visitEnableDebugger(tag:EnableDebugger):void;
		function visitEnableDebugger2(tag:EnableDebugger2):void;
		function visitScriptLimits(tag:ScriptLimits):void;
		function visitSetTabIndex(tag:SetTabIndex):void;
		function visitFileAttributes(tag:FileAttributes):void;
		function visitImportAssets2(tag:ImportAssets2):void;
		function visitSymbolClass(tag:SymbolClass):void;
		function visitMetadata(tag:Metadata):void;
		function visitDefineScalingGrid(tag:DefineScalingGrid):void;
		function visitDefineSceneAndFrameLabelData(tag:DefineSceneAndFrameLabelData):void;
		function visitDoAction(tag:DoAction):void;
		function visitDoInitAction(tag:DoInitAction):void;
		function visitDoABC(tag:DoABC):void;
		function visitDefineShape(tag:DefineShape):void;
		function visitDefineShape2(tag:DefineShape2):void;
		function visitDefineShape3(tag:DefineShape3):void;
		function visitDefineShape4(tag:DefineShape4):void;
		function visitDefineBits(tag:DefineBits):void;
		function visitJPEGTables(tag:JPEGTables):void;
		function visitDefineBitsJPEG2(tag:DefineBitsJPEG2):void;
		function visitDefineBitsJPEG3(tag:DefineBitsJPEG3):void;
		function visitDefineBitsLossless(tag:DefineBitsLossless):void;
		function visitDefineBitsLossless2(tag:DefineBitsLossless2):void;
		function visitDefineMorphShape(tag:DefineMorphShape):void;
		function visitDefineMorphShape2(tag:DefineMorphShape2):void;
		function visitDefineFont(tag:DefineFont):void;
		function visitDefineFontInfo(tag:DefineFontInfo):void;
		function visitDefineFontInfo2(tag:DefineFontInfo2):void;
		function visitDefineFont2(tag:DefineFont2):void;
		function visitDefineFont3(tag:DefineFont3):void;
		function visitDefineFontAlignZones(tag:DefineFontAlignZones):void;
		function visitDefineFontName(tag:DefineFontName):void;
		function visitDefineText(tag:DefineText):void;
		function visitDefineText2(tag:DefineText2):void;
		function visitDefineEditText(tag:DefineEditText):void;
		function visitCSMTextSettings(tag:CSMTextSettings):void;
		function visitDefineSound(tag:DefineSound):void;
		function visitStartSound(tag:StartSound):void;
		function visitStartSound2(tag:StartSound2):void;
		function visitSoundStreamHead(tag:SoundStreamHead):void;
		function visitSoundStreamHead2(tag:SoundStreamHead2):void;
		function visitSoundStreamBlock(tag:SoundStreamBlock):void;
		function visitDefineButton(tag:DefineButton):void;
		function visitDefineButton2(tag:DefineButton2):void;
		function visitDefineButtonCxform(tag:DefineButtonCxform):void;
		function visitDefineButtonSound(tag:DefineButtonSound):void;
		function visitDefineSprite(tag:DefineSprite):void;
		function visitDefineVideoStream(tag:DefineVideoStream):void;
		function visitVideoFrame(tag:VideoFrame):void;
		function visitDefineBinaryData(tag:DefineBinaryData):void;
	}
}