/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/15/13
 * Time: 3:50 PM
 * To change this template use File | Settings | File Templates.
 */
package alienFxModule.swatches.swatchObserverPattern.interfaces
{
import flash.events.MouseEvent;

//Observer Interface
    public interface ISwatchObserver {
        function notify(params:Object):void;
        function callSubject():void;
    }
}
