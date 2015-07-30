/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/24/13
 * Time: 4:14 PM
 * To change this template use File | Settings | File Templates.
 */
package alienFxModule.uiGraphics.uiFactoryPattern.concrete {
import alienFxModule.uiGraphics.uiFactoryPattern.abstractWidgets.AbstractShapeWidget;

public class ConcreteHotSpotWidget extends AbstractShapeWidget {

    private var vars:Object;

    private var points:Array;
    private var radii:Array;


    //Points of bubble
    private var _rectWidth:Number;		//Width of rectangle
    private var _rectHeight:Number;		//Height of rectangle
	//Distance bubble point is from left bubble margin

    //COLOR
    private var _fillColor:uint;		//Color fill of bubble
    private var _fillAlpha:Number;		//Alpha of fill color
    private var _borderColor:Number;		//Color of border

    private var _radius:Number;

    private var _borderWeight:Number;	//Weight of border
    private var _borderAlpha:Number;		//Alpha of border
    private var _pointIsRight:Boolean;	//Bubble points to left



    override public function drawWidget(vars:Object = null):void {
        this.vars = (vars != null) ? vars : {};
        this.name = this.vars.name;

        _rectWidth = 62;
        _rectHeight = 42;

        _fillColor = 0xFFFFFF;
        _fillAlpha = 0;
        _borderColor = 0xFF0000;
        _borderWeight =  0;
        _borderAlpha = 0;

        _radius = 5;

        calculatePoints();
    }



    private function calculatePoints():void {
        /**
         *
         *  All variables and calculations assume
         *  the bubble will be registered at x = 0, y = 0
         *  within the container Sprite, and the Sprite
         *  itself will be moved to the desired position
         *  on the stage (after it's instantiated).
         *
         **/


        paint();
    }

    private function paint():void {
        graphics.clear();

        if (_borderWeight != 0) {
            graphics.lineStyle(_borderWeight, _borderColor, _borderAlpha, true);
        }
        graphics.lineStyle(_borderWeight, _borderColor, _borderAlpha, true);
        graphics.beginFill(_fillColor, _fillAlpha);
        graphics.drawRoundRect(0, 0, _rectWidth, _rectHeight, _radius);
        graphics.endFill();

    }



    public function set rectWidth(val:Number):void {
        _rectWidth = val;
        calculatePoints();
    }

    public function get rectWidth():Number {
        return _rectWidth;
    }

    public function set rectHeight(val:Number):void {
        _rectHeight = val;
        calculatePoints();
    }

    public function get rectHeight():Number {
        return _rectHeight;
    }


    public function set fillColor(val:Number):void {
        _fillColor = val;
        calculatePoints();
    }

    public function get fillColor():Number {
        return _fillColor;
    }

    public function set fillAlpha(val:Number):void {
        _fillAlpha = val;
        calculatePoints();
    }

    public function get fillAlpha():Number {
        return _fillAlpha;
    }

    public function set borderColor(val:Number):void {
        _borderColor = val;
        calculatePoints();
    }

    public function get borderColor():Number {
        return _borderColor;
    }

    public function set borderWeight(val:Number):void {
        _borderWeight = val;
        calculatePoints();
    }

    public function get borderWeight():Number {
        return _borderWeight;
    }

    public function set borderAlpha(val:Number):void {
        _borderAlpha = val;
        calculatePoints();
    }

    public function get borderAlpha():Number {
        return _borderAlpha;
    }

    public function set pointIsRight(val:Boolean):void {
        _pointIsRight = val;
        calculatePoints();
    }

    public function get pointIsRight():Boolean {
        return _pointIsRight;
    }


    /**
     * Set the width with relation to the text input field;
     * @param value
     */
    public function set setWidth(value:Number):void
    {
        _rectWidth = value;
        calculatePoints();
    }


    /**
     * Set the height with relation to the text input field;
     * @param value
     */
    public function set setHeight(value:Number):void
    {
        _rectHeight = value;
        calculatePoints();
    }

}
}
