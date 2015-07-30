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
    import flash.display.Sprite;

    public class RadioButton extends Sprite
    {
        private var vars:Object;

        private var _selected:Boolean = false;
        private var _borderColorOFF:uint;
        private var _borderColorON:uint;
        protected var _bulletColorOFF:uint;
        protected var _bulletColorON:uint;

        private var _radius:Number;
        private var _bulletRadius:Number;
        private var _weight:Number;

        private var _borderColor:uint;
        private var _bulletColor:uint;

        private var _bulletAlpha:Number = 0;

        private var _circle:Sprite;
        private var _bullet:Sprite;

        /**
         * Change color of button if selected.
         */
        private var _changeColorSelect:Boolean = true;

        public function RadioButton(vars:Object = null)
        {
            this.vars = (vars != null) ? vars : {};



            _radius = (this.vars.outterRadius != null) ? this.vars.outterRadius : 10;
            _bulletRadius = (this.vars.bulletRadius != null) ? this.vars.bulletRadius : _radius / 2;
            _weight = (this.vars.weight != null) ? this.vars.weight : 2;
            _borderColorOFF = (this.vars.borderColorOFF != null) ? this.vars.borderColorOFF : 0x666666;
            _bulletColorOFF = (this.vars.bulletColorOFF != null) ? this.vars.bulletColorOFF : 0x666666;

            _borderColorON = (this.vars.borderColorON != null) ? this.vars.borderColorON : 0x316EB0;
            _bulletColorON = (this.vars.bulletColorON != null) ? this.vars.bulletColorON : 0x316EB0;

            _changeColorSelect = (this.vars.changeColorSelect) ? this.vars.changeColorSelect : true;

            /** initial state is off **/
            _borderColor = (this.vars.borderColor) ? this.vars.borderColor : 0x666666;
            _bulletColor = (this.vars.bulletColor) ? this.vars.bulletColor : 0x316EB0;

            init();
        }

        private function init():void {
            _circle = new Sprite();
            _circle.name = "circle";
            _bullet = new Sprite();
            _bullet.name = "bullet";
            _bullet.alpha = 0;

            this.addChild(_circle);
            this.addChild(_bullet);

            calculatePoints();
        }

        private function calculatePoints():void {

            paint();
        }

        private function paint():void {


            _circle.graphics.clear();
            _circle.graphics.lineStyle(_weight, _borderColor, 1, true);
            _circle.graphics.beginFill(_borderColor,0);
            _circle.graphics.drawCircle(0, 0, _radius);
            _circle.graphics.endFill();

            _bullet.graphics.clear();
            _bullet.graphics.lineStyle(0, _bulletColor, 0, true);
            _bullet.graphics.beginFill(_bulletColor, 1);
            _bullet.graphics.drawCircle(0, 0, _bulletRadius);
            _bullet.graphics.endFill();

            _circle.x = _circle.y = _bullet.x = _bullet.y = 0;
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
            _borderColor = value;
            _bulletColor = value;
            calculatePoints();
        }

        public function get allColor():uint {
            return _borderColor;
        }

        public function set borderColor(value:uint):void {
            _borderColor = value;
            calculatePoints();
        }

        public function set bulletColor(value:uint):void {
            _bulletColor = value;
            calculatePoints();
        }

        public function get weight():Number
        {
            return _weight;
        }

        public function get borderColorON():uint {
            return _borderColorON;
        }

        public function set borderColorON(value:uint):void {
            _borderColorON = value;
        }

        public function get borderColorOFF():uint {
            return _borderColorOFF;
        }

        public function set borderColorOFF(value:uint):void {
            _borderColorOFF = value;
        }

        public function get bulletAlpha():Number {
            return _bulletAlpha;
        }

        public function set bulletAlpha(value:Number):void {
            _bulletAlpha = value;
            calculatePoints();
        }


    }
}
