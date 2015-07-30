/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 9:21 AM
 * To change this template use File | Settings | File Templates.
 */
package gallery.uiFactoryPattern.creators {

import gallery.uiFactoryPattern.abstractCreators.AbstractTextFieldCreator;
import gallery.uiFactoryPattern.abstractWidgets.AbstractTextFieldWidget;
import gallery.uiFactoryPattern.concrete.ConcreteDescriptionTextFieldWidget;
import gallery.uiFactoryPattern.concrete.ConcreteTitleTextFieldWidget;

public class CreateDescriptionTextField extends AbstractTextFieldCreator{

    public static const DESCRIPTION  :uint = 0;

    public static const TITLE :uint = 1;




    override public function createElement(_type:uint, vars:Object = null):AbstractTextFieldWidget {
        if (_type === DESCRIPTION) {
            return new ConcreteDescriptionTextFieldWidget();
        } else if (_type === TITLE) {
            return new ConcreteTitleTextFieldWidget();
        }  else {
            return null;
        }
        return null;
    }
}
}
