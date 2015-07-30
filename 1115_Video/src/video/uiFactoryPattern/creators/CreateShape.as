/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 9:21 AM
 * To change this template use File | Settings | File Templates.
 */
package video.uiFactoryPattern.creators {
import video.uiFactoryPattern.abstractCreators.AbstractShapeCreator;
import video.uiFactoryPattern.abstractWidgets.AbstractShapeWidget;
import video.uiFactoryPattern.concrete.ConcreteCallOutBackgroundWidget;

public class CreateShape extends AbstractShapeCreator{

    public static const TITLE_BACKGROUND    :uint = 0;



    override public function createElement(_type:uint, vars:Object = null):AbstractShapeWidget {
        if (_type === TITLE_BACKGROUND) {
            return new ConcreteCallOutBackgroundWidget();
        }  else {
            return null;
        }
        return null;
    }
}
}
