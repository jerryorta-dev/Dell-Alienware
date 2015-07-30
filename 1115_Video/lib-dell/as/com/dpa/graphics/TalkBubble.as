﻿/** * Created with IntelliJ IDEA. * User: Jerry Orta * http://www.digitalproductionart.com/ * jerryorta@gmail.com * * Date: 10/29/12 * Time: 2:35 PM**//**import com.greensock.*;import com.greensock.easing.*;//Schwab Bubbleimport com.schwab.graphics.*;*  rectWidth:value		//Rectangle width of bubble*  rectHEIGHT:value		//Rectangle height of bubble*  pointWIDTH:value		//Point width of bubble*  pointHEIGHT:value	//Point height of bubble*  pointX				//pointX position of bubble point from left margin of rectangle*  radiusRECT			//Radius of the rectangular corner points*  radiusPOINT			//Radius of the bubble point corner points*  bubbleCOLOR			//Color fill of bubble, can be "0x009900" OR 0x009900 -- no string*  fillALPHA			//Alpha of color fill*  borderCOLOR			//Color of border*  borderWEIGHT			//Weight of border*  borderALPHA			//Alpha of border*  pointRIGHT			//Bubble points left -- true or falsevar bubble:Bubble = new Bubble({			rectWidth:200, 			rectHEIGHT:100, 			pointWIDTH:75, 			pointHEIGHT:100, 			pointX:75, 			radiusRECT:20, 			radiusPOINT:15, 			bubbleCOLOR:"0x009900", 			fillALPHA:1, 			borderCOLOR:"0x990000",			borderWEIGHT:2,			borderALPHA:1,			pointRIGHT:false,			translatePointTo:50});addChild(bubble);bubble.x = 20;bubble.y = 20;var bubble2:Bubble = new Bubble();addChild(bubble2);bubble2.x = 230;bubble2.y = 90;//bubble2.rectWidth = 200;//bubble2.pointRIGHT = false; TweenLite.to(bubble2, 4, {delay:2, x:"-100", rectWidth:"+100", radiusRECT:"+50", ease:Linear.easeNone});alignPointLeft get the value of the left base numberalignPointLeft get the value of the right base number*/package com.dpa.graphics {    import com.dpa.graphics.core.RoundPathHelper;    import flash.display.Sprite;    import flash.geom.Point;    public class TalkBubble extends Sprite {		public var vars:Object; 		private var spContainer:Sprite;		//private var points:Vector.<Point>;		//private var radii:Vector.<Number>;				private var points:Array;		private var radii:Array;						//Points of bubble		private var _rectWidth:Number;		//Width of rectangle		private var _rectHeight:Number;		//Height of rectangle		private var _pointWidth:Number;		//Width of Bubble point		private var _pointHeight:Number;		//Height of bubble point		private var _pointX:Number;			//Distance bubble point is from left bubble margin		private var _radiusRect:Number;		//Radius of the rectangle corners		private var _radiusPoint:Number;		//Radius of the point corners        private var _radiusLeftOfPoint:Number;        private var _radiusRightOfPoint:Number;				private var _fillColor:uint;		//Color fill of bubble		private var _fillAlpha:Number;		//Alpha of fill color		private var _borderColor:Number;		//Color of border		private var _borderWeight:Number;	//Weight of border		private var _borderAlpha:Number;		//Alpha of border		private var _pointIsRight:Boolean;	//Bubble points to left				private var _setWidth:Number;        private var _setHeight:Number;				private var _translatePointTo:Number;				private var _alignPointer:Boolean = false;				//Rounded corner Vectors		public function TalkBubble(vars:Object = null) {					this.vars = (vars != null) ? vars : {};						_rectWidth = (this.vars.width != null) ? this.vars.width : 351;			_rectHeight = (this.vars.height != null) ? this.vars.height : 32;			_pointWidth = (this.vars.pointWidth != null) ? this.vars.pointWidth : 7;			_pointHeight = (this.vars.pointHeight != null) ? this.vars.pointHeight : 9;			_pointX = (this.vars.pointX != null) ? this.vars.pointX : 17;			_radiusRect = (this.vars.radiusRect != null) ? this.vars.radiusRect : 12.3;            _radiusLeftOfPoint = (this.vars.radiusLeftOfPoint != null) ? this.vars.radiusLeftOfPoint : 0;            _radiusPoint = (this.vars.radiusPoint != null) ? this.vars.radiusPoint : 1;            _radiusRightOfPoint = (this.vars.radiusRightOfPoint != null) ? this.vars.radiusRightOfPoint : 0;			_fillColor = (this.vars.fillColor != null) ? this.vars.fillColor : 0xFFFFFF;			_fillAlpha = (this.vars.fillAlpha != null) ? this.vars.fillAlpha : 0;			_borderColor = (this.vars.borderColor != null) ? this.vars.borderColor : 0xFF0000;			_borderWeight = (this.vars.borderWeight != null) ? this.vars.borderWeight : 1;			_borderAlpha = (this.vars.borderAlpha != null) ? this.vars.borderAlpha : 1;			_pointIsRight = (this.vars.pointRight != null) ? this.vars.pointRight : false;			_translatePointTo = (this.vars.translatePointTo != null) ? this.vars.translatePointTo : 50;									calculatePoints();					}						private function calculatePoints():void {			/**			*  			*  All variables and calculations assume 			*  the bubble will be registered at x = 0, y = 0			*  within the container Sprite, and the Sprite 			*  itself will be moved to the desired position			*  on the stage (after it's instantiated).			*  			**/						//UPPER LEFT OF RECTANGLE			var bp1:Point = new Point(0, 0);						//UPPER RIGHT OF RECTANGLE			var bp2:Point = new Point(_rectWidth, 0);						//LOWER RIGHT OF RECTANGLE			var bp3:Point = new Point(_rectWidth, _rectHeight);						//UPPER RIGHT OF POINTER			var bp4:Point = new Point(_pointX + _pointWidth, _rectHeight);						//BOTTOM OF POINTER			var bp5:Point;						if (_alignPointer) {				bp5 = new Point(_translatePointTo, _rectHeight + _pointHeight);			} else {				if (_pointIsRight) {					bp5 = new Point(_pointX + _pointWidth, _rectHeight + _pointHeight);				} else {					bp5 = new Point(_pointX, _rectHeight + _pointHeight);				}			}									//UPPER LEFT OF POINTER			var bp6:Point = new Point(_pointX, _rectHeight);						//LOWER LEFT OF RECTANGLE			var bp7:Point = new Point(0, _rectHeight);						points = [bp1, bp2, bp3, bp4, bp5, bp6, bp7];			//points  = new <Point>[bp1, bp2, bp3, bp4, bp5, bp6, bp7];			//radii = new <Number>[_radiusRect, _radiusRect, _radiusRect, _radiusPOINT, _radiusRect, _radiusRect, _radiusRect];			radii = [_radiusRect, _radiusRect, _radiusLeftOfPoint, _radiusPoint, _radiusRightOfPoint, _radiusRect, _radiusRect];			paint();		}						private function paint():void {			graphics.clear();			if (_borderWeight != 0) {				graphics.lineStyle(_borderWeight, _borderColor, _borderAlpha, true);			}			graphics.beginFill(_fillColor,_fillAlpha);						RoundPathHelper.drawRoundPath({g:graphics, points:points, closePath:true, radii:radii});			graphics.endFill();					}				public function set rectWidth(val:Number):void {			_rectWidth = val;			calculatePoints();		}				public function get rectWidth():Number {			return _rectWidth;		}				public function set rectHeight(val:Number):void {			_rectHeight = val;			calculatePoints();		}				public function get rectHeight():Number {			return _rectHeight;		}				public function set pointWidth(val:Number):void {			_pointWidth = val;			calculatePoints();		}				public function get pointWidth():Number {			return _pointWidth;		}				public function set pointHeight(val:Number):void {			_pointHeight = val;			calculatePoints();		}				public function get pointHeight():Number {			return _pointHeight;		}				public function set pointX(val:Number):void {			_pointX = val;			calculatePoints();		}				public function get pointX():Number {			return _pointX;		}				public function set radiusRect(val:Number):void {			_radiusRect = val;			calculatePoints();		}				public function get radiusRect():Number {			return _radiusRect;		}				public function set radiusPoint(val:Number):void {			_radiusPoint = val;			calculatePoints();		}				public function get radiusPoint():Number {			return _radiusPoint;		}				public function set fillColor(val:Number):void {			_fillColor = val;			calculatePoints();		}				public function get fillColor():Number {			return _fillColor;		}				public function set fillAlpha(val:Number):void {			_fillAlpha = val;			calculatePoints();		}				public function get fillAlpha():Number {			return _fillAlpha;		}				public function set borderColor(val:Number):void {			_borderColor = val;			calculatePoints();		}				public function get borderColor():Number {			return _borderColor;		}				public function set borderWeight(val:Number):void {			_borderWeight = val;			calculatePoints();		}				public function get borderWeight():Number {			return _borderWeight;		}				public function set borderAlpha(val:Number):void {			_borderAlpha = val;			calculatePoints();		}				public function get borderAlpha():Number {			return _borderAlpha;		}				public function set pointIsRight(val:Boolean):void {			_pointIsRight = val;			calculatePoints();		}				public function get pointIsRight():Boolean {			return _pointIsRight;		}		public function get translatePointTo():Number		{			return _translatePointTo;		}		public function set translatePointTo(value:Number):void		{			_alignPointer = true;			_translatePointTo = value;			calculatePoints();		}        public function get radiusLeftOfPoint():Number        {            return _radiusLeftOfPoint;        }        public function set radiusLeftOfPoint(value:Number):void        {            _radiusLeftOfPoint = value;        }        public function get radiusRightOfPoint():Number        {            return _radiusRightOfPoint;        }        public function set radiusRightOfPoint(value:Number):void        {            _radiusRightOfPoint = value;        }        public function get setWidth():Number        {            return _setWidth;        }        /**         * Set the width with relation to the text input field;         * @param value         */        public function set setWidth(value:Number):void        {            _setWidth = value;            _rectWidth = value;            calculatePoints();        }        public function get setHeight():Number        {            return _setHeight;        }        /**         * Set the height with relation to the text input field;         * @param value         */        public function set setHeight(value:Number):void        {            _setHeight = value;            _rectHeight = value;            calculatePoints();        }    }	}