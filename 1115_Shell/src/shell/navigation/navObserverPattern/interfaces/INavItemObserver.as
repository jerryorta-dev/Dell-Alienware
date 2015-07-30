/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/15/13
 * Time: 3:50 PM
 * To change this template use File | Settings | File Templates.
 */
package shell.navigation.navObserverPattern.interfaces
{
import flash.events.MouseEvent;

//Observer Interface
    public interface INavItemObserver {
        function notify(params:Object):void;
        function callSubject():void;
    }
}
