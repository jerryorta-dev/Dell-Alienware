/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 9:21 AM
 * To change this template use File | Settings | File Templates.
 */
package alienFxModule.uiGraphics.uiFactoryPattern.creators {
import alienFxModule.uiGraphics.uiFactoryPattern.abstractCreators.AbstractShapeCreator;
import alienFxModule.uiGraphics.uiFactoryPattern.abstractWidgets.AbstractShapeWidget;
import alienFxModule.uiGraphics.uiFactoryPattern.concrete.ConcreteHotSpotWidget;
import alienFxModule.uiGraphics.uiFactoryPattern.concrete.ConcreteResetBackgroundWidget;

public class CreateShape extends AbstractShapeCreator{

    public static const HOTSPOT             :uint = 0;
    public static const RESET_BACKGROUND    :uint = 1;


    override public function createElement(_type:uint, vars:Object = null):AbstractShapeWidget {
        if (_type === HOTSPOT) {
            return new ConcreteHotSpotWidget();
        } if (_type === RESET_BACKGROUND) {
            return new ConcreteResetBackgroundWidget();
        } else {
            return null;
        }
        return null;
    }
}
}
