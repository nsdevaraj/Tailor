/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com

@internal 

*/
package com.cognizant.tailor.vo
{ 
	import com.cognizant.tailor.components.ILayer;

	[Bindable]
	public class ColorVal
	{
		private var _colorvalId:int; 
		private var _name:String='';
		private var _cartId:int;
		private var _price:String;
		private var _color:uint=0;
		private var _categoryId:int;
 		private var _brandName:String='';
		private var _faceType:String;
		private var _catFaceType:String;
		private var _alphaRetrieve:Number=1;
		private var _modCatFaceType:String;
		private var _makeupImg:String;
		private var _mrp:String;
		public var selectedCart:Boolean;
		public var drawnoverLayer:ILayer;
		public function ColorVal()
		{
			super();
		} 

		public function get makeupImg():String
		{
			return _makeupImg;
		}

		public function set makeupImg(value:String):void
		{
			_makeupImg = value;
		}

		public function get mrp():String
		{
			return _mrp;
		}

		public function set mrp(value:String):void
		{
			_mrp = value;
		}

		public function get alphaRetrieve():Number
		{
			return _alphaRetrieve;
		}

		public function set alphaRetrieve(value:Number):void
		{
			_alphaRetrieve = value;
		}

		public function get modCatFaceType():String
		{
			return faceType+catFaceType;
		}

		public function get catFaceType():String
		{
			return _catFaceType;
		}

		public function set catFaceType(value:String):void
		{
			_catFaceType = value;
		}

		public function get faceType():String
		{
			return _faceType;
		}

		public function set faceType(value:String):void
		{
			_faceType = value;
		}

		public function get brandName():String
		{
			return _brandName;
		}

		public function set brandName(value:String):void
		{
			_brandName = value;
		}

		public function get categoryId():int
		{
			return _categoryId;
		}

		public function set categoryId(value:int):void
		{
			_categoryId = value;
		}

		public function get color():uint
		{
			return _color;
		}

		public function set color(value:uint):void
		{
			_color = value;
		}

		public function get price():String
		{
			return _price;
		}

		public function set price(value:String):void
		{
			_price = value;
		}

		public function get cartId():int
		{
			return _cartId;
		}

		public function set cartId(value:int):void
		{
			_cartId = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get colorvalId():int
		{
			return _colorvalId;
		}

		public function set colorvalId(value:int):void
		{
			_colorvalId = value;
		}  
	}
}