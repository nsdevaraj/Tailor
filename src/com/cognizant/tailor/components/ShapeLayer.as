package com.cognizant.tailor.components
{
	import com.cognizant.tailor.util.CubicBezier;
	import com.cognizant.tailor.util.FaceDot;
	import com.cognizant.tailor.vo.ShapeObj;
	
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	
	public class ShapeLayer extends Sprite implements ILayer
	{
		private var _currentShape:ShapeObj;
		private var _activeShape:Boolean = false; 
		private var _coloredShape:Boolean = false; 
		public var shapeServiceArray:Array = [];
		private var _alphaDefaultValue:Number =0.8;
		
		protected var blurAmt:int=30;
		protected var _color:uint=999999;
		protected var _alphaValue:Number=0.8;
		protected var prevBlendMode:String; 
		protected var _shapeArr:Array;
		protected var shapeEditArray:Array = [];
		protected var spriteContainer:Sprite;
		protected var shapeTaskClip:MovieClip;
		protected var adjustTaskClip:MovieClip= new MovieClip();
		protected var shapeMask:Sprite = new Sprite();
		protected var filtersArray:Array = [];
		protected var blur_filter:BlurFilter;
		
		public function ShapeLayer()
		{
			super();
			setBlurFilter(blurAmt);
			addEventListener(Event.ADDED_TO_STAGE,addedtoStage, false, 0, true);
		}
		
		public function get coloredShape():Boolean
		{
			return _coloredShape;
		}
		
		public function set coloredShape(value:Boolean):void
		{
			_coloredShape = value;
		}
		
		public function get alphaDefaultValue():Number
		{
			return _alphaDefaultValue;
		}
		
		public function set alphaDefaultValue(value:Number):void
		{
			_alphaDefaultValue = value;
		}
		
		public function get shapeArr():Array
		{
			return _shapeArr;
		}
		
		public function set shapeArr(value:Array):void
		{
			_shapeArr = value;
		}
		
		public function get alphaValue():Number
		{
			return _alphaValue;
		}
		
		public function set alphaValue(value:Number):void
		{
			_alphaValue = value;
			if(currentShape)currentShape.alpha = value;
		}
		
		public function get color():uint
		{
			return _color;
		}
		
		public function set color(value:uint):void
		{
			_color = value;
			if(activeShape && currentShape)currentShape.color = value;
		}
		
		public function get currentShape():ShapeObj
		{
			return _currentShape;
		}
		
		public function set currentShape(value:ShapeObj):void
		{
			_currentShape = value;
			if(!shapeArr){
				shapeArr = _currentShape.shapeArr;
				shapeServiceArray = _currentShape.shapeArr.concat();
			}else{
				_alphaValue = value.alpha;
				_color = value.color;
				_shapeArr = value.shapeArr;
				drawShape();
			}
		}
		
		public function setBlurFilter(val:int):void
		{
			blurAmt = val;
			blur_filter=new BlurFilter(blurAmt,blurAmt);
			filtersArray=[];
			filtersArray.push(blur_filter);
		}
		public function get activeShape():Boolean
		{
			return _activeShape;
		}
		
		public function set activeShape(value:Boolean):void
		{
			_activeShape = value;
		}
		
		protected function addedtoStage(ev:Event):void{
			spriteContainer = parent as Sprite; 
			spriteContainer.addChild(shapeMask);
			spriteContainer.addChild(adjustTaskClip);
		}
		
		protected function removeAllClips(spr:Sprite):void
		{
			while (spr.numChildren>0)
			{
				spr.removeChildAt(0);
			}
		}
		
		public function drawShape():void
		{
			if(activeShape){
				shapeMask.filters=filtersArray;
				removeAllClips(shapeMask);
				shapeTaskClip = new MovieClip();
				fillShapeBlend();
				prevBlendMode = shapeMask.blendMode;
				shapeMask.addChild(shapeTaskClip);
				currentShape.alpha = alphaValue;
				currentShape.color = color;
				drawCurves();
			}
		}
		
		protected function fillShapeBlend():void{
			shapeTaskClip.graphics.beginFill(color,alphaValue);
			CubicBezier.curveThroughPoints(shapeTaskClip.graphics,shapeArr,.5,1);
			shapeTaskClip.graphics.endFill();
			shapeMask.blendMode=BlendMode.MULTIPLY;
			coloredShape =true;
		}
		
		public function resetPointArray():void
		{ 
			shapeArr = shapeServiceArray.concat();
			showAdjustArea();
			drawShape();
		}
		
		public function clearPointArray(bool:Boolean=false):void
		{
			if(activeShape||bool){
				if (shapeEditArray!=null)
				{
					for (var c:uint=0; c<shapeEditArray.length; )
					{
						var dotPoint:FaceDot=shapeEditArray[c];
						dotPoint.removeEventListener(MouseEvent.MOUSE_DOWN, dragEventHandler);
						dotPoint.removeEventListener(MouseEvent.MOUSE_UP, dragEventHandler);
						dotPoint.removeEventListener(MouseEvent.MOUSE_MOVE, dragEventHandler);
						if(spriteContainer)spriteContainer.removeChild(dotPoint);
						shapeEditArray.splice(c,1);
					}
					if(adjustTaskClip)adjustTaskClip.graphics.clear();
					shapeEditArray.length=0;
					shapeEditArray=null;
					shapeEditArray = new Array();
				}
			}
		}
		
		public function clearColors(bool:Boolean=false):void
		{
			if(activeShape||bool){
				coloredShape =false;
				if(shapeTaskClip)shapeTaskClip.graphics.clear();
				if(adjustTaskClip)adjustTaskClip.graphics.clear();
			}
		}
		
		public function showAdjustArea():void
		{
			if(activeShape){
				clearPointArray();
				drawLines(shapeArr);
				drawPoints(shapeArr,dragEventHandler);
			}
		}
		
		protected function drawPoints(arr:Array,dragFunc:Function):void
		{
			if (arr.length>0)
			{
				for (var i:uint = 0; i < arr.length; i++)
				{
					var dotPoint:FaceDot = new FaceDot();
					dotPoint.x=arr[i].x;
					dotPoint.y=arr[i].y;
					dotPoint.ID=i;
					if(spriteContainer)spriteContainer.addChild(dotPoint);
					dotPoint.buttonMode=true;
					if (i>0)
					{
						dotPoint.addEventListener(MouseEvent.MOUSE_DOWN, dragFunc, false, 0, true);
						dotPoint.addEventListener(MouseEvent.MOUSE_MOVE, dragFunc, false, 0, true);
						dotPoint.addEventListener(MouseEvent.MOUSE_UP, dragFunc, false, 0, true);
					}
					else
					{
						dotPoint.visible=false;
					}
					shapeEditArray.push(dotPoint);
				}
			}
		}
		
		protected function drawLines(arr:Array):void
		{
			adjustTaskClip.graphics.clear();
			adjustTaskClip.graphics.lineStyle(1,0xFFFFFF,1);
			CubicBezier.curveThroughPoints(adjustTaskClip.graphics,arr,.5,1);
		}
		
		protected function dragEventHandler(event:MouseEvent):void
		{
			var id:uint=event.currentTarget.ID;
			var moving:Boolean=true;
			switch (event.type)
			{
				case MouseEvent.MOUSE_DOWN :
					event.currentTarget.startDrag();
					break;
				case MouseEvent.MOUSE_UP :
					event.currentTarget.stopDrag();
					moving =false;
					break; 
			}
			updateCurve(id);
			if(event.type != MouseEvent.MOUSE_MOVE){
				drawShape();
			}
		}
		
		protected function updateCurve(id:uint):void
		{
			var dotPoint:FaceDot=shapeEditArray[id];
			var point:Point=new Point(dotPoint.x,dotPoint.y);
			shapeArr[id]=point;
			if(id == shapeArr.length-1)
			{
				var lastDot:FaceDot = shapeEditArray[0];
				lastDot.visible = false;
				lastDot.x = dotPoint.x;
				lastDot.y = dotPoint.y;
				var lastPoint:Point=new Point(lastDot.x,lastDot.y);
				shapeArr[0] = lastPoint;
			}
			drawCurves();
			drawLines(shapeArr);
		}
		
		protected function drawCurves():void
		{
			graphics.clear();
			graphics.beginFill(0xff00ff,1);
			CubicBezier.curveThroughPoints(graphics,shapeArr,.5,1);
			graphics.endFill();
			shapeMask.mask=this;
		}
	}
}