/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/1/13
 * Time: 11:26 AM
 *
 */
package alienFxModule.loading {
//import com.dpa.alienFx.loading.LoaderMaxFactory;
import com.dpa.utils.objects.traceObjecProps;

import com.dpa.utils.objects.union;
import com.dpa.utils.tracers.traceProps;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.LoaderMax;

/**
 * Only organize data to build the interface, do not build display objects here
 */
public class AlienConfigParser {

    private var vars:Object;

    private var _dataVector:Vector.<Object>;
    private var _data:Object;

    private var _eventData:Object;


    private var _onComplete:Function;


    public function AlienConfigParser(vars:Object = null) {
        this.vars = (vars != null) ? vars : {};
        _onComplete = (this.vars.onComplete != null) ? this.vars.onComplete : null;

        _data = new Object();

    }


    public function parseData(event:LoaderEvent):void {
        _eventData = event.target;
        var _config:XMLList = (_eventData.getContent("alienFxConfig") as XML).alienFx.swatches.color;
//        var _aw14List:XMLList = (_eventData.getContent("alienFxConfig") as XML).design.FeatureConfigs.Alienware14.feature;

        var swatches:Vector.<Object> = new Vector.<Object>();

        for each (var _sw:XML in _config) {

            var swObj:Object = {};
            swObj.color = _sw;
            swObj.state = _sw.@state;

            swatches.push(swObj);
        }

        _data.swatches = swatches;
        parseCopy();
    }

    private function parseCopy():void {
        var _copy:XMLList = (_eventData.getContent("alienFxCopy") as XML).exploreLightingRx;


        for each (var _c:XML in _copy) {
            _data.description = _c.copy;
            _data.button = _c.button;
        }

        complete();
    }


    private function complete():void {

        if (_onComplete != null) {
            _onComplete.apply(null, [_data]);
        }
    }


}
}