/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/15/13
 * Time: 3:47 PM
 * To change this template use File | Settings | File Templates.
 */
package design.calloutObserverPattern.interfaces {
import design.calloutObserverPattern.observers.ConcreteCallOutObserver;

import design.calloutObserverPattern.observers.CallOut;

//Subject Interface
    public interface ICallOutSubject
    {
        function addObserver(  observer : CallOut , aspect : Function ):Boolean;
        function removeObserver( observer : CallOut ):Boolean;
        function notifyObserver(  ):void;
    }
}
