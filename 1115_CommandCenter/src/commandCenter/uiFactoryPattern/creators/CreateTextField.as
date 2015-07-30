/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 9:21 AM
 * To change this template use File | Settings | File Templates.
 */
package commandCenter.uiFactoryPattern.creators {

import commandCenter.uiFactoryPattern.abstractCreators.AbstractTextFieldCreator;
import commandCenter.uiFactoryPattern.abstractWidgets.AbstractTextFieldWidget;
import commandCenter.uiFactoryPattern.concrete.ConcreNAVTextFieldWidget;
import commandCenter.uiFactoryPattern.concrete.ConcreteDescriptionTextFieldWidget;
import commandCenter.uiFactoryPattern.concrete.ConcreteTitleTextFieldWidget;

public class CreateTextField extends AbstractTextFieldCreator {

    public static const DESCRIPTION         :uint = 0;

    public static const TITLE               :uint = 1;

    public static const NAV_TEXT            :uint = 2;


    override public function createElement(_type:uint, vars:Object = null):AbstractTextFieldWidget {
        if (_type === DESCRIPTION) {
            return new ConcreteDescriptionTextFieldWidget();
        } else if (_type === TITLE) {
            return new ConcreteTitleTextFieldWidget();
        } else if (_type === NAV_TEXT) {
            return new ConcreNAVTextFieldWidget();
        }else {
            return null;
        }
        return null;
    }
}
}
