/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/1/13
 * Time: 11:26 AM
 *
 */
package commandCenter.loading {
//import com.dpa.loading.LoaderMaxFactory;
import com.dell.services.PathManager;
import com.greensock.events.LoaderEvent;

import utils.object.numProperties;

/**
 * Only organize data to build the interface, do not build display objects here
 */
public class CCParser {

    private var vars:Object;

    private var _dataVector:Vector.<Object>;
    private var _data:Object;

    private var _eventData:Object;


    private var _onComplete:Function;


    public function CCParser(vars:Object = null) {
        this.vars = (vars != null) ? vars : {};
        _onComplete = (this.vars.onComplete != null) ? this.vars.onComplete : null;

        _data = new Object();

    }


    public function parseData(event:LoaderEvent):void {
        _eventData = event.target;
        var _config:XMLList = (_eventData.getContent("commandCenterConfig") as XML).commandCenter.LoaderMax;

        var iter:int = 1;

        _data.images = {};

        for each (var _t:XML in _config) {
            var image:Object = {};

            image.name = "heroImages" + iter;
            image.targetName = "target" + iter;
//            image.loaderName = _t.@name;
            image.tabParent = _t.@tab;

            image.med = PathManager.baseURL + "assets/image/" + _t.ImageLoader[0].@url;
            image.medloaderName = _t.ImageLoader[0].@name;
            image.lrg = PathManager.baseURL + "assets/image/" + _t.ImageLoader[1].@url;
            image.lrgloaderName = _t.ImageLoader[0].@name;
            image.tabItem = _t.ImageLoader[0].@tabItem;

            //_data.images.image1 = {name:image1, loaderName ...}
            _data.images["image" + iter] = image;
            iter += 1;
        }

        var len:int = numProperties(_data.images);
        _data.tabs = {};


        //Create tabs node
        var currentTabName:String = "none";
        iter = 1;
        var tabIter:int = 1;
        var tab:Object = {};

        for (var i:int = 1; i < len + 1; i++) {

            if (currentTabName != _data.images["image" + i].tabParent) {
                tab = {};
                currentTabName  = _data.images["image" + i].tabParent;
                tab.name = currentTabName;
                tab.subNavName = "subNav" + tabIter;
                _data.tabs["tab" + tabIter] = tab;
                _data.tabs["tab" + tabIter]["subNav"] = {};
                tabIter += 1;
                iter = 1;
            }


            /**
             * data.tabs.tab2.subNav = {
             *              target1: image2,
             *              target2: image3,
             *              target3: image4
             *              }
             *
             */
            _data.tabs["tab" + (tabIter - 1)]["subNav"]["target" + iter] = "heroImages" + i;

//            _data.images["image" + i]["tab"] = currentTabName;
            _data.images["image" + i]["subNav"] = iter;

            iter += 1;
        }



        parseCopy();
    }

    private function parseCopy():void {
        var _copy:XMLList = (_eventData.getContent("commandCenterCopy") as XML).commandCenter.tab;

        var tabIter:int = 1;
        for each (var _c:XML in _copy) {

//            trace(_c.title);
            _data.tabs["tab" + (tabIter)]["xmlNode"] = _c;

            tabIter += 1;
        }

        var _imageCopy:XMLList = (_eventData.getContent("commandCenterCopy") as XML).commandCenter.tab.image;

        var iIter:int = 1;
        for each (var _i:XML in _imageCopy) {
            _data.images["image" + iIter]["xmlNode"] = _i;
            iIter += 1;
        }

//        traceProps(_data.images);


        complete();
    }


    private function complete():void {

        if (_onComplete != null) {
            _onComplete.apply(null, [_data]);
        }
    }


}
}