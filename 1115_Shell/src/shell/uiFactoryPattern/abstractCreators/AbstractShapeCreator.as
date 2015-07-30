/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/24/13
 * Time: 4:03 PM
 * To change this template use File | Settings | File Templates.
 */
package shell.uiFactoryPattern.abstractCreators {
import flash.display.Sprite;
import flash.errors.IllegalOperationError;

import shell.uiFactoryPattern.abstractWidgets.AbstractShapeWidget;

public class AbstractShapeCreator {

    public function draw(_type:uint, target:Sprite, xLoc:Number, yLoc:Number, vars:Object = null):void {
        var  element:* = this.createElement(_type, vars);
        element.drawWidget(vars);
        element.setLoc(xLoc, yLoc); // set the x and y location
        target.addChild(element); // add the sprite to the display list
    }

    public function createElement(_type:uint, vars:Object = null):AbstractShapeWidget {
        throw new IllegalOperationError("Abstract method: must be overridden in a subclass");
        return null;
    }
}
}