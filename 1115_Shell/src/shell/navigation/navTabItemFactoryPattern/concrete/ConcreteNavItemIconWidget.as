/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 9:36 AM
 * To change this template use File | Settings | File Templates.
 */
package shell.navigation.navTabItemFactoryPattern.concrete {
import flash.display.MovieClip;
import shell_menu_icons;

import shell.navigation.navTabItemFactoryPattern.abstractWidgets.AbstractShapeWidget;

public class ConcreteNavItemIconWidget extends AbstractShapeWidget {

    private var vars:Object;



    override public function drawWidget(vars:Object = null):void {
        this.vars = (vars != null) ? vars : {};

        //this is a sprite container
        this.name = vars.icon;

        var icon:MovieClip = new shell_menu_icons()[vars.icon];
        this.addChild(icon);
        icon.x = icon.y = 0;

    }

}
}
