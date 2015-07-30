/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/26/13
 * Time: 2:26 PM
 * To change this template use File | Settings | File Templates.
 */
package shell.navigation.navTabItemFactoryPattern.abstractCreators {
import flash.display.Sprite;

//Abstract
public class AbstractNavItem extends Sprite {

    protected var _callSubject:Function;
    protected var _sendToSubjectVars:Object;

    public function AbstractNavItem() {
        super();

        this._sendToSubjectVars = {};
    }

    public function callSubject():void {
//        if (updateParams.state != this._sendToSubjectVars.state) {
        _callSubject.apply(null, [_sendToSubjectVars]);
//        }
    }

}
}
