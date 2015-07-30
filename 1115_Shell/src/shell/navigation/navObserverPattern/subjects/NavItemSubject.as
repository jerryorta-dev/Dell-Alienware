/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/26/13
 * Time: 10:32 AM
 * To change this template use File | Settings | File Templates.
 */
package shell.navigation.navObserverPattern.subjects {
import com.dpa.utils.objects.union;

import flash.utils.Dictionary;

import shell.navigation.navItemStates.abstract.Context_NavItem_States;

import shell.navigation.navObserverPattern.concrete.NavItemObserver;
import shell.navigation.navObserverPattern.interfaces.INavSubject;
import shell.navigation.navObserverPattern.abstract.NavNotifyProps;

public class NavItemSubject implements INavSubject{

    protected var _dictObserver:Dictionary;

    private var _state:String;
    private var _eventVars:Object;

    public function NavItemSubject() {
        _dictObserver = new Dictionary(false);
        _eventVars = {};
    }

    public function notifyObserver( ):void
    {
        for (var observer:* in _dictObserver)
        {
            observer.notify( _eventVars )
        }

//        _eventVars.action = null;
//        _eventVars.enterFrame = false;
//        _eventVars.allClose = false;
//        _eventVars.closeOtherCallouts = false;
//        _eventVars.isExpanded = false;
//        _eventVars.allOn = true;
////        _eventVars.allOn = true;
    }

    public function addObserver(observer:NavItemObserver):void {

        observer.setCallSubectFunction( this.setState );

        _dictObserver[observer] = observer;

    }

    public function removeObserver( observer:NavItemObserver ):void
    {
        _dictObserver[observer] = null;
        delete _dictObserver[observer];


    }

    public function setState( observerVars:Object ):void {
        this._eventVars = union(this._eventVars, observerVars);

        this._state = observerVars[NavNotifyProps.STATE];
//        trace("this state: " + this._state);
//        this._eventVars.closeOtherCallouts = observerVars.closeOtherCallouts;
        this._eventVars[NavNotifyProps.STATE] = observerVars[NavNotifyProps.STATE];

        notifyObserver();
    }

    public function getState():String {
        return _state;
    }

}
}
