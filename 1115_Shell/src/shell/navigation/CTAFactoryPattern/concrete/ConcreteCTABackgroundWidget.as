/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/24/13
 * Time: 4:14 PM
 * To change this template use File | Settings | File Templates.
 */
package shell.navigation.CTAFactoryPattern.concrete {
import com.dell.alienFx.SwatchAFX;

import shell.navigation.CTAFactoryPattern.abstractWidgets.AbstractShapeWidget;


public class ConcreteCTABackgroundWidget extends AbstractShapeWidget {

    public var vars:Object;


    //Points of bubble
    private var _rectWidth:Number;		//Width of rectangle
    private var _rectHeight:Number;		//Height of rectangle
    private var _radiusRect:Number;		//Radius of the rectangle corners

    //COLOR
    private var _fillColor:uint;		//Color fill of bubble
    private var _fillAlpha:Number;		//Alpha of fill color
    private var _borderColor:Number;		//Color of border


    private var _borderWeight:Number;	//Weight of border
    private var _borderAlpha:Number;		//Alpha of border


    private var _setWidth:Number;
    private var _setHeight:Number;




    //STATE
    private var _state:String = "off";

    override public function drawWidget(vars:Object = null):void {
        this.vars = (vars != null) ? vars : {};

        this.name = this.vars.bgName;

        //Dimensions
        _rectWidth = 107;
        _rectHeight = 20;
        _radiusRect = 18;

        //Color
        _fillColor = SwatchAFX.LINK_TEAL;
        _borderColor =  0xffffff;

        //Weight
        _borderWeight = 0;

        //Alpha
        _fillAlpha = 1;
        _borderAlpha =  0;

        calculatePoints();

    }



    private function calculatePoints():void {
        paint();
    }


    private function paint():void {
        graphics.clear();

        if (_borderWeight != 0) {
            graphics.lineStyle(_borderWeight, _borderColor, _borderAlpha, true);
        }
        graphics.lineStyle(_borderWeight, _borderColor, _borderAlpha, true);

        graphics.beginFill(_fillColor,_fillAlpha);

        graphics.drawRoundRect(0, 0, _rectWidth, _rectHeight, _radiusRect);

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



    public function set radiusRect(val:Number):void {
        _radiusRect = val;
        calculatePoints();
    }

    public function get radiusRect():Number {
        return _radiusRect;
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
}
}
