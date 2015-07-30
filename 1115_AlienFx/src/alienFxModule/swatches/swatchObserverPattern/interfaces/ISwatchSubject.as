/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/15/13
 * Time: 3:47 PM
 * To change this template use File | Settings | File Templates.
 */
package alienFxModule.swatches.swatchObserverPattern.interfaces {
import alienFxModule.swatches.swatchObserverPattern.cocncrete.SwatchObserver;


//Subject Interface
    public interface ISwatchSubject
    {
        function addObserver(  observer : SwatchObserver ):void;
        function removeObserver( observer : SwatchObserver ):void;
        function notifyObserver(  ):void;
    }
}
