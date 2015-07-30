/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 9:21 AM
 * To change this template use File | Settings | File Templates.
 */
package alienFxModule.uiGraphics.uiFactoryPattern.creators {

import alienFxModule.uiGraphics.uiFactoryPattern.abstractCreators.AbstractTextFieldCreator;
import alienFxModule.uiGraphics.uiFactoryPattern.abstractWidgets.AbstractTextFieldWidget;
import alienFxModule.uiGraphics.uiFactoryPattern.concrete.ConcreteDescriptionTextFieldWidget;
import alienFxModule.uiGraphics.uiFactoryPattern.concrete.ConcreteHideControlsTextFieldWidget;
import alienFxModule.uiGraphics.uiFactoryPattern.concrete.ConcreteResetTextFieldWidget;

public class CreateUITextField extends AbstractTextFieldCreator{

    public static const DESCRIPTION  :uint = 0;

    public static const HIDE_CONTROLS :uint = 1;

    public static const RESET         :uint = 2;


    override public function createElement(_type:uint, vars:Object = null):AbstractTextFieldWidget {
        if (_type === DESCRIPTION) {
            return new ConcreteDescriptionTextFieldWidget();
        }  else if (_type === HIDE_CONTROLS) {
            return new ConcreteHideControlsTextFieldWidget()
        } else if (_type === RESET) {
            return new ConcreteResetTextFieldWidget()
        } else {
            return null;
        }
        return null;
    }
}
}
