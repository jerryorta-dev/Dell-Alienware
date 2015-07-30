/**
 * VERSION:
 * AS3
 *
 * Created with IntelliJ IDEA.
 * User: jerry.orta
 * http://www.digitalproductionart.com/
 * jerryorta@gmail.com
 * Date: 10/15/12
 * Time: 1:50 PM
 */
package com.dpa.graphics
{
    import flash.display.Sprite;

    public class RectangleGraphic
    {
        public function RectangleGraphic()
        {
        }

        /**
         * Create a rectangle<br />
         * var rect:Sprite = RectangleGrpahic.create({width:stage.stageWidth, height:stage.stageHeight, fillColor:BG_COLOR});
         *
         *
         *
         * @param vars
         * @return
         */
        public static function create(vars:Object):Sprite
        {
            var _width:Number = (vars.width) ? vars.width : 10;
            var _height:Number = (vars.height) ? vars.height : 10;
            var _lineWeight:Number = (vars.lineWeight) ? vars.lineWeight : null;
            var _lineColor:uint = (vars.lineColor) ? vars.lineColor : null;
            var _lineAlpha:Number = (vars.lineAlpha) ? vars.lineAlpha : null;
            var _fillColor:uint = (vars.fillColor) ? vars.fillColor : 0xFFFFFF;


            var s:Sprite = new Sprite();
            if (vars.lineWeight)
            {
                s.graphics.lineStyle(_lineWeight, _lineColor, _lineAlpha);
            }
            s.graphics.beginFill(_fillColor);
            s.graphics.drawRect(0,0,_width, _height);
            s.graphics.endFill();

            return s;
        }


    }
}
