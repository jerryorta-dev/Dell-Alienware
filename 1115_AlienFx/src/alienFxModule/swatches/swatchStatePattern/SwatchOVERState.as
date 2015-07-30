/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/28/13
 * Time: 1:30 PM
 * To change this template use File | Settings | File Templates.
 */
package alienFxModule.swatches.swatchStatePattern {
import com.dell.alienFx.GlobalAnim;
import com.greensock.TweenLite;

import alienFxModule.swatches.swatchStatePattern.abstract.Context_Swatches;
import alienFxModule.swatches.swatchStatePattern.abstract.IState_Swatch;
import alienFxModule.swatches.swatchStatePattern.abstract.graphics.Swatch;

public class SwatchOVERState implements IState_Swatch {

    private var context:Context_Swatches
    private var target:Swatch;


    public function SwatchOVERState(_constext:Context_Swatches, _target:Swatch) {

        this.context = _constext;
        this.target = _target;
    }

    public function ON():void {
        TweenLite.to(target, GlobalAnim.TRANSISITION/2, {strokeAlpha:1});
        context.setState( context.getONSwatchState() );
    }

    public function OFF():void {
        TweenLite.to(target, GlobalAnim.TRANSISITION/2, {strokeAlpha:0});
        context.setState( context.getOFFSwatchState() );
    }

    public function OVER():void {

    }
}
}
