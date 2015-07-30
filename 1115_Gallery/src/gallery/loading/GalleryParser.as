/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/1/13
 * Time: 11:26 AM
 *
 */
package gallery.loading {
//import com.dpa.loading.LoaderMaxFactory;
import com.dell.services.PathManager;
import com.dpa.utils.objects.traceObjecProps;

import com.dpa.utils.objects.union;
import com.dpa.utils.tracers.traceProps;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.LoaderMax;

import flash.net.ObjectEncoding;

import utils.object.numProperties;

/**
 * Only organize data to build the interface, do not build display objects here
 */
public class GalleryParser {

    private var vars:Object;

    private var _dataVector:Vector.<Object>;
    private var _data:Object;

    private var _eventData:Object;


    private var _onComplete:Function;


    public function GalleryParser(vars:Object = null) {
        this.vars = (vars != null) ? vars : {};
        _onComplete = (this.vars.onComplete != null) ? this.vars.onComplete : null;

        _data = new Object();

    }


    public function parseData(event:LoaderEvent):void {
        _eventData = event.target;
        var _config:XMLList = (_eventData.getContent("galleryConfig") as XML).gallery.LoaderMax;

        var iter:int = 1;

        for each (var _t:XML in _config[0].ImageLoader) {
            var image:Object = {};

            image.tn = PathManager.baseURL + "assets/image/" +  _t.@url;
            image.cat = _t.@cat;

            _data["heroImages" + iter] = image;

            iter += 1;
        }

        iter = 1;

        for each (var _m:XML in _config[1].ImageLoader) {


            _data["heroImages" + iter].med =  PathManager.baseURL + "assets/image/" +  _m.@url;

            iter += 1;
        }

        iter = 1;

        for each (var _l:XML in _config[2].ImageLoader) {


            _data["heroImages" + iter].lrg = PathManager.baseURL + "assets/image/" +   _l.@url;

            iter += 1;
        }



        parseCopy();
    }

    private function parseCopy():void {
        var _copy:XMLList = (_eventData.getContent("galleryCopy") as XML).gallery.image;


        var len:int = numProperties(_data);

        for (var i:int = 1; i < len + 1; i++) {
            if (_data["heroImages" + i].cat == 1) {
                _data["heroImages" + i].title = _copy[0].title;
                _data["heroImages" + i].copy = _copy[0].copy;
                _data["heroImages" + i].xmlNode = _copy[0];
            }

            if (_data["heroImages" + i].cat == 2) {
                _data["heroImages" + i].title = _copy[1].title;
                _data["heroImages" + i].copy = _copy[1].copy;
                _data["heroImages" + i].xmlNode = _copy[1];
            }

            if (_data["heroImages" + i].cat == 3) {
                _data["heroImages" + i].title = _copy[2].title;
                _data["heroImages" + i].copy = _copy[2].copy;
                _data["heroImages" + i].xmlNode = _copy[2];
            }

            if (_data["heroImages" + i].cat == 4) {
                _data["heroImages" + i].title = _copy[3].title;
                _data["heroImages" + i].copy = _copy[3].copy;
                _data["heroImages" + i].xmlNode = _copy[3];
            }
        }


/*

        var iter:int = 1;
        for each (var _c:XML in _copy) {

            _data["video" + iter].title = _c.title;
            _data["video" + iter].xmlNode = _c;

            iter += 1;
        }
*/

        complete();
    }


    private function complete():void {

        if (_onComplete != null) {
            _onComplete.apply(null, [_data]);
        }
    }


}
}