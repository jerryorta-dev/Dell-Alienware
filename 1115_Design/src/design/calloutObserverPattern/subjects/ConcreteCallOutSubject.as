/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/15/13
 * Time: 3:54 PM
 * To change this template use File | Settings | File Templates.
 */
package design.calloutObserverPattern.subjects {
import com.dell.services.TrackEvent;
import com.dpa.utils.objects.union;
import com.dpa.utils.tracers.traceProps;
import com.kenergy.kevents.KsliderEvent;

import design.Omniture.Tracking;

import design.calloutObserverPattern.abstract.AbstractCallOutSubject;
import design.calloutObserverPattern.abstract.NotifyProps;
import design.calloutObserverPattern.interfaces.ICallOutSubject;
import design.calloutObserverPattern.observers.CallOut;
import design.calloutObserverPattern.observers.controls.abstract.Context_Button_ON_OFF;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.utils.Dictionary;

public class ConcreteCallOutSubject extends AbstractCallOutSubject implements ICallOutSubject {

    private var _onCompleteValue:Number;

    private var _swfRoot:MovieClip;
    private var slider:Slider;
//    private var _sliderInitRotation:Number;

    protected var _dict:Dictionary;
    private var _state:String;
    private var _eventVars:Object;

    private var _btnOnOff:Context_Button_ON_OFF;

    public function ConcreteCallOutSubject(vars:Object = null) {


        _dict = new Dictionary(false);
        _eventVars = {};

        //Pass stuff to superclass if needed
        super(vars);

    }

     override protected function init():void {
        super.init();
        this._swfRoot = this.vars.swfRoot;
        this.slider = this.vars.slider;
//        this._sliderInitRotation = this.vars.sliderInitRotation;
         _eventVars.sliderInitRotation = this.vars.sliderInitRotation;

        enableSliderEventHandlers();

    }

    public function removeObserver( observer:CallOut ):Boolean
    {
        _dict[observer] = null;
        delete _dict[observer];
        return true;
    }

    public function addObserver( observer : CallOut , aspect : Function ):Boolean
    {
        observer.setCallSubectFunction( this.setState );
        observer.setTweenToFunc( this.tweenTo );
//        observer.notify({to:this.vars.sliderInitRotation});

        _dict[observer] = observer;

        notifyObserver();

        return true
    }

    public function addOnOFF(observer:Context_Button_ON_OFF):void {
        _btnOnOff = observer;
        observer.setCallSubectFunction( this.setState );
    }

    public function notifyObserver( ):void
    {
        for (var observer:* in _dict)
        {
            observer.notify( _eventVars )
        }

        _eventVars.action = null;
        _eventVars.enterFrame = false;
        _eventVars.allClose = false;
        _eventVars.closeOtherCallouts = false;
        _eventVars.isExpanded = false;
    }

    public function setState( observerVars:Object ):void {
        this._eventVars = union(this._eventVars, observerVars);

        this._state = observerVars[NotifyProps.STATE];
        this._eventVars.closeOtherCallouts = observerVars.closeOtherCallouts;
        this._eventVars[NotifyProps.STATE] = observerVars[NotifyProps.STATE];
//        this._eventVars[NotifyProps.ACTION] = observerVars[NotifyProps.ACTION];
        notifyObserver();
    }

    public function getState():String {
        return _state;
    }


    //CUSTOM PROPERTIES
    private function enableSliderEventHandlers():void {
        this.slider.addEventListener(KsliderEvent.CHANGE, _handle_kslider_change);
        this.slider.addEventListener(KsliderEvent.ON_COMPLETE, onComplete);
        this.slider.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler, false, 0, true);
    }

    private function onMouseDownHandler(event:MouseEvent):void {
        var tEvt:TrackEvent = new TrackEvent('slider','Design-Slider-Scrub');
        design.Omniture.Tracking.trackMetrics(tEvt);
//        trace("Close Observers!!")
//        trace(_state)
        _eventVars.closeOtherCallouts = false;
        _eventVars.allOn = null;
        _eventVars.allClose = true;
        _eventVars.enterFrame = false;
        notifyObserver();
    }



    private function disableSliderEventHandlers():void {
        this.slider.removeEventListener(KsliderEvent.CHANGE, _handle_kslider_change);
        this.slider.removeEventListener(KsliderEvent.ON_COMPLETE, onComplete);
    }

    private function _handle_kslider_change (event:KsliderEvent):void {
        //TODO Current swf
        event.params.tweenToActiveYRotation = false;
        _swfRoot.gotoAndStop(event.params.to);
        _onCompleteValue = event.params.to;
        //TODO Observer pattern
        _eventVars = union(_eventVars, event.params);
        _eventVars.tweenToActiveYPosition = false;
        _eventVars.enterFrame = true;

        notifyObserver();
//            event.params.closeOtherCalloutsOverride = false;
//        for (var j:int = 0; j < 2; j++) {
////            callOutArray[j]["update"] = event.params;
//        }

    }

    private function onComplete (event:KsliderEvent):void {

//        var tEvt:TrackEvent = new TrackEvent('slider','Design-Scrub-to-' + this.slider.mc_value);
//        design.Omniture.Tracking.trackMetrics(tEvt);

        _eventVars = union(_eventVars, event.params);
        _eventVars.tweenToActiveYPosition = true;
        _eventVars.enterFrame = false;


        notifyObserver();
    }

    public function tweenTo(vars:Object):void {
        _eventVars = union(_eventVars, vars);
        _eventVars.enterFrame = true;



        this.slider.tweenTo(_eventVars.tweenTo);

    }






}
}
