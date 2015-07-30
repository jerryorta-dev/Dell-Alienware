/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/15/13
 * Time: 3:52 PM
 * To change this template use File | Settings | File Templates.
 */
package design.calloutObserverPattern.observers {
import design.calloutObserverPattern.abstract.AbstractCallOut;

import design.calloutObserverPattern.abstract.NotifyProps;
import design.calloutObserverPattern.interfaces.ICallOutObserver;

import flash.display.Sprite;
import flash.events.Event;

public class ConcreteCallOutObserver extends AbstractCallOut implements ICallOutObserver {



    //STATES


    protected var _stateName:String;
    protected var _callSubject:Function;
    protected var _callSubjectTweenTo:Function;
    protected var _sendToSubjectVars:Object;
    protected var updateParams:Object = {};

    public function ConcreteCallOutObserver(vars:Object = null) {
        super(vars);
    }

    override protected function init(e:Event = null):void {

        if (this.vars.name != null){
            this.name = this.vars.name;
            this._stateName = this.vars.name;
        } else {
            throw Error("stateName is undefined");
        }

        this._sendToSubjectVars = {};
        this._sendToSubjectVars[NotifyProps.STATE] = this._stateName;
    }

    //notifyer updates this method
    public function notify(params:Object):void
    {
//        trace("Notified: " + params.to);
    }



    /**
     * Callback function to call Subject
     * @param func
     */
    public function setCallSubectFunction(func:Function):void {
        _callSubject = func;
    }

    public function callSubject():void {
        if (updateParams.state != this._sendToSubjectVars.state) {
            _callSubject.apply(null, [_sendToSubjectVars]);
        }
    }

    public function setTweenToFunc(func:Function):void {
        _callSubjectTweenTo = func;
    }

    protected function callTweenTo():void {
        _callSubjectTweenTo.apply(null, [_sendToSubjectVars]);
    }







}
}
