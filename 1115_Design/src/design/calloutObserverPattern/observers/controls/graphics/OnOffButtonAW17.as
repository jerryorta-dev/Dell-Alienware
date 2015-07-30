/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/21/13
 * Time: 11:11 AM
 * To change this template use File | Settings | File Templates.
 */
package design.calloutObserverPattern.observers.controls.graphics {
import design.calloutObserverPattern.observers.ConcreteCallOutObserver;

import com.dell.alienFx.ConfigText;

import com.dell.alienFx.graphics.CallOutMinus;
import com.dell.alienFx.graphics.CallOutOnLabelBackground;
import com.dell.alienFx.graphics.CallOutPlus;
import com.dpa.graphics.RoundedRectangle;
import com.dpa.text.TextUtil;
import com.dpa.utils.objects.union;

import design.textFields.OFFTextField;

import design.textFields.ONTextField;

import flash.display.MovieClip;

import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;

public class OnOffButtonAW17 extends ConcreteCallOutObserver {

    private var _labelOffBackground:RoundedRectangle;
    private var _labelOnBackground:RoundedRectangle;

    private var _callOutPlus:CallOutPlus;
    private var _callOutMinus:CallOutMinus;

    private var _labelTextFieldWidth:Number;

    private var _labelTextOn:TextField;
    private var _labelTextOFF:TextField;

    private var iconAlign:String;

    public static const ICONALIGNLEFT:String = "left";
    public static const ICONALIGNRIGHT:String = "right";

    //Params
    private var btnWidth:Number = 1;


    //Graphics
    private var _labelBgFillcolor:int = 0x999999;
    private var _labelBgInitAlpha:Number = .15;
    private var _labelBGOnAlpha:Number = .3;
    private var _labelOffBGParams:Object;
    private var _labelHITArea:RoundedRectangle;


    public function OnOffButtonAW17(_target:MovieClip,  vars:Object = null) {
        super(vars);


    }

    override protected function init(e:Event = null):void {
        super.init();


        if (this.vars.iconAlign != null){
            iconAlign = (this.vars.iconAlign == ICONALIGNLEFT) ? ICONALIGNLEFT : ICONALIGNRIGHT;
        }

//        trace(iconAlign);

        _labelOffBGParams = {
            width: btnWidth,
            height: 30,
            radiusRect: 5,
            fillColor: _labelBgFillcolor,
            fillAlpha:1};
        _labelOffBackground = new RoundedRectangle(_labelOffBGParams);
        _labelOffBackground.alpha = _labelBgInitAlpha;

        //Leave this hard coded for now (coded here)
        _labelOffBackground.x = _labelOffBackground.y = 0;
        this.addChild(_labelOffBackground);

        var _backgroundOnShape:Object = {
            width: btnWidth,
            height: 30,
            radiusRect: 5,
            fillColor: 0x016b6b};
        _labelOnBackground = new RoundedRectangle(_backgroundOnShape);
        _labelOnBackground.x = _labelOnBackground.y = 0;
        _labelOnBackground.alpha = 1;
        this.addChild(_labelOnBackground);
        _labelOnBackground.mouseEnabled = false;


        //LABEL TEXT
//        ConfigText.TextFieldVars_DesignCaloutLabel.htmlText(this.vars.xmlNode.off);
//        ConfigText.TextFieldVars_DesignCaloutLabel.width(0);
        _labelTextOn = ONTextField.drawWidget(this.vars);
        _labelTextOn.x = 10;
        _labelTextOn.y = 5;
        this.addChild(_labelTextOn);
        _labelTextOn.mouseEnabled = false;
        _labelTextOn.alpha - 1;

        TextUtil.setTextFieldLinesTo(_labelTextOn, 1);



        //LABEL TEXT
//        ConfigText.TextFieldVars_DesignCaloutLabel.htmlText(this.vars.xmlNode.on);
//        ConfigText.TextFieldVars_DesignCaloutLabel.width(0);
        _labelTextOFF = OFFTextField.drawWidget(this.vars);
        _labelTextOFF.x = 10;
        _labelTextOFF.y = 5;
        this.addChild(_labelTextOFF);
        _labelTextOFF.mouseEnabled = false;
        _labelTextOFF.alpha = 0;

        TextUtil.setTextFieldLinesTo(_labelTextOFF, 1);



        _callOutPlus = new CallOutPlus();
        _callOutPlus.x  = _labelTextOFF.x + _labelTextOFF.width + 10;
        _callOutPlus.y = 6;
        this.addChild(_callOutPlus);
        _callOutPlus.mouseEnabled = false;
        _callOutPlus.alpha = 0;

        _callOutMinus = new CallOutMinus();
        //TODO align left or right
        _callOutMinus.x = _labelTextOFF.x + _labelTextOFF.width + 10;
        _callOutMinus.y = 6;
        _callOutMinus.alpha = 1;
        this.addChild(_callOutMinus);
        _callOutMinus.mouseEnabled = false;

        var greaterWidthOfTFs:Number = (_labelTextOn > _labelTextOFF) ? _labelTextOn.width : _labelTextOFF.width;

        _labelOffBackground.rectWidth = _labelOnBackground.rectWidth = greaterWidthOfTFs + 55;


        if (iconAlign == ICONALIGNRIGHT) {
            _callOutPlus.x =_callOutMinus.x  = _labelTextOn.x + greaterWidthOfTFs + 20;
        } else {
            _callOutPlus.x =_callOutMinus.x  = 10;
            _labelTextOn.x = _labelTextOFF.x  = _callOutPlus.rectWidth + _callOutPlus.x + 5;
        }

//        _labelOffBackground.rectHeight = _labelOnBackground.rectHeight = _labelTextOn.height + 10;

        //CENTER PLUS and MINUS
        _callOutMinus.y = _callOutPlus.y = (_labelOffBackground.rectHeight / 2) - (_callOutPlus.rectHeight / 2);

        setHitAreas();

    }

    private function setHitAreas():void {
        var labelHitArea:Object = {};
        labelHitArea = union(labelHitArea, _labelOffBGParams);
        labelHitArea.fillAlpha = 0;
        _labelHITArea = new RoundedRectangle(labelHitArea);
        _labelHITArea.x = _labelOffBackground.x;
        _labelHITArea.y = _labelOffBackground.y;
        _labelHITArea.rectHeight = _labelOffBackground.rectHeight;
        _labelHITArea.rectWidth = _labelOffBackground.rectWidth;



        this.addChild(_labelHITArea);

    }





    private function paint():void {
        this.graphics.clear();

    }

    public function ON(value:Number):void {

    }

    public function OFF():void {

    }

    public function OVER():void {

    }

    private function transitionON():void {

    }

    private function transitionOff():void {

    }

    //notifyer updates this method
    override public function notify(params:Object):void
    {
//        trace("Notified: " + params.to);
    }

    public function set labelOnBg(value:Number):void {
        _labelOnBackground.alpha = value;
    }

    public function get labelOnBg():Number {
        return 0;
    }

    public function set offTextAlpha(value:Number):void {
        _labelTextOFF.alpha = value;
    }

    public function get offTextAlpha():Number {
        return 0;
    }

    public function set onTextAlpha(value:Number):void {
        _labelTextOn.alpha = value;
    }

    public function get onTextAlpha():Number {
        return 0;
    }

    public function set plusAlpha(value:Number):void {
        _callOutPlus.alpha = value;
    }

    public function get plusAlpha():Number  {
        return 0;
    }

    public function set minusAlpha(value:Number):void {
        _callOutMinus.alpha = value;
    }

    public function get minusAlpha():Number {
        return 0;
    }



}
}
