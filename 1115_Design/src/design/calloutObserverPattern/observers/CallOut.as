/**
 * Created with IntelliJ IDEA.
 * User: jerryorta
 * Date: 5/2/13
 * Time: 6:26 AM
 * To change this template use File | Settings | File Templates.
 */
package design.calloutObserverPattern.observers {

import com.dell.alienFx.ConfigText;
import com.dell.alienFx.GlobalAnim;
import com.dell.alienFx.SwatchAFX;
import com.dell.alienFx.graphics.CallOutMinus;
import com.dell.alienFx.graphics.CallOutOnBackgroundAreaText;
import com.dell.alienFx.graphics.CallOutOnLabelBackground;
import com.dell.alienFx.graphics.CallOutPlus;
import com.dell.services.TrackEvent;
import com.dpa.graphics.RoundedRectangle;
import com.dpa.text.TextUtil;
import com.dpa.utils.object.addHandCurserNoChildren;
import com.dpa.utils.objects.union;
import com.dpa.utils.tracers.traceProps;
import com.greensock.TimelineLite;
import com.greensock.TimelineMax;
import com.greensock.TweenAlign;
import com.greensock.TweenLite;
import com.greensock.TweenMax;
import com.greensock.easing.Linear;
import com.greensock.plugins.AutoAlphaPlugin;
import com.greensock.plugins.FramePlugin;
import com.greensock.plugins.TintPlugin;
import com.greensock.plugins.TweenPlugin;

import design.Omniture.Tracking;

import design.textFields.CallOutCopyTextField;

import design.textFields.CallOutLabelTextField;

import flash.display.CapsStyle;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

public class CallOut extends ConcreteCallOutObserver {


    private static const COUNTERROTATE:Boolean = false; //<set to false
    public static const ROTATE:Boolean = false; //set to fasle

    private var _initState:String;
    private const EXPANDED:String = "expanded";
    private const COLLAPSED:String = "collapsed";

    private var iconAlign:String;
    private var labelAlign:String;

    public static const ICONALIGNLEFT:String = "left";
    public static const ICONALIGNRIGHT:String = "right";


    private var _label:TextField;
    private var _copy:TextField;


    private var _labelOffBackground:CallOutOnLabelBackground;

    //Target Reference MovieClips in subloaded swf
    private var _container:MovieClip;
    private var _calloutTarget:DisplayObject;
    private var _lineToTarget:DisplayObject;
    private var _activeTarget:DisplayObject;


//    private var _tf:TextField;
//    private var _icon:MovieClip;

    //CallOut States
    private var _isExpanded:Boolean = false;
    private var _closeOverride:Boolean = false;

    //Flow Control
    private var _adjustPositionCallBack:Function;


    //Call out rotationY is 0;
    //Value of slider which this callout is active
    private var _activeYRotation:Number;

    //ROTATION
    private var _targetRotationYAxis:Number;
    private var _cachedRotationYAxis:Number
    private var _minOpacity:Number;
    private var _minRotation:Number;
    private var _maxRotation:Number;
    private var _maxHeight:Number;

    //Hit Test
    private var _hitTestTargetAbove:CallOut;
    private var _hitTextTargetBelow:CallOut;
    private var _adjustPosition:Boolean = false;

    //Graphics
    private var _callOutPlus:CallOutPlus;
    private var _callOutMinus:CallOutMinus;

    private var _labelOnBackground:CallOutOnLabelBackground;
    private var _areaTextBackground:CallOutOnBackgroundAreaText;
    private var _areaTextTargetHeight:Number;
    private var _areaTextTargetWidth:Number;
    private var _labelTextFieldWidth:Number;

    //Timeline animaton
    private var _clickTLM:TimelineLite;
    private var _timelineComplete:Boolean = false;
    private var _animationComplete:Boolean = false;
    private const BEGIN_LINE:String = "beginLine";


    private var _slider:Slider;
//    private var _sliderInitRotation:Number;
    private var redrawLine:Boolean = false;

    private var _lineToSprite:Sprite;
    private var _lineToOriginY:Number = 5;
    private var _lineToOriginX:Number = 0;

    //Graphics
    private var _labelBgFillcolor:int = 0x999999;
    private var _labelBgInitAlpha:Number = .15;
    private var _labelBGOnAlpha:Number = .3;

    private var _labelHITArea:RoundedRectangle;
    private var _copyHITArea:RoundedRectangle;
    private var _labelOffBGParams:Object;
    private var _copyHitAreaParams:Object;

    private var isMouseOver:Boolean = false;
    private var isClickActive:Boolean = false;

    private var allOn:Boolean = true;
    private var reset:Boolean = true;

    private var _isInitting:Boolean = true;

    private var  isAW:int;

    public var track:String;


    public function CallOut(vars:Object = null) {
        super(vars);
    }

    override protected function init(e:Event = null):void {
        super.init();


        this.removeEventListener(Event.ADDED_TO_STAGE, init);

        TweenPlugin.activate([FramePlugin, TintPlugin, AutoAlphaPlugin]);

        this.isAW = this.vars.isAW;

        this.x = this.vars.x;
        this.y = this.vars.y;
        this.z = (this.vars.z != null) ? this.vars.z : 0;

        this.activeTarget = (this.vars.activeTarget != null) ? this.vars.activeTarget : null;
        this.calloutTarget = (this.vars.calloutTarget != null) ? this.vars.calloutTarget : null;
        this.lineToTarget = (this.vars.lineToTarget != null) ? this.vars.lineToTarget : null;
        this.container = (this.vars.container != null) ? this.vars.container : null;
        _slider = (this.vars.slider != null) ? this.vars.slider : null;
        _minRotation = (this.vars.minRotation != null) ? this.vars.minRotation : -15;
        _maxRotation = (this.vars.maxRotation != null) ? this.vars.maxRotation : 15;
        _maxHeight = (this.vars.maxHeight != null) ? this.vars.maxHeight : 695;
        _targetRotationYAxis = (this.vars.sliderInitRotation != null) ? this.vars.sliderInitRotation : 0;
        _activeYRotation = (this.vars.activeYRotation != null) ? this.vars.activeYRotation : 0;
        _minOpacity = (this.vars.minOpacity != null) ? this.vars.minOpacity : .2;
        _adjustPositionCallBack = (this.vars.adjustingPositionCallBack != null) ? this.vars.adjustingPositionCallBack : null;
        _areaTextTargetWidth = (this.vars.areaTextTargetWidth != null) ? this.vars.areaTextTargetWidth : 300;
        _labelTextFieldWidth = (this.vars.labelTextFieldWidth != null) ? this.vars.labelTextFieldWidth : 150;

        _initState = (this.vars.state != null) ? this.vars.state : COLLAPSED;



        if (this.vars.iconAlign != null){
            iconAlign = (this.vars.iconAlign == ICONALIGNLEFT) ? ICONALIGNLEFT : ICONALIGNRIGHT;
        }

        if (this.vars.labelAlign != null){
            labelAlign = (this.vars.labelAlign == ICONALIGNLEFT) ? ICONALIGNLEFT : ICONALIGNRIGHT;
        }


        _lineToSprite = new Sprite();
        this.addChild(_lineToSprite);
        _lineToSprite.mouseEnabled = false;

        _labelOffBGParams = {
            width: 198,
            height: 28,
            radiusRect: 5,
            fillColor: _labelBgFillcolor,
            fillAlpha:1};
        _labelOffBackground = new CallOutOnLabelBackground(_labelOffBGParams);
        _labelOffBackground.alpha = _labelBgInitAlpha;


        //Leave this hard coded for now (coded here)
        _labelOffBackground.x = _labelOffBackground.y = 0;
        this.addChild(_labelOffBackground);

        var _labelOnBGParams:Object = {
            width: 198,
            height: 28,
            radiusRect: 5,
            fillColor: 0x016b6b};

        if (isAW == 14) {
            _labelOnBGParams.fillColor = SwatchAFX.CALL_TEAL;
        } else if (isAW == 17) {
            _labelOnBGParams.fillColor = SwatchAFX.CALL_TEAL;
        } else {
            _labelOnBGParams.fillColor = SwatchAFX.CALL_TEAL;
        }

        _labelOnBackground = new CallOutOnLabelBackground(_labelOnBGParams);
        _labelOnBackground.x = _labelOnBackground.y = 0;
        _labelOnBackground.alpha = 0;
        this.addChild(_labelOnBackground);
        _labelOnBackground.mouseEnabled = false;

        var gradientColors:Array = [
            0x016b6b,
            0x003434
        ];

        var strokeGradientColors:Array = [
            0x369090,
            0x369090,
            0x1f5252,
            0x1f5252
        ];

        var atVars:Object = {};
        atVars.gradientColors = gradientColors;
        atVars.strokeGradientColors = strokeGradientColors;

        _areaTextBackground = new CallOutOnBackgroundAreaText(atVars);
        _areaTextBackground.x = 0;
        _areaTextBackground.y = _labelOnBackground.height;
        _areaTextBackground.alpha = 0;
        _areaTextBackground.visible = false;
        this.addChild(_areaTextBackground);
        _areaTextBackground.mouseEnabled = false;


        //LABEL TEXT
//         ConfigText.TextFieldVars_DesignCaloutLabel.htmlText(this.vars.xmlNode.title);
//         ConfigText.TextFieldVars_DesignCaloutLabel.width(_labelTextFieldWidth);
//         _label = TextUtil.createTextField(ConfigText.TextFieldVars_DesignCaloutLabel.vars);
         _label = CallOutLabelTextField.drawWidget(this.vars);
         _label.x = 10;
         _label.y = 5;
         this.addChild(_label);
         _label.mouseEnabled = false;

        _callOutPlus = new CallOutPlus();
        _callOutPlus.x  = _label.x + _label.width + 10;
        _callOutPlus.y = 6;
        this.addChild(_callOutPlus);
        _callOutPlus.mouseEnabled = false;

        _callOutMinus = new CallOutMinus();

        _callOutMinus.x = _label.x + _label.width + 10;
        _callOutMinus.y = 6;
        _callOutMinus.alpha = 0;
        this.addChild(_callOutMinus);
        _callOutMinus.mouseEnabled = false;

        TextUtil.setTextFieldLinesTo(_label, 2);
        _callOutPlus.x = _callOutMinus.x = _label.x + _label.getLineMetrics(0).width + 15;
        _labelOnBackground.rectWidth = _labelOffBackground.rectWidth = _callOutPlus.x + _callOutPlus.rectWidth + 10;

        //Adjust LineTo
        _lineToSprite.x = _callOutMinus.x;
        _lineToSprite.y = _callOutMinus.y;

        _copy = CallOutCopyTextField.drawWidget(this.vars);
        _copy.x = 10;
        _copy.y = 40;
        _copy.alpha = 0;
        _copy.visible = false;
        this.addChild(_copy);
        _copy.mouseEnabled = false;
        TextUtil.setTextFieldLinesTo(_copy, 2);

        _areaTextTargetHeight = _copy.height + 20;
        _areaTextBackground.rectHeight = 0;
        _areaTextBackground.rectWidth = _copy.width + 20;

        _labelOffBackground.rectWidth = _labelOnBackground.rectWidth = _label.width + 40;

        if (iconAlign == ICONALIGNRIGHT) {
            _callOutPlus.x =_callOutMinus.x  = _label.x + _label.width + 5;
        } else {
            _callOutPlus.x =_callOutMinus.x  = 10;
            _label.x = _callOutPlus.rectWidth + _callOutPlus.x + 10;
        }

        _labelOffBackground.rectHeight = _labelOnBackground.rectHeight = _label.height + 10;
        _areaTextBackground.y = _labelOffBackground.y + _labelOffBackground.rectHeight;

        //CENTER PLUS and MINUS
        _callOutMinus.y = _callOutPlus.y = (_labelOffBackground.rectHeight / 2) - (_callOutPlus.rectHeight / 2);

        _copy.y = _areaTextBackground.y + 10;

        if (labelAlign == ICONALIGNRIGHT) {
            var adjustX:Number = _areaTextBackground.rectWidth - _labelOffBackground.rectWidth;
            _label.x += adjustX;
            _labelOffBackground.x += adjustX;
            _labelOnBackground.x += adjustX;
            _callOutMinus.x += adjustX;
            _callOutPlus.x += adjustX;
        }

        //Adjust linefrom target
        _lineToOriginX = _labelOffBackground.x + 5;
        _lineToOriginY = _labelOffBackground.rectHeight / 2;

        //Adjust callout x position if it's hanging off the stage
        var thisX:Number = this.localToGlobal(new Point(0, 0)).x + this.width;
        if ( thisX > 965 ) {
            var diffX:Number = thisX - 965 + 20;
            this.x -= diffX;
        }

        //Adjust callout y position if it's crashing into the slider
        var thisY:Number = this.localToGlobal(new Point(0, 0)).y + _labelOnBackground.height + _areaTextTargetHeight + 20;
        if (thisY > 450) {
            var diffY:Number = thisY - 450;
            this.y -= diffY;
        }
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

        _copyHITArea = new RoundedRectangle(labelHitArea);
        _copyHITArea.rectWidth = _areaTextBackground.rectWidth;
        _copyHITArea.rectHeight = _areaTextBackground.rectHeight;

        _copyHITArea.x = _areaTextBackground.x;
        _copyHITArea.y = _areaTextBackground.y;

        this.addChild(_labelHITArea);
        this.addChild(_copyHITArea);

        addListeners();
    }

    private function addListeners():void {
        addHandCurserNoChildren(_labelOffBackground);
        addHandCurserNoChildren(_areaTextBackground);
        addHandCurserNoChildren(_labelHITArea);
        addHandCurserNoChildren(_copyHITArea);
        this.parent.mouseEnabled = false;


        this.addEventListener(MouseEvent.CLICK, click, false, 0, true);
        _labelHITArea.addEventListener(MouseEvent.ROLL_OVER, onMouseOver, false, 0, true);
        _labelHITArea.addEventListener(MouseEvent.ROLL_OUT, onMouseOut, false, 0, true);

//        if (reset) {
            setInitState();
//        }
    }

    private function removeListeners():void {
        this.removeEventListener(MouseEvent.CLICK, click);
        _labelHITArea.removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
        _labelHITArea.removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
    }

    private function setInitState():void {

        /*if (_initState == EXPANDED) {

            _isExpanded = false;


            _sendToSubjectVars.tweenTo = _activeYRotation;
            _sendToSubjectVars.allClose = false;
            _sendToSubjectVars.closeOtherCallouts = true;
            isClickActive = true;
            expand();


        } else {
            alphaOff();
        }*/
    }

    private function get animateCallOut():TimelineLite {
//        trace("_areaTextBackground.rectHeiht: " + _areaTextBackground.rectHeight);

        if (_clickTLM == null ) {
            _clickTLM = new TimelineMax({paused: true, onComplete: timelineComplete, onReverseComplete: animateLineOFF});
            _clickTLM.insertMultiple([
                TweenLite.to(_labelOnBackground, GlobalAnim.TRANSISITION, {alpha: 1}),
                TweenLite.to(_callOutPlus, GlobalAnim.TRANSISITION, {alpha: 0}),
                TweenMax.to(_areaTextBackground, GlobalAnim.TRANSISITION, {autoAlpha: 1, rectHeight: _areaTextTargetHeight}),
                TweenMax.to(_copyHITArea, GlobalAnim.TRANSISITION, {autoAlpha: 1, rectHeight: _areaTextTargetHeight}),
                TweenMax.to(_copy, GlobalAnim.TRANSISITION, {delay: .15, autoAlpha: 1}),
                TweenLite.to(_callOutMinus, GlobalAnim.TRANSISITION, {alpha: 1}),

            ], 0, TweenAlign.NORMAL, 0);

            _clickTLM.duration(.3);
        }


        return _clickTLM;
    }

    private function onMouseOver(event:MouseEvent):void {
        isMouseOver = true;
        alphaOn();
    }

    private function onMouseOut(event:MouseEvent):void {
        isMouseOver = false;

//        trace("is not expanded: " + !_isExpanded);
//        trace("is rotated within range: " + isRotatedWithinRange);

        if (!_isExpanded || !isRotatedWithinRange) {
            alphaOff();
        }
    }

    private function animationLineON():void {

        var _transitionTime:Number = GlobalAnim.TRANSISITION / 2;
        TweenLite.to(this, _transitionTime, {drawHorizontal: localTargetPoint.x, ease: Linear.easeNone, onStart: toggleRedrawLine, onStartParams: [false]});
        TweenLite.to(this, _transitionTime, {delay: _transitionTime, drawVertical: localTargetPoint.y, onComplete: toggleRedrawLine, onCompleteParams: [true], overwrite:1});
    }

    private function animateLineOFF():void {
        var _transitionTime:Number = GlobalAnim.TRANSISITION / 2;
        TweenLite.to(this, _transitionTime, {drawVertical: _lineToOriginY, ease: Linear.easeNone, onStart: toggleRedrawLine, onStartParams: [false]});
        TweenLite.to(this, _transitionTime, {delay: _transitionTime, drawHorizontal: _lineToOriginX, onComplete: toggleRedrawLine, onCompleteParams: [false]});
    }


    //onEnterFrame draw
    private function toggleRedrawLine(value:Boolean):void {
        redrawLine = value;
    }


    //Line Animation
    private function prepareLineDraw():void {
        _lineToSprite.graphics.clear();
        _lineToSprite.graphics.lineStyle(1, 0x999999, 1, true, "normal", CapsStyle.ROUND);
        _lineToSprite.graphics.moveTo(_lineToOriginX, _lineToOriginY);
    }

    public function get localTargetPoint():Point {
        var point2DOnStage:Point = _lineToTarget.localToGlobal(new Point(0, 0));
        return _lineToSprite.globalToLocal(point2DOnStage);
    }

    public function set drawHorizontal(value:Number):void {
        prepareLineDraw();
        _lineToSprite.graphics.lineTo(value, _lineToOriginY);
    }

    public function get drawHorizontal():Number {
        return _lineToOriginX;
    }

    public function set drawVertical(value:Number):void {
        prepareLineDraw();
        _lineToSprite.graphics.lineTo(this.localTargetPoint.x, _lineToOriginY);
        _lineToSprite.graphics.lineTo(this.localTargetPoint.x, value);
    }

    public function get drawVertical():Number {
        return _lineToOriginY;
    }

    public function click(e:MouseEvent = null):void {
        var tEvt:TrackEvent = new TrackEvent('button','Design-CallOut-' + this.name);
        design.Omniture.Tracking.trackMetrics(tEvt);

//        trace("on click _isExpanded: " + _isExpanded);
        if (!isRotatedToPosition) {
//            _slider.tweenTo(_activeYRotation);
            _sendToSubjectVars.tweenTo = _activeYRotation;
            _sendToSubjectVars.allClose = false;
            _sendToSubjectVars.closeOtherCallouts = true;
            isClickActive = true;
            expand();
            this.callTweenTo();
        } else {
            isClickActive = false;
            if (_isExpanded) {
                callSubject();
                close();
            } else {
                callSubject();
                expand();
            }
        }


    }

    public function timelineComplete():void {


//        trace("_areaTextBackground.rectHeiht: " + _areaTextBackground.rectHeight);
        animationLineON();
        _timelineComplete = true;
        isClickActive = true;
    }

    public function expand():void {

        if (!_isExpanded) {
            _isExpanded = true;
            animateCallOut.progress(0);
            animateCallOut.play();

            if (this._lineToTarget.name == "feature3Target") {//for animated movieclip in line
                TweenLite.to(_lineToTarget, GlobalAnim.TRANSISITION, {delay:.7, alpha:1});
            }

        }
    }



    public function close(event:MouseEvent = null):void {

        if (_isExpanded) {
//            trace("_isExpanded on close() " + _isExpanded);
            _isExpanded = false;

//            trace(this._lineToTarget.name);

            if (this._lineToTarget.name == "feature3Target") {
                TweenLite.to(_lineToTarget, GlobalAnim.TRANSISITION, {alpha:0});
            }

            animateCallOut.progress(1);
            animateCallOut.reverse();
        }

    }


    private function alphaOn(event:MouseEvent = null):void {
//        if (!allOn) {
            TweenLite.to(_label, GlobalAnim.TRANSISITION, {alpha:1});
            TweenLite.to(_labelOffBackground, GlobalAnim.TRANSISITION, {alpha:_labelBGOnAlpha});
//        }

    }

    private function  alphaOff(event:MouseEvent = null):void {
        if (!isClickActive) {
            TweenLite.to(_label, GlobalAnim.TRANSISITION, {alpha:_minOpacity});
            TweenLite.to(_labelOffBackground, GlobalAnim.TRANSISITION, {alpha:_labelBgInitAlpha});
        }
        
    }

    private function isClickActiveNot():void {
        isClickActive = false;
    }


    override public function notify(params:Object):void {
        super.notify(params);

        if (params.allOn != null) {
            if (params.allOn == true) {
                allOn = true;
                TweenLite.to(this, GlobalAnim.TRANSISITION, {autoAlpha:1});
            } else {
                allOn = false;
                TweenLite.to(this, GlobalAnim.TRANSISITION, {autoAlpha:0});
            }
        }

        if (params.enterFrame == true) {
            _labelHITArea.addEventListener(Event.ENTER_FRAME, rotateOnEnterFrame, false, 0, true);
        } else {
            _labelHITArea.removeEventListener(Event.ENTER_FRAME, rotateOnEnterFrame);
        }

        if (params.closeOtherCallouts == true && params.state != _stateName) {
                isClickActive = false;
                alphaOff();
                close();
        }

        if (params.allClose == true) {
            isClickActive = false;
            alphaOff();
            close();
        }

        if (params.to != null) {
            _targetRotationYAxis = this.normalizeRotation(params.to);
        }
        updateParams = params;
    }


    public function set adjustingPositionCallBack(func:Function):void {
        _adjustPositionCallBack = func;
    }


    private function normalizeRotation(value:Number):Number {
        return -((value - _activeYRotation) * 2);
    }

    private function rotateOnEnterFrame(event:Event):void {


        if (isRotatedWithinRange) {

            //Change opacity
            alphaOn();


            if (COUNTERROTATE) {
                this.rotationY = -_targetRotationYAxis;
            } else {
                this.rotationY = 0;
            }

            if (ROTATE) {
                this.parent.rotationY = _targetRotationYAxis;
            }


        } else {
            if (!isMouseOver) {
                alphaOff();
            }

//            close();
        }
        if (_targetRotationYAxis <= _minRotation) {
//            _closeOverride = false;
//            close(null);
            if (COUNTERROTATE) {
                this.rotationY = -_minRotation;
            } else {
                this.rotationY = 0;
            }

            if (ROTATE) {
                this.parent.rotationY = _minRotation;
            }
        }

        if (_targetRotationYAxis >= _maxRotation) {
//            _closeOverride = false;
//            close(null);
            if (COUNTERROTATE) {
                this.rotationY = -_maxRotation;
            } else {
                this.rotationY = 0;
            }

            if (ROTATE) {
                this.parent.rotationY = _maxRotation;
            }
        }
/*

        var alphaRange:Number = 1 - _minOpacity;
        var alphaStep:Number = alphaRange / _maxRotation;
        var finalAlpha:Number = 1 - (alphaStep * Math.abs(this.parent.rotationY));
        this.alpha = finalAlpha;
*/


        //TODO this should be done in the observer
        if (_hitTestTargetAbove != null && !isRotatedWithinRange) {

            var targetPoint:Point = _hitTestTargetAbove.areaTextBackground.globalToLocal(new Point(0, 0));
            var marginBetweenObjects:Number = -20; //do not count for glow effect as margin

            var referencehitTestTargetPos:Number = targetPoint.y + _hitTestTargetAbove.areaTextBackground.height + marginBetweenObjects;


            if (targetPoint.x < (this.x + this.labelOffBackground.width) && referencehitTestTargetPos > this.vars.y) {
                this.y = referencehitTestTargetPos;
            } else {
                TweenLite.to(this, GlobalAnim.TRANSISITION, {y: this.vars.y});
            }
        }
/*

        if (_hitTextTargetBelow != null && !isRotatedWithinRange) {

            var targetPoint:Point = _hitTextTargetBelow.globalToLocal(new Point(0, 0));
            var marginBetweenObjects:Number = -20; //do not count for glow effect as margin

            var referencehitTestTargetPos:Number = this.y + this.areaTextBackground.height + marginBetweenObjects;

            if (referencehitTestTargetPos > targetPoint.y) {
                this.y = referencehitTestTargetPos;
            } else {
                TweenLite.to(this, GlobalAnim.TRANSISITION, {y: this.vars.y});
            }
        }
*/


        if (redrawLine) {
            this.drawVertical = this.localTargetPoint.y;
        }
//        }
        _cachedRotationYAxis = _targetRotationYAxis;
    }

    public function set hitTestTargetAbove(target:CallOut):void {
        _hitTestTargetAbove = target;
    }

    public function set container(sprite:MovieClip):void {
        _container = sprite;
    }

    public function get container():MovieClip {
        return _container;
    }

    public function set lineToTarget(value:DisplayObject):void {
        _lineToTarget = value;
    }

    public function set activeTarget(value:DisplayObject):void {
        _activeTarget = value;
    }

    public function set calloutTarget(value:DisplayObject):void {
        _calloutTarget = value;
    }

 /*   public function set slider(slider:Slider):void {
//        _slider = slider;
//        _slider.onComplete = this.expand;

    }*/


    public function get isRotatedWithinRange():Boolean {
        return ((_targetRotationYAxis > _minRotation) && (_targetRotationYAxis < _maxRotation)) ? true : false;
    }

    private function get isRotatedToPosition():Boolean {
        return (_slider.last_dispatched_value == _activeYRotation) ? true : false;
    }

    public function get targetRotationYAxis():Number {
        return _targetRotationYAxis;
    }

    public function set targetRotationYAxis(value:Number):void {
        _targetRotationYAxis = value;
    }

    public function get areaTextBackground():CallOutOnBackgroundAreaText {
        return _areaTextBackground;
    }

    public function get isExpanded():Boolean {
        return _isExpanded;
    }

    public function set hitTextTargetBelow(value:CallOut):void {
        _hitTextTargetBelow = value;
    }

    public function get labelOffBackground():CallOutOnLabelBackground {
        return _labelOffBackground;
    }

    override public function setTweenToFunc(func:Function):void {
        super.setTweenToFunc(func);

        if (_initState == EXPANDED) {
            _isExpanded = false;
            _sendToSubjectVars.tweenTo = _activeYRotation;
            _sendToSubjectVars.allClose = false;
            _sendToSubjectVars.closeOtherCallouts = true;
            isClickActive = true;
            expand();
            this.callTweenTo();
        } else {
            alphaOff();
        }

    }
}
}
