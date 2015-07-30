/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/1/13
 * Time: 11:26 AM
 *
 */
package video.loading {
//import com.dpa.loading.LoaderMaxFactory;
import com.dpa.utils.objects.traceObjecProps;

import com.dpa.utils.objects.union;
import com.dpa.utils.tracers.traceProps;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.LoaderMax;

/**
 * Only organize data to build the interface, do not build display objects here
 */
public class VideoParser {

    private var vars:Object;

    private var _dataVector:Vector.<Object>;
    private var _data:Object;

    private var _eventData:Object;


    private var _onComplete:Function;


    public function VideoParser(vars:Object = null) {
        this.vars = (vars != null) ? vars : {};
        _onComplete = (this.vars.onComplete != null) ? this.vars.onComplete : null;

        _data = new Object();

    }


    public function parseData(event:LoaderEvent):void {
        _eventData = event.target;
        var _config:XMLList = (_eventData.getContent("videoConfig") as XML).videoGallery.ooyala.video;

        var iter:int = 1;

        for each (var _vid:XML in _config) {
            var swObj:Object = {};

            swObj.ooyalaID = _vid.ooyalaID;

            _data["video" + iter] = swObj
            iter += 1;
        }

        parseCopy();
    }

    private function parseCopy():void {
        var _copy:XMLList = (_eventData.getContent("videoCopy") as XML).videoGallerr.video;

        var iter:int = 1;
        for each (var _c:XML in _copy) {

            _data["video" + iter].title = _c.title;
            _data["video" + iter].xmlNode = _c;

            iter += 1;
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