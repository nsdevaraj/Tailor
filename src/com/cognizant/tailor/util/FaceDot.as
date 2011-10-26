package com.cognizant.tailor.util
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	
	public class FaceDot extends MovieClip
	{
		public var ID:int;
		private var circle:Shape= new Shape();
		public function FaceDot()
		{
			super(); 
			var circleSize:uint = 5;
			circle.graphics.beginFill(0x000000, 1);
			circle.graphics.drawEllipse(-2.5, -2.5, circleSize, circleSize);
			circle.graphics.endFill(); 
			this.addChild(circle); 
		}
		
	}
}