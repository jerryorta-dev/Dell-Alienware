/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 9:21 AM
 * To change this template use File | Settings | File Templates.
 */
package shell.navigation.CTAFactoryPattern.creators {
import shell.navigation.CTAFactoryPattern.abstractCreators.AbstractTextFieldCreator;
import shell.navigation.CTAFactoryPattern.abstractWidgets.AbstractTextFieldWidget;
import shell.navigation.CTAFactoryPattern.concrete.ConcreteCTATextFieldWidget;

public class CreateCTATextFieldItem extends AbstractTextFieldCreator{

    public static const TITLE  :uint = 0;


    override public function createElement(_type:uint, vars:Object = null):AbstractTextFieldWidget {
        if (_type === TITLE) {
            return new ConcreteCTATextFieldWidget();
        }  else {
            return null;
        }
        return null;
    }
}
}
