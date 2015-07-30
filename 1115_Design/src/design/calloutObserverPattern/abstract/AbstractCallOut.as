/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/15/13
 * Time: 11:18 PM
 * To change this template use File | Settings | File Templates.
 */
package design.calloutObserverPattern.abstract {
import flash.display.Sprite;
import flash.events.Event;

//Just in case I need this in the future
public class AbstractCallOut extends Sprite {
    protected var vars:Object;
    protected var _unscaledWidth:Number;

    public function AbstractCallOut(vars:Object = null) {

        this.vars = (vars != null) ? vars : {};

        if (this.stage) {
            init();
        } else {
            this.addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
        }
    }

    protected function init(e:Event = null):void {

    }

    public function get unscaledWidth():Number {
        return _unscaledWidth;
    }
}
}
