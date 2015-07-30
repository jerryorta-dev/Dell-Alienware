/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/28/13
 * Time: 2:26 AM
 * To change this template use File | Settings | File Templates.
 */
package shell.uiGraphics {
import flash.display.MovieClip;

public class Containers {
    public static function createModuleContainer(_name:String):MovieClip {
        var mc:MovieClip = new MovieClip();
        mc.name = _name;
        mc.graphics.clear();
        mc.graphics.lineStyle(0, 0x000000, 0);
        mc.graphics.beginFill(0x000000, 0)
        mc.graphics.drawRect(0, 0, 965, 500);
        mc.graphics.endFill();
        mc.x = 0;
        mc.y = 0;
        mc.alpha = 0;
        mc.visible = false;

        return mc;
    }
}
}
