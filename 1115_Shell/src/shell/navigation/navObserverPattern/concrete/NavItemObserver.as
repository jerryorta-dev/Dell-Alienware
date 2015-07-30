/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/15/13
 * Time: 3:52 PM
 * To change this template use File | Settings | File Templates.
 */
package shell.navigation.navObserverPattern.concrete {
import com.dell.alienFx.GlobalAnim;
import com.dpa.interactive.TopLevel;
import com.greensock.TweenLite;
import com.greensock.TweenMax;

import flash.display.MovieClip;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;



import shell.navigation.navObserverPattern.abstract.NavNotifyProps;
import shell.navigation.navObserverPattern.interfaces.INavItemObserver;
import shell.navigation.navTabItemFactoryPattern.CreateNavItem;

public class NavItemObserver extends Sprite implements INavItemObserver {

    //STATES
    private var _target:CreateNavItem;

    protected var _stateName:String;
    protected var _callSubject:Function;
    protected var _callSubjectTweenTo:Function;
    protected var _sendToSubjectVars:Object;
    protected var updateParams:Object = {};

    private var _referenceMC:MovieClip;
    private var _referenceContainer:MovieClip;

    public function NavItemObserver(target:*, vars:Object = null) {

        _target = target;
        _stateName = vars.stateName;

        this._sendToSubjectVars = {};
        this._sendToSubjectVars[NavNotifyProps.STATE] = this._stateName;

        _target.hitBox.addEventListener(MouseEvent.CLICK, onMouseDown, false, 0, true);

    }

      //notifyer updates this method
    public function notify(params:Object):void
    {
         //SET STATE
//        trace("state sent to observer from: " + params.state + " To: " + this._stateName);
        if (params.activeState != this._stateName) {

            //Changes call out
            _target.setState( _target.state.getOffButtonState() );

            if (_referenceMC != null) {

                TweenMax.killTweensOf(_referenceContainer, {alpha:true, visible:true});


                TweenMax.to(_referenceContainer, GlobalAnim.TRANSISITION, {autoAlpha:0});
                _referenceMC.callChildFromParent({transitionOff:true});
            }
        } else {
            if (_referenceMC != null) {
//                TweenMax.killAll(true);
                TweenMax.killTweensOf(_referenceContainer, {alpha:true, visible:true});
                TweenMax.to(_referenceContainer, GlobalAnim.TRANSISITION, {delay:GlobalAnim.TRANSISITION, autoAlpha:1});
                _referenceMC.callChildFromParent({transitionOn:true});
            }
        }
    }

    public function addSWF( _rootSWFContainer:MovieClip, _container:MovieClip ):void {
        _referenceMC = _rootSWFContainer;
        _referenceContainer = _container;
    }

    /**
     * Callback function to call Subject
     * @param func
     */
    public function setCallSubectFunction(func:Function):void {
        _callSubject = func;
    }

    public function onMouseDown(event:MouseEvent):void {
        _sendToSubjectVars.activeState = this._stateName;
        callSubject();
    }

    public function callSubject():void {
        _target.state.ON();
//        if (updateParams.state != this._sendToSubjectVars.state) {
            _callSubject.apply(null, [_sendToSubjectVars]);
//        }
    }



}
}
