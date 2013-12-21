package com.codeazur.as3abc.data.traits
{
	import com.codeazur.as3abc.ABCData;	
	
	public interface ITrait
	{
		function parse(data:ABCData):void;
		function parseMetadata(data:ABCData):void;
		function toString():String;		
	}
}