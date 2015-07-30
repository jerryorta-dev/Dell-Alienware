/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 9:21 AM
 * To change this template use File | Settings | File Templates.
 */
package shell.navigation.navTabItemFactoryPattern.creators {

import shell.navigation.navTabItemFactoryPattern.abstractCreators.AbstractTextFieldCreator;
import shell.navigation.navTabItemFactoryPattern.abstractWidgets.AbstractTextFieldWidget;

import shell.navigation.navTabItemFactoryPattern.concrete.ConcreteNavItemTextFieldWidget;

public class CreateNavTextFieldItem extends AbstractTextFieldCreator{

    public static const TITLE  :uint = 0;


    override public function createElement(_type:uint, vars:Object = null):AbstractTextFieldWidget {
        if (_type === TITLE) {
            return new ConcreteNavItemTextFieldWidget();
        }  else {
            return null;
        }
        return null;
    }
}
}
