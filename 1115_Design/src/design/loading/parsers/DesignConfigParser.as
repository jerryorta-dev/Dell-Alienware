/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/1/13
 * Time: 11:26 AM
 *
 */
package design.loading.parsers {
//import com.dpa.loading.LoaderMaxFactory;
import com.dpa.utils.objects.traceObjecProps;

import com.dpa.utils.objects.union;
import com.dpa.utils.tracers.traceProps;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.LoaderMax;

/**
 * Only organize data to build the interface, do not build display objects here
 */
public class DesignConfigParser {

    private var vars:Object;

    private var _dataVector:Vector.<Object>;
    private var _data:Object;

    private var _eventData:Object;

    private var _gObj:Object;

    private var _buttons:Object;
    private var _aw14:Object;
    private var _aw17:Object;
    private var _aw18:Object;
    private var _loaders:Object;

    private var _onComplete:Function;




    public function DesignConfigParser(vars:Object = null) {
        this.vars = (vars != null) ? vars : {};
        _onComplete = (this.vars.onComplete != null) ? this.vars.onComplete : null;

        _data = new Object();

        _gObj = new Object();
        _buttons = new Object();

        _aw14 = new Object();
        _aw17 = new Object();
        _aw18 = new Object();
        _loaders = new Object;

        _data.buttons = _buttons; //<-- array
        _data.aw14 = _aw14;       //<-- array objects
        _data.aw17 = _aw17;       //<-- array objects
        _data.aw18 = _aw18;       //<-- array objects
        _data.loaders = _loaders; //<-- array objects


    }

    public function parseData(event:LoaderEvent):void {
        _eventData = event.target;


        parseGlobal();
    }

    private function parseGlobal():void {
        var _global:XMLList = (_eventData.getContent("designConfig") as XML).design.global;

        var containerRectangle:Object = {};
        containerRectangle.width = _global.containerRectangle.width;
        containerRectangle.height = _global.containerRectangle.height;
        containerRectangle.alpha = _global.containerRectangle.alpha;
        containerRectangle.color = _global.containerRectangle.color;

        //***************************************************************'
        //Get global feature params

        _gObj.containerRectangle = containerRectangle;

        _gObj.name = _global.name;
        _gObj.minRotation = _global.minRotation;
        _gObj.maxRotation = _global.maxRotation;
        _gObj.minOpacity = _global.minOpacity;
        _gObj.maxHeight = _global.maxHeight;
        _gObj.sliderInitRotation = _global.sliderInitRotation;
        _gObj.z = _global.z;

        parseAW14();

    }

    private function parseAW14():void {
        var _aw14List:XMLList = (_eventData.getContent("designConfig") as XML).design.FeatureConfigs.Alienware14.feature;

        var featureItems:Vector.<Object> = new Vector.<Object>();
        for each (var _aw14Prop:XML in _aw14List) {
            var featureObject:Object = new Object;

            featureObject.name = _aw14Prop.@name;
            featureObject.lineToTargetName = _aw14Prop.lineToTargetName;
            featureObject.x = _aw14Prop.x;
            featureObject.y = _aw14Prop.y;
            featureObject.activeYRotation = _aw14Prop.activeYRotation;
            featureObject.containerName = featureObject.name + "Container";
            featureObject.containerRectangle = _gObj.containerRectangle;
            featureObject.areaTextTargetWidth = _aw14Prop.areaTextTargetWidth;
            featureObject.labelTextFieldWidth = _aw14Prop.labelTextFieldWidth;

            //expanded or collapsed
            featureObject.state = _aw14Prop.state;

            featureObject.minRotation = _gObj.minRotation;
            featureObject.maxRotation = _gObj.maxRotation;
            featureObject.minOpacity = _gObj.minOpacity;
            featureObject.iconAlign = _aw14Prop.iconAlign;
            featureObject.labelAlign = _aw14Prop.labelAlign;

            featureItems.push(featureObject);
        }

        var _aw14CopyList:XMLList = (_eventData.getContent("designCopy") as XML).design.Alienware14.features.item;


        var featureItemCounter:int = 0;
        for each (var itemProperty:XML in _aw14CopyList) {


            featureItems[featureItemCounter].title = itemProperty.title;
            featureItems[featureItemCounter].copy = itemProperty.copy;
            featureItems[featureItemCounter].xmlNode = itemProperty;


            //TODO place callout overrides here from xml copy

            if (itemProperty.@state != undefined) {
                featureItems[featureItemCounter].state = itemProperty.@state;
            }


            if (itemProperty.@x != undefined) {
                var tmpX:Number = featureItems[featureItemCounter].x;
                featureItems[featureItemCounter].x = tmpX + itemProperty.@x;
            }


            if (itemProperty.@y != undefined) {
                var tmpY:Number = featureItems[featureItemCounter].y;
                featureItems[featureItemCounter].y = tmpY + itemProperty.@y;
            }

            if (itemProperty.copy.@width != undefined) {
                var tmpAreaWidth:Number = featureItems[featureItemCounter].areaTextTargetWidth;
                featureItems[featureItemCounter].areaTextTargetWidth = tmpAreaWidth + Number(itemProperty.copy.@width);
            }

            if (itemProperty.title.@width != undefined) {
                var tmpLabelWidth:Number = featureItems[featureItemCounter].labelTextFieldWidth;
                featureItems[featureItemCounter].labelTextFieldWidth = tmpLabelWidth + Number(itemProperty.title.@width);
            }

            if (itemProperty.@iconAlign != undefined) {
                featureItems[featureItemCounter].iconAlign = itemProperty.@iconAlign;
            }

            if (itemProperty.@labelAlign != undefined) {
                featureItems[featureItemCounter].labelAlign = itemProperty.@labelAlign;
            }

            featureItemCounter++;
        }

        _aw14.featureArray = featureItems;
        _aw14.containerRectangle = _gObj.containerRectangle;
        _data.aw14 = _aw14;
        parseAW17();

    }

    private function parseAW17():void {
        var _aw17List:XMLList = (_eventData.getContent("designConfig") as XML).design.FeatureConfigs.Alienware17.feature;

        var featureItems:Vector.<Object> = new Vector.<Object>();
        for each (var _aw17Prop:XML in _aw17List) {
            var featureObject:Object = new Object;

            featureObject.name = _aw17Prop.@name;
            featureObject.lineToTargetName = _aw17Prop.lineToTargetName;
            featureObject.x = _aw17Prop.x;
            featureObject.y = _aw17Prop.y;
            featureObject.activeYRotation = _aw17Prop.activeYRotation;
            featureObject.containerName = featureObject.name + "Container";
            featureObject.containerRectangle = _gObj.containerRectangle;
            featureObject.areaTextTargetWidth = _aw17Prop.areaTextTargetWidth;
            featureObject.labelTextFieldWidth = _aw17Prop.labelTextFieldWidth;


            //expanded or collapsed
            featureObject.state = _aw17Prop.state;

            featureObject.minRotation = _gObj.minRotation;
            featureObject.maxRotation = _gObj.maxRotation;
            featureObject.minOpacity = _gObj.minOpacity;
            featureObject.iconAlign = _aw17Prop.iconAlign;
            featureObject.labelAlign = _aw17Prop.labelAlign;

            featureItems.push(featureObject);
        }

        var _aw17CopyList:XMLList = (_eventData.getContent("designCopy") as XML).design.Alienware17.features.item;


        var featureItemCounter:int = 0;
        for each (var itemProperty:XML in _aw17CopyList) {

            featureItems[featureItemCounter].title = itemProperty.title;
            featureItems[featureItemCounter].copy = itemProperty.copy;
            featureItems[featureItemCounter].xmlNode = itemProperty;



            if (itemProperty.@state != undefined) {
                featureItems[featureItemCounter].state = itemProperty.@state;
            }


            if (itemProperty.@x != undefined) {
                var tmpX:Number = featureItems[featureItemCounter].x;
                featureItems[featureItemCounter].x = tmpX + itemProperty.@x;
            }


            if (itemProperty.@y != undefined) {
                var tmpY:Number = featureItems[featureItemCounter].y;
                featureItems[featureItemCounter].y = tmpY + itemProperty.@y;
            }

            if (itemProperty.copy.@width != undefined) {
                var tmpAreaWidth:Number = featureItems[featureItemCounter].areaTextTargetWidth;
                featureItems[featureItemCounter].areaTextTargetWidth = tmpAreaWidth + Number(itemProperty.copy.@width);
            }

            if (itemProperty.title.@width != undefined) {
                var tmpLabelWidth:Number = featureItems[featureItemCounter].labelTextFieldWidth;
                featureItems[featureItemCounter].labelTextFieldWidth = tmpLabelWidth + Number(itemProperty.title.@width);
            }

            if (itemProperty.@iconAlign != undefined) {
                featureItems[featureItemCounter].iconAlign = itemProperty.@iconAlign;
            }

            if (itemProperty.@labelAlign != undefined) {
                featureItems[featureItemCounter].labelAlign = itemProperty.@labelAlign;
            }

            featureItemCounter++;
        }

        _aw17.featureArray = featureItems;
        _aw17.containerRectangle = _gObj.containerRectangle;
        _data.aw17 = _aw17;
        parseAW18();
    }

    private function parseAW18():void {
        var _aw18List:XMLList = (_eventData.getContent("designConfig") as XML).design.FeatureConfigs.Alienware18.feature;

        var featureItems:Vector.<Object> = new Vector.<Object>();
        for each (var _aw18Prop:XML in _aw18List) {
            var featureObject:Object = new Object;

            featureObject.name = _aw18Prop.@name;
            featureObject.lineToTargetName = _aw18Prop.lineToTargetName;
            featureObject.x = _aw18Prop.x;
            featureObject.y = _aw18Prop.y;
            featureObject.activeYRotation = _aw18Prop.activeYRotation;
            featureObject.containerName = featureObject.name + "Container";
            featureObject.containerRectangle = _gObj.containerRectangle;
            featureObject.areaTextTargetWidth = _aw18Prop.areaTextTargetWidth;
            featureObject.labelTextFieldWidth = _aw18Prop.labelTextFieldWidth;

            //expanded or collapsed
            featureObject.state = _aw18Prop.state;

            featureObject.minRotation = _gObj.minRotation;
            featureObject.maxRotation = _gObj.maxRotation;
            featureObject.minOpacity = _gObj.minOpacity;
            featureObject.iconAlign = _aw18Prop.iconAlign;
            featureObject.labelAlign = _aw18Prop.labelAlign;

            featureItems.push(featureObject);
        }

        var _aw18CopyList:XMLList = (_eventData.getContent("designCopy") as XML).design.Alienware18.features.item;
        var featureItemCounter:int = 0;
        for each (var itemProperty:XML in _aw18CopyList) {
//                    trace(_data[0].modules[moduleItemCounter].features[0])

            featureItems[featureItemCounter].title = itemProperty.title;
            featureItems[featureItemCounter].copy = itemProperty.copy;
            featureItems[featureItemCounter].xmlNode = itemProperty;



            if (itemProperty.@state != undefined) {
                featureItems[featureItemCounter].state = itemProperty.@state;
            }


            if (itemProperty.@x != undefined) {
                var tmpX:Number = featureItems[featureItemCounter].x;
                featureItems[featureItemCounter].x = tmpX + itemProperty.@x;
            }


            if (itemProperty.@y != undefined) {
                var tmpY:Number = featureItems[featureItemCounter].y;
                featureItems[featureItemCounter].y = tmpY + itemProperty.@y;
            }

            if (itemProperty.copy.@width != undefined) {
                var tmpAreaWidth:Number = featureItems[featureItemCounter].areaTextTargetWidth;
                featureItems[featureItemCounter].areaTextTargetWidth = tmpAreaWidth + Number(itemProperty.copy.@width);
            }

            if (itemProperty.title.@width != undefined) {
                var tmpLabelWidth:Number = featureItems[featureItemCounter].labelTextFieldWidth;
                featureItems[featureItemCounter].labelTextFieldWidth = tmpLabelWidth + Number(itemProperty.title.@width);
            }

            if (itemProperty.@iconAlign != undefined) {
                featureItems[featureItemCounter].iconAlign = itemProperty.@iconAlign;
            }

            if (itemProperty.@labelAlign != undefined) {
                featureItems[featureItemCounter].labelAlign = itemProperty.@labelAlign;
            }

            featureItemCounter++;
        }

        _aw18.featureArray = featureItems;
        _aw18.containerRectangle = _gObj.containerRectangle;
        _data.aw18 = _aw18;

        parseButtons();

    }

    private function parseButtons():void {
        //ON OFF BUTTON
        var buttonItems:Vector.<Object> = new Vector.<Object>();
//        _moduleObject.buttons = buttonItems;

        var _configButtonList:XMLList = (_eventData.getContent("designConfig") as XML).design.buttons.button;


        for each (var buttonItem:XML in _configButtonList) {

            var btnObj:Object = {};
            btnObj.name = buttonItem.@name;
            btnObj.iconAlign = buttonItem.iconAlign;
            btnObj.width = buttonItem.width;
            btnObj.x = buttonItem.x;
            btnObj.y = buttonItem.y;

            buttonItems.push(btnObj);
        }

        var buttonList:XMLList = (_eventData.getContent("designCopy") as XML).design.buttons.button;


        for each(var button:XML in buttonList) {


            if (button.@name == "onOff") {

                buttonItems[0].name = button.@name;
                buttonItems[0].xmlNode = button;
            }

        }

//        _buttons.buttonArray = buttonItems;
        _data.buttonArray = buttonItems;


        complete();

    }

    private function complete():void {

        if (_onComplete != null) {
            _onComplete.apply(null, [_data]);
        }
    }



}
}