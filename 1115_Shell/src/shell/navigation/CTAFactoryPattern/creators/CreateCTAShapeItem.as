/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 9:21 AM
 * To change this template use File | Settings | File Templates.
 */
package shell.navigation.CTAFactoryPattern.creators {
import shell.navigation.CTAFactoryPattern.abstractCreators.AbstractShapeCreator;
import shell.navigation.CTAFactoryPattern.abstractWidgets.AbstractShapeWidget;
import shell.navigation.CTAFactoryPattern.concrete.ConcreteCTABackgroundWidget;
import shell.navigation.CTAFactoryPattern.concrete.ConcreteCTAIconWidget;

public class CreateCTAShapeItem extends AbstractShapeCreator{

    public static const BACKGROUND  :uint = 0;
//    public static const HOVER       :uint = 1;
    public static const ICON         :uint = 2;

    override public function createElement(_type:uint, vars:Object = null):AbstractShapeWidget {
        if (_type === BACKGROUND) {
            return new ConcreteCTABackgroundWidget();
//        } else if (_type === HOVER) {
//            return new ConcreteNavItemHoverWidget();
        } else if (_type === ICON) {
            return new ConcreteCTAIconWidget();
        } else {
            return null;
        }
        return null;
    }
}
}
