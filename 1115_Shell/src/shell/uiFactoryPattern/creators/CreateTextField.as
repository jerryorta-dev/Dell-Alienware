/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 9:21 AM
 * To change this template use File | Settings | File Templates.
 */
package shell.uiFactoryPattern.creators {

import shell.uiFactoryPattern.abstractCreators.AbstractTextFieldCreator;
import shell.uiFactoryPattern.abstractWidgets.AbstractTextFieldWidget;
import shell.uiFactoryPattern.concrete.Concrete_DesignedFor_TextFieldWidget;
import shell.uiFactoryPattern.concrete.Concrete_Title_TextFieldWidget;
import shell.uiFactoryPattern.concrete.ConcreteIntroCTATextFieldWidget;
import shell.uiFactoryPattern.concrete.Concrete_VICTORY_TextFieldWidget;
import shell.uiFactoryPattern.concrete.Concrete_Description_TextFieldWidget;


public class CreateTextField extends AbstractTextFieldCreator {

    public static const DESCRIPTION         :uint = 0;

    public static const VICTORY             :uint = 1;

    public static const DESIGNED_FOR        :uint = 2;

    public static const INTRO_TITLE         :uint = 3;

    public static const INTRO_CTA           :uint = 4;


    override public function createElement(_type:uint, vars:Object = null):AbstractTextFieldWidget {
        if (_type === DESCRIPTION) {
            return new Concrete_Description_TextFieldWidget();
        } else if (_type === VICTORY) {
            return new Concrete_VICTORY_TextFieldWidget();
        } else if (_type === DESIGNED_FOR) {
            return new Concrete_DesignedFor_TextFieldWidget();
        } else  if (_type === INTRO_TITLE) {
            return new Concrete_Title_TextFieldWidget();
        } else  if (_type === INTRO_CTA) {
            return new ConcreteIntroCTATextFieldWidget();
        }else {
            return null;
        }
        return null;
    }
}
}
