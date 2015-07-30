/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/28/13
 * Time: 2:37 PM
 * To change this template use File | Settings | File Templates.
 */
package alienFxModule.swatches.swatchObserverPattern.cocncrete {
import alienFxModule.Omniture.Tracking;
import alienFxModule.swatches.swatchObserverPattern.abstract.NavNotifyProps;
import alienFxModule.swatches.swatchObserverPattern.interfaces.ISwatchObserver;
import alienFxModule.swatches.swatchStatePattern.abstract.graphics.Swatch;

import com.dell.alienFx.GlobalAnim;
import com.dell.services.TrackEvent;

import com.greensock.TweenLite;

import flash.display.Sprite;
import flash.events.MouseEvent;

public class SwatchObserver extends Sprite implements ISwatchObserver{

    private var _target:Swatch;
    protected var _stateName:String;
    protected var _callSubject:Function;
    protected var _sendToSubjectVars:Object;

    public function SwatchObserver(target:*, vars:Object = null) {
        _target = target;
        _stateName = vars.stateName;

        this._sendToSubjectVars = {};
        this._sendToSubjectVars[NavNotifyProps.STATE] = this._stateName;
        _sendToSubjectVars.activeState = this._stateName;

        _target.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
//        _target.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
    }

    public function notify(params:Object):void
    {
        //SET STATE
//        trace("state sent to observer from: " + params.state + " To: " + this._stateName);
        if (params.activeState != this._stateName) {
//            TweenLite.killTweensOf(_target);
//            TweenLite.to(_target, GlobalAnim.TRANSISITION/1, {strokeAlpha:0});
            _target.setState( _target.state.getOFFSwatchState() );
        } else {

        }
    }

    public function setCallSubectFunction(func:Function):void {
        _callSubject = func;
    }

    public function onMouseDown(event:MouseEvent):void {

        var tEvt:TrackEvent = new TrackEvent("AlienFx","Swatch-" + this._stateName );
        alienFxModule.Omniture.Tracking.trackMetrics(tEvt);

        callSubject();
    }

    public function callSubject():void {
//        _target.state.ON();
//        if (updateParams.state != this._sendToSubjectVars.state) {
        _callSubject.apply(null, [_sendToSubjectVars]);
//        }
    }
}
}
