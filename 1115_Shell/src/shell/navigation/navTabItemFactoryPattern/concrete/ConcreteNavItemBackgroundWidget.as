/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/24/13
 * Time: 4:14 PM
 * To change this template use File | Settings | File Templates.
 */
package shell.navigation.navTabItemFactoryPattern.concrete {
import com.dell.alienFx.SwatchAFX;
import com.dpa.graphics.core.RoundPathHelper;

import shell.configs.ConfigShell;

import flash.display.GradientType;

import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Point;

import shell.navigation.navTabItemFactoryPattern.abstractWidgets.AbstractShapeWidget;

public class ConcreteNavItemBackgroundWidget extends AbstractShapeWidget {

    private var vars:Object;

    private var points:Array;
    private var radii:Array;


    //Points of bubble
    private var _rectWidth:Number;		//Width of rectangle
    private var _rectHeight:Number;		//Height of rectangle
    private var _pointWidth:Number;		//Width of Bubble point
    private var _pointHeight:Number;		//Height of bubble point
    private var _pointX:Number;			//Distance bubble point is from left bubble margin
    private var _radiusRect:Number;		//Radius of the rectangle corners
    private var _radiusPoint:Number;		//Radius of the point corners
    private var _radiusLeftOfPoint:Number;
    private var _radiusRightOfPoint:Number;

    //COLOR
    private var _fillColor:uint;		//Color fill of bubble
    private var _fillAlpha:Number;		//Alpha of fill color
    private var _borderColor:Number;		//Color of border

    //GRADIENT
    private var _gradientColors:Array;
    private var _gradienAlphas:Array;
    private var _ratios:Array;

    private var _matrixWidth:Number;
    private var _matrixHeight:Number;
    private var _matrixRotation:Number;
    private var _matrixTx:Number;
    private var _matrixTy:Number;


    private var _borderWeight:Number;	//Weight of border
    private var _borderAlpha:Number;		//Alpha of border
    private var _pointIsRight:Boolean;	//Bubble points to left

    private var _setWidth:Number;
    private var _setHeight:Number;

    private var _translatePointTo:Number;

    private var _alignPointer:Boolean = false;

    private var _pointON:Number = 112;
    private var _pointOFF:Number = 107;

    //STATE
    private var _state:String = "off";

    override public function drawWidget(vars:Object = null):void {
        this.vars = (vars != null) ? vars : {};
        this.name = this.vars.name;


        _state = (this.vars.initState != null) ? this.vars.initState : "off";
        trace("_state: " + _state);

        _rectWidth = 107;
        _rectHeight = 67;
        _pointX =
        _pointWidth = 112;//original 5
        _pointHeight = 16;

        _radiusRect = 5;

        _radiusLeftOfPoint = 5;
        _radiusPoint = 2;
        _radiusRightOfPoint = 5;

        _gradientColors = [
            SwatchAFX.SHELL_MENU_TAB_OFF_LEFT,
            SwatchAFX.SHELL_MENU_TAB_OFF_RIGHT,
            SwatchAFX.SHELL_MENU_TAB_OFF_RIGHT,
            SwatchAFX.SHELL_MENU_TAB_ACTIVE_LEFT,
            SwatchAFX.SHELL_MENU_TAB_ACTIVE_RIGHT,
            SwatchAFX.SHELL_MENU_TAB_ACTIVE_RIGHT
        ];

        _gradienAlphas = [1, 1, 1, 1, 1, 1];

        _ratios=[0, 76, 128, 129, 205,255];

        _matrixWidth = _rectWidth * 2 + 3;
        _matrixHeight = _rectHeight;
        _matrixRotation = 0;
        _matrixTy = 0;

        _fillColor = 0xFFFFFF;
        _fillAlpha = 1;
        _borderColor = 0xFF0000;
        _borderWeight =  0;
        _borderAlpha = 0;



        if (_state == "on") {
            _matrixTx = -110;
            _pointX =  _pointON;
        } else {
            _matrixTx = 0;
            _pointX = _pointOFF;
        }



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

        //UPPER LEFT OF RECTANGLE
        var bp1:Point = new Point(0, 0);

        //UPPER RIGHT OF RECTANGLE
        var bp2:Point = new Point(_rectWidth, 0);


        var verticalCenterOfPointer:Number = _rectHeight / 2;
        var topOfPointer:Number = verticalCenterOfPointer - (_pointHeight / 2);
        var bottomOfPointer:Number = verticalCenterOfPointer + (_pointHeight / 2);

        //TOP OF POINTER
        var pointTop:Point = new Point(_rectWidth, topOfPointer);

        //POINTER TIP
        var pointTip:Point = new Point(_pointX, verticalCenterOfPointer);




        //BOTTOM OF POINTER
        var pointBottom:Point = new Point(_rectWidth, bottomOfPointer);

        //LOWER RIGHT OF RECTANGLE
        var bp6:Point = new Point(_rectWidth, _rectHeight);



        //LOWER LEFT OF RECTANGLE
        var bp7:Point = new Point(0, _rectHeight);

        points = [bp1, bp2, pointTop, pointTip, pointBottom, bp6, bp7];
        radii = [_radiusRect, _radiusRect, _radiusPoint, _radiusRect, _radiusRect, _radiusRect, _radiusRect];
        paint();
    }

    private function paint():void {
        graphics.clear();

        if (_borderWeight != 0) {
            graphics.lineStyle(_borderWeight, _borderColor, _borderAlpha, true);
        }
        graphics.lineStyle(_borderWeight, _borderColor, _borderAlpha, true);

        var mat:Matrix = new Matrix();
        mat.createGradientBox(_matrixWidth, _matrixRotation, _matrixRotation, _matrixTx, _matrixTy);

//			graphics.beginFill(_fillColor,_fillAlpha);
        graphics.beginGradientFill(GradientType.LINEAR,_gradientColors,_gradienAlphas,_ratios,mat);

        RoundPathHelper.drawRoundPath({g:graphics, points:points, closePath:true, radii:radii});
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

    public function set pointWidth(val:Number):void {
        _pointWidth = val;
        calculatePoints();
    }

    public function get pointWidth():Number {
        return _pointWidth;
    }

    public function set pointHeight(val:Number):void {
        _pointHeight = val;
        calculatePoints();
    }

    public function get pointHeight():Number {
        return _pointHeight;
    }

    public function set pointX(val:Number):void {
        _pointX = val;
        calculatePoints();
    }

    public function get pointX():Number {
        return _pointX;
    }

    public function set radiusRect(val:Number):void {
        _radiusRect = val;
        calculatePoints();
    }

    public function get radiusRect():Number {
        return _radiusRect;
    }

    public function set radiusPoint(val:Number):void {
        _radiusPoint = val;
        calculatePoints();
    }

    public function get radiusPoint():Number {
        return _radiusPoint;
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

    public function get translatePointTo():Number
    {
        return _translatePointTo;
    }

    public function set translatePointTo(value:Number):void
    {
        _alignPointer = true;
        _translatePointTo = value;
        calculatePoints();
    }


    public function get radiusLeftOfPoint():Number
    {
        return _radiusLeftOfPoint;
    }

    public function set radiusLeftOfPoint(value:Number):void
    {
        _radiusLeftOfPoint = value;
    }

    public function get radiusRightOfPoint():Number
    {
        return _radiusRightOfPoint;
    }

    public function set radiusRightOfPoint(value:Number):void
    {
        _radiusRightOfPoint = value;
    }

    public function get setWidth():Number
    {
        return _setWidth;
    }

    /**
     * Set the width with relation to the text input field;
     * @param value
     */
    public function set setWidth(value:Number):void
    {
        _setWidth = value;
        _rectWidth = value;
        calculatePoints();
    }

    public function get setHeight():Number
    {
        return _setHeight;
    }

    /**
     * Set the height with relation to the text input field;
     * @param value
     */
    public function set setHeight(value:Number):void
    {
        _setHeight = value;
        _rectHeight = value;
        calculatePoints();
    }

    public function get matrixTx():Number {
        return _matrixTx;
    }

    public function set matrixTx(value:Number):void {
        _matrixTx = value;
        calculatePoints();
    }

    public function get state():String {
        return _state;
    }

    public function set state(value:String):void {
        _state = value;
    }

    public function get pointOFF():Number {
        return _pointOFF;
    }

    public function set pointOFF(value:Number):void {
        _pointOFF = value;
    }

    public function get pointON():Number {
        return _pointON;
    }

    public function set pointON(value:Number):void {
        _pointON = value;
    }
}
}
