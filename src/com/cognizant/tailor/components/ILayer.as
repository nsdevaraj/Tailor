package com.cognizant.tailor.components
{
	import com.cognizant.tailor.vo.ShapeObj;

	public interface ILayer
	{
		function get activeShape():Boolean
		function set activeShape(value:Boolean):void
		function get coloredShape():Boolean
		function set coloredShape(value:Boolean):void
		function get currentShape():ShapeObj
		function set currentShape(value:ShapeObj):void
		function get alphaValue():Number
		function set alphaValue(value:Number):void
		function get alphaDefaultValue():Number
		function set alphaDefaultValue(value:Number):void
		function clearColors(bool:Boolean=false):void
		function clearPointArray(bool:Boolean=false):void
	}
}