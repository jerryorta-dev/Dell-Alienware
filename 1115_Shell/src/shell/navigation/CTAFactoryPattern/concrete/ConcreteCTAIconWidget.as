/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 9:36 AM
 * To change this template use File | Settings | File Templates.
 */
package shell.navigation.CTAFactoryPattern.concrete {
import flash.display.MovieClip;

import shell.navigation.CTAFactoryPattern.abstractWidgets.AbstractShapeWidget;

public class ConcreteCTAIconWidget extends AbstractShapeWidget {

    override public function drawWidget(vars:Object = null):void {
        var icon:MovieClip = new shell_menu_icons()[vars.icon];
        this.addChild(icon);
        icon.x = icon.y = 0;
    }

}
}
