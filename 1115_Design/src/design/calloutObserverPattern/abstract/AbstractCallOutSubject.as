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
public class AbstractCallOutSubject {
    protected var vars:Object;

    public function AbstractCallOutSubject(vars:Object = null) {

        this.vars = (vars != null) ? vars : {};
        init();
    }

    protected function init():void {

    }
}
}
