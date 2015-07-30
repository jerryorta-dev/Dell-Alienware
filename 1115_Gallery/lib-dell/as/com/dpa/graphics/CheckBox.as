/**
 * Created with IntelliJ IDEA.
 * User: Jerry Orta
 * http://www.digitalproductionart.com
 * jerryorta@gmail.com
 *
 * Date: 11/6/12
 * Time: 3:35 PM
 */
package com.dpa.graphics
{
    import avmplus.variableXml;

    import com.greensock.layout.PinPoint;

    import flash.display.Sprite;
    import flash.geom.Point;

    public class CheckBox extends Sprite
    {
        private var vars:Object;

        private var _selected:Boolean = false;
        
        private var _boxColorOFF:uint;
        private var _boxColorON:uint;

        private var _borderColor:uint;
        private var _fillOverColor:uint;

        private var _boxWeight:Number;
        
        protected var _checkColorOFF:uint;
        protected var _checkColorON:uint;
        private var _boxColorOver:uint;



//private var _radius:Number;
        private var _width:Number;
        private var _height:Number;


        private var _boxColor:uint;
        private var _checkColor:uint;

        private var _boxCornerRadius:Number;

        private var _checkPoints:Array;
        private var _checkPointsLength:int;

        /**
         * Box Graphic
         */
        private var _border:Sprite;
        private var _box:Sprite;
        private var _check:Sprite;

        private var _checkScale:Number;


        /**
         * Change color of button if selected.
         */
        //TODO Is this property necessary?
        private var _changeColorSelect:Boolean = true;

        public function CheckBox(vars:Object = null)
        {
            this.vars = (vars != null) ? vars : {};

            _selected = (this.vars.selected != null) ? this.vars.selected : false;

            _borderColor = (this.vars.borderColor) ? this.vars.borderColor : 0x666666;
            _boxColorOver = (this.vars.boxColorOver != null ) ? this.vars.boxColorOver : 0xEEEEEE;

            _boxColorOFF = (this.vars.boxColorOFF != null) ? this.vars.boxColorOFF : 0xFFFFFF;
            _boxColorON = (this.vars.boxColorON != null) ? this.vars.boxColorON : 0x316EB0;

            _fillOverColor = (this.vars.fillOverColor != null) ? this.vars.fillOverColor : 0x316E80;

            _checkColorOFF = (this.vars.checkColorOFF != null) ? this.vars.checkColorOFF : 0x666666;
            _checkColorON = (this.vars.checkColorON != null) ? this.vars.checkColorON : 0x316EB0;

            _width = (this.vars.width != null) ? this.vars.width : 20;
            _height = (this.vars.height != null) ? this.vars.height : 20;

            _boxWeight = (this.vars.boxWeight != null) ? this.vars.boxWeight : 2;

            _boxCornerRadius = (this.vars.radius != null) ? this.vars.radius : 0;

            _checkScale = (this.vars.checkScale) ? this.vars.checkScale : 1.5;

            _changeColorSelect = (this.vars.changeColorSelect) ? this.vars.changeColorSelect : true;

            /** initial state is off **/
            _boxColor = _boxColorOFF;
            _checkColor = _checkColorON;

            _checkPoints = new Array();

           init();
        }

        private function init():void {
            _border = new Sprite();
            _border.name = "border";

            _box = new Sprite();
            _box.name = "box";

            _check = new Sprite();
            _check.name = "check";

            this.addChild(_border);
            this.addChild(_box);
            this.addChild(_check);

            _check.scaleX = _checkScale;
            _check.scaleY = _checkScale;

            calculatePoints();
        }

        private function calculatePoints():void {

            var checkEndCapWidth:Number = _width / 3;

            /**
             * CheckBox points are drawn in proportion to the check box
             */
            var x0:Number = _width * .36;
            var y0:Number = _height * 1;
            var p0:Point = new Point(x0, y0);
            _checkPoints.push(p0);

            var x1:Number = _width * .18;
            var y1:Number = _height * .74;
            var p1:Point = new Point(x1, y1);
            _checkPoints.push(p1);

            var x2:Number = _width * 0;
            var y2:Number = _height * .6;
            var p2:Point = new Point(x2, y2);
            _checkPoints.push(p2);

            var x3:Number = _width * .09;
            var y3:Number = _height * .52;
            var p3:Point = new Point(x3, y3);
            _checkPoints.push(p3);

            var x4:Number = _width * .25;
            var y4:Number = _height * .64;
            var p4:Point = new Point(x4, y4);
            _checkPoints.push(p4);

            var x5:Number = _width * .32;
            var y5:Number = _height * .72;
            var p5:Point = new Point(x5, y5);
            _checkPoints.push(p5);

            var x6:Number = _width * .56;
            var y6:Number = _height * .36;
            var p6:Point = new Point(x6, y6);
            _checkPoints.push(p6);

            var x7:Number = _width * 1;
            var y7:Number = _height * 0;
            var p7:Point = new Point(x7, y7);
            _checkPoints.push(p7);

            var x8:Number = _width * .6;
            var y8:Number = _height * .42;
            var p8:Point = new Point(x8, y8);
            _checkPoints.push(p8);

            var p9:Point = p0;
            _checkPoints.push(p9);



            _checkPointsLength = _checkPoints.length;
            paint();
        }

        private function paint():void {


            _box.graphics.clear();
            //_box.graphics.lineStyle(0, _borderColor, 1, true);
            _box.graphics.beginFill(_boxColor,1);
            _box.graphics.drawRoundRect(0, 0, _width, _height,_boxCornerRadius);
            _box.graphics.endFill();

            _border.graphics.clear();
            _border.graphics.lineStyle(5, _borderColor, 1, true);
            _border.graphics.drawRoundRect(0, 0, _width, _height,_boxCornerRadius);
            _border.graphics.endFill();



            _check.graphics.clear();
            //_check.graphics.lineStyle(0, _boxColor, 0, true);
            _check.graphics.beginFill(_checkColor,1);
            _check.graphics.moveTo(_checkPoints[0].x,  _checkPoints[0].y);
            _check.graphics.curveTo(_checkPoints[1].x, _checkPoints[1].y, _checkPoints[2].x, _checkPoints[2].y);
            _check.graphics.lineTo(_checkPoints[3].x, _checkPoints[3].y);
            _check.graphics.curveTo(_checkPoints[4].x, _checkPoints[4].y, _checkPoints[5].x, _checkPoints[5].y);
            _check.graphics.curveTo(_checkPoints[6].x, _checkPoints[6].y, _checkPoints[7].x, _checkPoints[7].y);
            _check.graphics.curveTo(_checkPoints[8].x, _checkPoints[8].y, _checkPoints[9].x, _checkPoints[9].y);
            _check.graphics.endFill();


            _box.x = 0;
            _box.y = 0;

            //If check is bigger than box, align left. If check is smaller than box, horizontally center
            _check.x = (_check.width > _box.width) ? 0 : (_box.width - (_check.width * _checkScale)) / 2;

            //If check is smaller than box, vertically center. If check is bigger than box, align bottom
            _check.y = (_check.height > _box.height) ? _box.height - _check.height: (_box.height - _check.height) / 2;
        }

        public function get selected():Boolean
        {
            return _selected;
        }

        public function set selected(value:Boolean):void
        {
            _selected = value;
            calculatePoints();
        }

        public function set allColor(value:uint):void {
            _boxColor = value;
            _checkColor = value;
            calculatePoints();
        }

        //TODO alter this
        public function get allColor():uint {
            return _boxColor;
        }


        public function get boxColorON():uint
        {
            return _boxColorON;
        }

        public function set boxColorON(value:uint):void
        {
            _boxColorON = value;
        }

        public function get boxColorOver():uint
        {
            return _boxColorOver;
        }

        public function get boxColorOFF():uint
        {
            return _boxColorOFF;
        }

        public function set boxColorOFF(value:uint):void
        {
            _boxColorOFF = value;
        }
    }
}
