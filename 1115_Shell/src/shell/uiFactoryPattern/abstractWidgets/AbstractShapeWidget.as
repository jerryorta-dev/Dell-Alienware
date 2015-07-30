/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/24/13
 * Time: 4:06 PM
 * To change this template use File | Settings | File Templates.
 */
package shell.uiFactoryPattern.abstractWidgets {
import flash.display.Sprite;

// ABSTRACT Class (should be subclassed and not instantiated)
public class AbstractShapeWidget extends Sprite {

    // ABSTRACT Method (should be implemented in subclass)
    public function drawWidget(vars:Object = null):void {
    }


    // method to set the x and y location of the sprite
    public function setLoc(xLoc:int, yLoc:int):void {
        this.x = xLoc;
        this.y = yLoc;
    }
}
}
