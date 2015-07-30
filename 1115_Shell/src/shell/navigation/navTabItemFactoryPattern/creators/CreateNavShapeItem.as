/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 9:21 AM
 * To change this template use File | Settings | File Templates.
 */
package shell.navigation.navTabItemFactoryPattern.creators {
import shell.navigation.navTabItemFactoryPattern.abstractCreators.AbstractShapeCreator;
import shell.navigation.navTabItemFactoryPattern.abstractWidgets.AbstractShapeWidget;
import shell.navigation.navTabItemFactoryPattern.concrete.ConcreteNavItemBackgroundWidget;
import shell.navigation.navTabItemFactoryPattern.concrete.ConcreteNavItemHoverWidget;
import shell.navigation.navTabItemFactoryPattern.concrete.ConcreteNavItemIconWidget;

public class CreateNavShapeItem extends AbstractShapeCreator{

    public static const BACKGROUND  :uint = 0;
    public static const HOVER       :uint = 1;
    public static const ICON         :uint = 2;

    override public function createElement(_type:uint, vars:Object = null):AbstractShapeWidget {
        if (_type === BACKGROUND) {
            return new ConcreteNavItemBackgroundWidget();
        } else if (_type === HOVER) {
            return new ConcreteNavItemHoverWidget();
        } else if (_type === ICON) {
            return new ConcreteNavItemIconWidget();
        } else {
            return null;
        }
        return null;
    }
}
}
