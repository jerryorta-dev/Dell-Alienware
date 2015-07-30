/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 6/4/13
 * Time: 4:55 AM
 * To change this template use File | Settings | File Templates.
 */
package commandCenter.uiFactoryPattern {
import flash.display.Sprite;
import flash.events.Event;

import commandCenter.uiFactoryPattern.abstractCreators.AbstractTextFieldCreator;
import commandCenter.uiFactoryPattern.creators.CreateTextField;

public class CreateDescriptionText extends Sprite {
    private var vars:Object;
    public function CreateDescriptionText(vars:Object) {
        this.vars = (vars != null) ? vars : {};
        this.name = vars.name;
        this.alpha = 0;

        init();
    }

    private function init(event:Event = null):void {

        var tf:AbstractTextFieldCreator = new CreateTextField();
        var titleParams:Object = {};
        titleParams.name = "title";
        titleParams.xmlNode = vars.xmlNode;
        tf.draw(CreateTextField.TITLE, this, 0, 0, titleParams);

        var df:AbstractTextFieldCreator = new CreateTextField();
        var descParams:Object = {};
        descParams.name = "description";
        descParams.xmlNode = vars.xmlNode;
        df.draw(CreateTextField.DESCRIPTION, this, 0, 26, descParams);

    }
}
}
