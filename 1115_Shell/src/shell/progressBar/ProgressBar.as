/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 6/6/13
 * Time: 6:00 PM
 * To change this template use File | Settings | File Templates.
 */
package shell.progressBar {
import com.greensock.events.LoaderEvent;

import flash.display.Sprite;

public class ProgressBar extends Sprite{

    private var vars:Object;

    private var _maxHeight:Number;
    private var _borderWeight:Number = 1;
    private var _maxWidth:Number;
    private var _borderColor:uint = 0x074607;
    private var _fillColor:uint = 0x34fd39;
    private var _progressWidth:Number = 0;

    public function ProgressBar(vars:Object = null) {
        this.vars = ( vars != null ) ? vars : {};
        _maxWidth = (this.vars.maxWidth != null) ? this.vars.maxWidth : 328;
        _maxHeight = (this.vars.maxHeight != null) ? this.vars.maxHeight : 10;
        _progressWidth = 0;
    }




    private function paint():void {
        graphics.clear();

        graphics.beginFill(_fillColor, 1);
        graphics.drawRect(0, 0, _progressWidth, _maxHeight);
        graphics.endFill();


        graphics.lineStyle(_borderWeight, _borderColor,1);
        graphics.beginFill(0x000000, 0);
        graphics.drawRect(0, 0, _maxWidth, _maxHeight);
        graphics.endFill();
    }

    public function progress(value:Number):void {
        _progressWidth = _maxWidth * value;
        paint();
    }
}
}
