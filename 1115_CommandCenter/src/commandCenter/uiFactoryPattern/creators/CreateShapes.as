/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 9:21 AM
 * To change this template use File | Settings | File Templates.
 */
package commandCenter.uiFactoryPattern.creators {

import commandCenter.uiFactoryPattern.abstractCreators.AbstractShapeCreator;
import commandCenter.uiFactoryPattern.abstractWidgets.AbstractShapeWidget;
import commandCenter.uiFactoryPattern.concrete.ConcreteSubNavWidget;

public class CreateShapes extends AbstractShapeCreator {

    public static const SUB_NAV         :uint = 0;



    override public function createElement(_type:uint, vars:Object = null):AbstractShapeWidget {
        if (_type === SUB_NAV) {
            return new ConcreteSubNavWidget();
        } else {
            return null;
        }
        return null;
    }
}
}
