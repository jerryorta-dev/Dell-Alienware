/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/16/13
 * Time: 8:02 AM
 * To change this template use File | Settings | File Templates.
 */
package design.calloutObserverPattern.observers {
import flash.display.Sprite;

public class CallOutContainer {
    public static function createLabelContainer(vars:Object):Sprite {
//        trace(vars.width)
        var sp:Sprite = new Sprite;
        sp.graphics.beginFill(vars.color, vars.alpha);
        sp.graphics.drawRect( 0, 0, vars.width, vars.height);
        sp.graphics.endFill();
        return sp;

    }

    public static function createCallOutContainer(vars:Object):Sprite {

//        trace(vars.containerRectangle.width)
//        trace(vars.containerRectangle.height)

        var xPos:Number = 0 - (vars.containerRectangle.width / 2);
        var yPos:Number = 0 - (vars.containerRectangle.height / 2);

//        trace("xPos: " + xPos);

        var sp:Sprite = new Sprite;
        sp.name = vars.containerName;

        sp.graphics.beginFill(vars.containerRectangle.color, vars.containerRectangle.alpha);
        sp.graphics.drawRect( xPos, yPos, vars.containerRectangle.width, vars.containerRectangle.height);
        sp.graphics.endFill();


        return sp;

    }

    public static function addCallOutContainerToLabelContainer(parent:Sprite, child:Sprite):void {
        var xCenter:Number = child.width / 2;
        var yCenter:Number = child.height / 2;

        child.x = xCenter;
        child.y = yCenter;

        parent.addChild(child);
    }
}
}
