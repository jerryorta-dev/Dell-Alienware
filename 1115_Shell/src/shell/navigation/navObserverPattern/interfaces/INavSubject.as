/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/15/13
 * Time: 3:47 PM
 * To change this template use File | Settings | File Templates.
 */
package shell.navigation.navObserverPattern.interfaces {
import shell.navigation.navObserverPattern.concrete.NavItemObserver;

//Subject Interface
    public interface INavSubject
    {
        function addObserver(  observer : NavItemObserver ):void;
        function removeObserver( observer : NavItemObserver ):void;
        function notifyObserver(  ):void;
    }
}
