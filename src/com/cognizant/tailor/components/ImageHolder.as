package com.cognizant.tailor.components
{
	import flash.events.Event;
	
	import spark.components.Group;
	import spark.components.Image;
	import spark.core.SpriteVisualElement;
	
	public class ImageHolder extends Group
	{
		private var _imageSource:Object;
		private var _image:Image = new Image();
		public var spriteContainer:SpriteVisualElement = new SpriteVisualElement();
		public function ImageHolder()
		{
			super();
			image.percentHeight = 100;
			image.percentWidth = 100;
			spriteContainer.height = height;
			spriteContainer.width = width; 
			addElement(image);
			addElement(spriteContainer); 
		}
		
		public function get image():Image
		{
			return _image;
		}
		
		public function set image(value:Image):void
		{
			_image = value;
		}
		
		public function get imageSource():Object
		{
			return _imageSource;
		}
		
		public function set imageSource(value:Object):void
		{
			_imageSource = value;
			image.source = value;
			if(image.imageDisplay){
				image.imageDisplay.addEventListener(Event.COMPLETE,imageChanged,false,0,true);
			}
		}
		
		private function imageChanged(ev:Event):void{
			uploadToWebService();
		}
		
		private function uploadToWebService():void{
			_image.smooth = true; 
		}
	}
}