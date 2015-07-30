/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/28/13
 * Time: 1:32 PM
 * To change this template use File | Settings | File Templates.
 */
package alienFxModule.swatches.swatchStatePattern.abstract {
import alienFxModule.swatches.swatchStatePattern.*;
import alienFxModule.swatches.swatchStatePattern.abstract.graphics.Swatch;

public class Context_Swatches {

    private var vars:Object;

    private var onState:IState_Swatch;
    private var offState:IState_Swatch;
    private var overState:IState_Swatch;
    private var state:IState_Swatch;

    private var _onStateChange:Function;

    public function Context_Swatches(_target:Swatch, setInitState:String, vars:Object = null) {
        this.vars = (vars != null) ? vars : {};

        _onStateChange = (this.vars.onStateChange != null) ? this.vars.onStateChange : null;

        onState = new SwatchONState(this, _target);
        offState = new SwatchOFFState(this, _target);
        overState = new SwatchOVERState(this, _target);

        if (setInitState == "on") {
            state = onState;
        } else {
            state = offState;
        }



    }

    public function ON():void
    {
        state.ON();
    }
    public function OFF():void
    {
        state.OFF();
    }

    public function OVER():void {
         state.OVER();
    }

    public function setState(state:IState_Swatch):void
    {
        this.state=state;
        this.onStateChange();
    }
    public function getState():IState_Swatch
    {
        return state;
    }
    public function getONSwatchState():IState_Swatch
    {
        return this.onState;
    }
    public function getOFFSwatchState():IState_Swatch
    {
        return this.offState;
    }

    public function getOVERSwatchState():IState_Swatch
    {
        return this.overState;
    }

    private function onStateChange():void {
        if (_onStateChange != null) {
            _onStateChange.apply(null, [state]);
        }
    }
}
}
