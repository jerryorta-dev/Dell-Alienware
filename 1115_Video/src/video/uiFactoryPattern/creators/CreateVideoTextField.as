/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 9:21 AM
 * To change this template use File | Settings | File Templates.
 */
package video.uiFactoryPattern.creators {

import video.uiFactoryPattern.abstractCreators.AbstractTextFieldCreator;
import video.uiFactoryPattern.abstractWidgets.AbstractTextFieldWidget;
import video.uiFactoryPattern.concrete.ConcreteTitleTextFieldWidget;


public class CreateVideoTextField extends AbstractTextFieldCreator{

    public static const TITLE  :uint = 0;

    override public function createElement(_type:uint, vars:Object = null):AbstractTextFieldWidget {
        if (_type === TITLE) {
            return new ConcreteTitleTextFieldWidget();
        } else {
            return null;
        }
        return null;
    }
}
}
