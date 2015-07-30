/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/21/13
 * Time: 11:11 AM
 * To change this template use File | Settings | File Templates.
 */
package alienFxModule.swatches.swatchStatePattern.abstract.graphics {
//import com.dpa.ui.object.utils.addHandCurserNoChildren;
import com.dpa.utils.object.addHandCurserNoChildren;
import com.greensock.plugins.TintPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import alienFxModule.swatches.swatchStatePattern.abstract.Context_Swatches;
import alienFxModule.swatches.swatchStatePattern.abstract.IState_Swatch;

public class Swatch extends Sprite {

    private var _vars:Object;

    private var _rectWidth:Number;
    private var _rectHeight:Number;

    private var _radius:Number;

    private var _fillColor:uint;
    private var _fillAlpha:Number;

    private var _strokeColor:uint;
    private var _strokeWeight:Number;
    private var _strokeAlpha:Number;

    //For Observer Patter
    private var _state:Context_Swatches;

    private var _stateIsOn:Boolean;




    public function Swatch(vars:Object = null) {
        this._vars = (vars != null) ? vars : {};

        init()
    }

    protected function init(e:Event = null):void {
        TweenPlugin.activate([TintPlugin]);

        _rectWidth = (this._vars.width != null) ? this._vars.width : 30;
        _rectHeight = (this._vars.height != null) ? this._vars.height : 30;
        _radius = (this._vars.radius != null) ? this._vars.radius : 4;
        _fillColor = (this._vars.fillColor != null) ? this._vars.fillColor : 0xffffff;
        _fillAlpha = (this._vars.fillAlpha != null) ? this._vars.fillAlpha : 1;
        _strokeColor = (this._vars.strokeColor != null) ? this._vars.strokeColor : 0xffffff;
        _strokeWeight = (this._vars.strokeWeight != null) ? this._vars.strokeWeight : 2;
        _strokeAlpha = (this._vars.strokeAlpha != null) ? this._vars.strokeAlpha : 0;

        this.name = String(_fillColor);


        if (vars.state != null) {
            _stateIsOn = (vars.state == "on");
        }

        if (_stateIsOn) {
            _strokeAlpha = 1;
        }

        var setState:String;
        if (_stateIsOn) {
            setState = "on";
        } else {
            setState = "off";
        }

        _state = new Context_Swatches(this, setState);



        addHandCurserNoChildren(this);

        this.addEventListener(MouseEvent.ROLL_OVER, onRollOver, false, 0, true);
        this.addEventListener(MouseEvent.ROLL_OUT, onRollOut, false, 0, true);
        this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);


        paint();
    }


    private function paint():void {

        this.graphics.clear();
        this.graphics.lineStyle(_strokeWeight, _strokeColor, _strokeAlpha); //Last arg is the alpha
        this.graphics.beginFill(_fillColor, _fillAlpha); //Last arg is the alpha
        this.graphics.drawRoundRect(0, 0, _rectWidth, _rectHeight, _radius)
        this.graphics.endFill();

    }

    private function onRollOut(event:MouseEvent):void {
        if (!_stateIsOn) {
            _state.OFF();
        }
    }

    private function onRollOver(event:MouseEvent):void {

        _state.OVER();
    }

    private function onMouseDown(event:MouseEvent = null):void {
        _stateIsOn = true;
        _state.ON();
    }


    //Set this state
    public function ON():void {
        _stateIsOn = true;
        _state.ON();
    }

    public function OFF():void {
        _stateIsOn = false;
        _state.OFF();
    }

    public function OVER():void {
        _stateIsOn = false;
        _state.OVER();
    }

    public function setState(_newState:IState_Swatch):void {
        if (_newState == _state.getOFFSwatchState() ) {
            _stateIsOn = false;
            _state.OFF();
        }

        if (_newState == _state.getONSwatchState() ) {
            _stateIsOn = true;
            _state.ON();
        }

        if (_newState == _state.getOVERSwatchState() ) {
            _stateIsOn = false;
            _state.OVER();
        }

    }

    public function get state():Context_Swatches {
        return _state;
    }

    public function get stateIsOn():Boolean {
        return _stateIsOn;
    }

    public function set stateIsOn(value:Boolean):void {
        _stateIsOn = value;
    }

    //notifyer updates this method


    //Tween Params


    public function get strokeWeight():Number {
        return _strokeWeight;
    }

    public function set strokeWeight(value:Number):void {
        _strokeWeight = value;
        paint();
    }

    public function get vars():Object {
        return _vars;
    }

    public function set vars(value:Object):void {
        _vars = value;
        paint();
    }

    public function get rectHeight():Number {
        return _rectHeight;
    }

    public function set rectHeight(value:Number):void {
        _rectHeight = value;
        paint();
    }

    public function get fillColor():uint {
        return _fillColor;
    }

    public function set fillColor(value:uint):void {
        _fillColor = value;
        paint();
    }

    public function get fillAlpha():Number {
        return _fillAlpha;
    }

    public function set fillAlpha(value:Number):void {
        _fillAlpha = value;
        paint();
    }

    public function get radius():Number {
        return _radius;
    }

    public function set radius(value:Number):void {
        _radius = value;
        paint();
    }

    public function get strokeColor():uint {
        return _strokeColor;
    }

    public function set strokeColor(value:uint):void {
        _strokeColor = value;
        paint();
    }

    public function get rectWidth():Number {
        return _rectWidth;
    }

    public function set rectWidth(value:Number):void {
        _rectWidth = value;
        paint();
    }

    public function get strokeAlpha():Number {
        return _strokeAlpha;
    }

    public function set strokeAlpha(value:Number):void {
        _strokeAlpha = value;
        paint();
    }
}
}
