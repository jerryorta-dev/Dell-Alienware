/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/28/13
 * Time: 2:43 PM
 * To change this template use File | Settings | File Templates.
 */
package alienFxModule.swatches.swatchObserverPattern.subjects {
import com.dell.alienFx.ConfigGlobal;
import com.dell.alienFx.GlobalAnim;
import com.dpa.utils.objects.union;
import com.greensock.TweenLite;
import com.greensock.TweenMax;

import flash.display.MovieClip;

import flash.events.MouseEvent;

import flash.utils.Dictionary;

import alienFxModule.swatches.swatchObserverPattern.abstract.NavNotifyProps;
import alienFxModule.swatches.swatchObserverPattern.cocncrete.SwatchObserver;
import alienFxModule.swatches.swatchObserverPattern.interfaces.ISwatchObserver;
import alienFxModule.swatches.swatchObserverPattern.interfaces.ISwatchSubject;

public class SwatchSubject implements ISwatchSubject{

    protected var _dictObserver:Dictionary;
    protected var _callSubject:Function;
    private var _state:String;
    private var _eventVars:Object;
    private var _activeZone:MovieClip;

    public function SwatchSubject() {

        _dictObserver = new Dictionary(false);
        _eventVars = {};


    }

    public function setActiveZone(_zone:MovieClip):void {
        _activeZone = _zone;
    }

    public function notifyObserver():void {
        //Color Zone
//        TweenLite.to(_activeZone, GlobalAnim.TRANSISITION, {tint:_eventVars.state});
        TweenMax.to(_activeZone, (GlobalAnim.TRANSISITION / 2), {glowFilter:{color:_eventVars.state, quality:ConfigGlobal.ALIENFX_QUALITY ,strength:ConfigGlobal.ALIENFX_STRENGTH, alpha:1, blurX:ConfigGlobal.ALIENFX_NUMBER_BLUR , blurY:ConfigGlobal.ALIENFX_NUMBER_BLUR}, tint:_eventVars.state});

        for (var observer:* in _dictObserver)
        {
            observer.notify( _eventVars )
        }
    }

    public function addObserver(observer:SwatchObserver):void {
        observer.setCallSubectFunction( this.setState );
        _dictObserver[observer] = observer;
    }

    public function removeObserver( observer:SwatchObserver ):void
    {
        _dictObserver[observer] = null;
        delete _dictObserver[observer];
    }

    public function setState( observerVars:Object ):void {
        this._eventVars = union(this._eventVars, observerVars);

        this._state = observerVars[NavNotifyProps.STATE];
        this._eventVars[NavNotifyProps.STATE] = observerVars[NavNotifyProps.STATE];

        notifyObserver();
    }





}
}
