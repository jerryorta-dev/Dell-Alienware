/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 6/4/13
 * Time: 10:24 AM
 * To change this template use File | Settings | File Templates.
 */
package commandCenter.uiFactoryPattern.concrete {
import com.dell.alienFx.GlobalAnim;
import com.dell.services.TrackEvent;
import com.dpa.utils.object.addHandCurserNoChildren;
import com.dpa.utils.tracers.traceProps;
import com.greensock.TweenLite;

import commandCenter.Omniture.Tracking;

import flash.display.MovieClip;
import flash.display.Sprite;

import flash.events.MouseEvent;

import commandCenter.uiFactoryPattern.abstractWidgets.AbstractShapeWidget;

public class ConcreteSubNavWidget extends AbstractShapeWidget {

    private var _refNum:int;

    private var navItem:subNavCircle;
    private var _isActivated:Boolean;
    private var _callBack:Function;
    private var _target:String;


    override public function drawWidget(vars:Object = null):void {
//         traceProps(vars);
        navItem = new subNavCircle();
        navItem.x = navItem.y = 0;
        this.addChild(navItem);
        _target = vars.target;
        this.name = vars.name;
        _refNum = vars.refNum;

        _isActivated = (vars.isActive != null) ? vars.isActive : false;

        _callBack = (vars.callBack != null) ? vars.callBack : null;

        addHandCurserNoChildren(navItem);

        addEventHandlers();
    }

    public function addEventHandlers():void {
        navItem.addEventListener(MouseEvent.ROLL_OVER, onRollOver, false, 0, true);
        navItem.addEventListener(MouseEvent.ROLL_OUT, onRollOut, false, 0, true);
        navItem.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
    }


    public function removeEventHandlers():void {
        navItem.removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
        navItem.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
        navItem.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    }

    private function onRollOver(event:MouseEvent):void {
        toggleOn();
    }

    private function onRollOut(event:MouseEvent):void {
        if (!_isActivated) {
            toggleOff();
        }
    }

    private function onMouseDown(event:MouseEvent):void {
        var tEvt1:TrackEvent = new TrackEvent('button','CommandCenter-TabSubNav-' + _refNum);
        commandCenter.Omniture.Tracking.trackMetrics(tEvt1);
        var tEvt2:TrackEvent = new TrackEvent('button','CommandCenter-TabSubNav-' + this.name);
        commandCenter.Omniture.Tracking.trackMetrics(tEvt2);

        if (!_isActivated) {
            _isActivated = true;
            callBack();
            toggleOn();
        }
    }

    private function toggleOn():void {
        TweenLite.to(navItem.ON, GlobalAnim.TRANSISITION /2, {alpha: 1});
    }

    private function toggleOff():void {
        TweenLite.to(navItem.ON, GlobalAnim.TRANSISITION /2, {alpha: 0});
    }

    public function activate(value:Boolean = true):void {
        if (value) {
            _isActivated = true;
            toggleOn();
        } else {
            _isActivated = false;
            toggleOff();
        }

    }

    public function deactivate(value:Boolean = true):void {
        if (value) {
            _isActivated = false;
            toggleOff();
        } else {
            _isActivated = true;
            toggleOn();
        }
    }


    public function get isActivated():Boolean {
        return _isActivated;
    }

    public function set isActivated(value:Boolean):void {
        _isActivated = value;
    }

    private function callBack():void {
        if (_callBack != null) {
            _callBack.apply(null, [_target]);
        }

    }

    public function get ON():MovieClip {
        return navItem.ON;
    }


}
}
