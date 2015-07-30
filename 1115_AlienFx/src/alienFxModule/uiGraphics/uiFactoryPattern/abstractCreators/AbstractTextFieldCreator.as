/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/24/13
 * Time: 4:03 PM
 * To change this template use File | Settings | File Templates.
 */
package alienFxModule.uiGraphics.uiFactoryPattern.abstractCreators {
import alienFxModule.uiGraphics.*;


import flash.display.Sprite;
import flash.errors.IllegalOperationError;

import alienFxModule.uiGraphics.uiFactoryPattern.abstractWidgets.AbstractTextFieldWidget;


public class AbstractTextFieldCreator {

    public function draw(_type:uint, target:Sprite, xLoc:Number, yLoc:Number, vars:Object = null):void {
        var  eleement:* = this.createElement(_type, vars);
        eleement.drawWidget(vars);
        eleement.setLoc(xLoc, yLoc); // set the x and y location
        target.addChild(eleement); // add the sprite to the display list
    }

    public function createElement(_type:uint, vars:Object = null):AbstractTextFieldWidget {
        throw new IllegalOperationError("Abstract method: must be overridden in a subclass");
        return null;
    }
}
}