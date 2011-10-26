/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com

@internal 

*/
package com.cognizant.tailor.vo
{
	import flash.geom.Point;
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class ShapeObj
	{
		private var _shapeobjId:int;
		private var _name:String;
		private var _alpha:Number;
		private var _color:uint;
		private var _shapeType:String;
		private var _colorVal:ColorVal;
		private var closePoints:Boolean=true;
		private var _shapeArr:Array = []; 
		public function ShapeObj(alp:Number=1,col:uint=0)
		{
			alpha = alp;
			color = col;
			super();
		}
		
		public function get colorVal():ColorVal
		{
			return _colorVal;
		}
		
		public function set colorVal(value:ColorVal):void
		{
			_colorVal = value;
		}
		
		public function get shapeArr():Array
		{
			return _shapeArr;
		}
		
		public function set shapeArr(value:Array):void
		{
			_shapeArr = value;
		}
		
		public function get shapeType():String
		{
			return _shapeType;
		}
		
		public function set shapeType(value:String):void
		{
			_shapeType = value;
		}
		
		public function get color():uint
		{
			return _color;
		}
		
		public function set color(value:uint):void
		{
			_color = value;
		}
		
		public function get alpha():Number
		{
			return _alpha;
		}
		
		public function set alpha(value:Number):void
		{
			_alpha = value;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}
		
		public function get shapeobjId():int
		{
			return _shapeobjId;
		}
		
		public function set shapeobjId(value:int):void
		{
			_shapeobjId = value;
		}
		
		public function fill(item:Object):void{
			var firstPoint:Point;
			if(item is ArrayCollection){
				for each(var pointObj:Object in item){
					if(pointObj.hasOwnProperty('X')){
						var pt:Point = new Point(pointObj.X, pointObj.Y);
						if(shapeArr.length ==0) firstPoint = pt;
						shapeArr.push(pt);
					}
				}
			}else{
				if(item.hasOwnProperty('X')){
					var pt2:Point = new Point(item.X, item.Y);
					if(shapeArr.length ==0) firstPoint = pt2;
					shapeArr.push(pt2);
				}
			}
			if(firstPoint){ 
				if(closePoints){
					shapeArr.push(firstPoint);
				} 
			}
		}
	}
}