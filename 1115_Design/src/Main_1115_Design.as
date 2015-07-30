package {

import com.dell.alienFx.ConfigText;
import com.dell.services.TrackEvent;
//import com.demonsters.debugger.MonsterDebugger;
import com.dpa.utils.object.addHandCurserNoChildren;
//import com.dpa.utils.tracers.traceProps;
//import com.greensock.TweenLite;
//import com.kenergy.kevents.KsliderEvent;
import com.omniture.AppMeasurement;

import design.Omniture.Tracking;

import design.calloutObserverPattern.abstract.AbstractCallOut;

import design.calloutObserverPattern.observers.controls.abstract.Context_Button_ON_OFF;
import design.calloutObserverPattern.observers.controls.graphics.OnOffButtonAW14;

import com.dell.DocumentClass;

import com.greensock.events.LoaderEvent;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.SWFLoader;
import com.greensock.loading.XMLLoader;
import com.greensock.plugins.TintPlugin;
import com.greensock.plugins.TweenPlugin;

import design.calloutObserverPattern.observers.controls.graphics.OnOffButtonAW17;
import design.calloutObserverPattern.observers.controls.graphics.OnOffButtonAW18;

import flash.display.DisplayObject;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.MouseEvent;

import com.dell.services.PathManager;

import design.loading.parsers.DesignConfigParser;

//import design.loading.parsers.XMLConfigParser;

import design.moduleStatePattern.abstract.Context_Modules;


[SWF(width="965", height="500")]
public class Main_1115_Design extends DocumentClass {

    public static const UI_BACKGROUND_COLOR:uint = 0x222222;
    public static const UI_DIVIDER_COLOR:uint = 0x555555;

    private var _iconsSize:design_assets;

    private var _swfAW14Root:MovieClip;
    private var _swfAW17Root:MovieClip;
    private var _swfAW18Root:MovieClip;

    public var _swfContainer:Sprite;

    private var _featureContainer14:Sprite;
    private var _featureContainer17:Sprite;
    private var _featureContainer18:Sprite;

    public var _featureContainer:Sprite;

    private var _sliderAW14:Slider;
    private var _sliderAW17:Slider;
    private var _sliderAW18:Slider;

    private var moduleStates:Context_Modules;

    private var _btnOnOffAW14:AbstractCallOut;
    private var _btnOnOffAW17:AbstractCallOut;
    private var _btnOnOffAW18:AbstractCallOut;

    //TODO duplicate this
    public var toggleOnOffAW14CallOuts:Context_Button_ON_OFF;
    public var toggleOnOffAW17CallOuts:Context_Button_ON_OFF;
    public var toggleOnOffAW18CallOuts:Context_Button_ON_OFF;

    private var queue:LoaderMax;
    private var queue2:LoaderMax;

    private var btnOnOffContainer:Sprite;

    private var XMLParser:DesignConfigParser;

    private var _data:Object;


    [Embed(source="/assets/fonts/PillAlt600mg-Regular.ttf",
            fontName="PillAlt600mg-Regular",
            fontFamily="PillAlt600mg-Regular",
            mimeType="application/x-font",
            fontWeight="normal",
            fontStyle="normal",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
    private var embeddedFont1:Class;

    [Embed(source="/assets/fonts/PillAlt600mg-Bold.ttf",
            fontName="PillAlt600mg-Bold",
            fontFamily="PillAlt600mg-Bold",
            mimeType="application/x-font",
            fontWeight="normal",
            fontStyle="normal",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
    private var embeddedFont2:Class;

    public static var s:AppMeasurement;
    public static var site:String = "AlienWare-1115";  //product name, this is used in tracking, so it is important.

    public function Main_1115_Design() {
        super();
        XMLParser = new DesignConfigParser({onComplete: parseComplete});
		//MonsterDebugger.initialize(this);
        //MonsterDebugger.trace(this, PathManager.baseURL + "assets/swf/design_14.swf", "DESIGN", "aw14SWF");


        queue = new LoaderMax({name: "mainQueue", onComplete: XMLParser.parseData, requireWithRoot: this.root, onProgress:callParent});
        queue.append(new XMLLoader(PathManager.getConfigXML('design-config'), {name: "designConfig", estimatedBytes:15}));
        queue.append(new XMLLoader(PathManager.getLocalizedXML(), {name: "designCopy", estimatedBytes:25}));//<--Pathfinder
        queue.append(new SWFLoader(PathManager.baseURL + "assets/swf/design_14.swf", {name:"aw14SWF", estimatedBytes:10840}));//<--Pathfinder
        queue.load();
    }


    override protected function init():void {
        super.init();

        graphics.beginFill(0x000000, 1);
        graphics.drawRect(0, 0, 965, 500);
        graphics.endFill();

        startBuild();

    }

    public function startBuild():void {

        ConfigText.init();
        initTracking();
        TweenPlugin.activate([TintPlugin]);
        LoaderMax.activate([SWFLoader]);
        PathManager.init(loaderInfo);
        

    }


    public static function initTracking():void
    {

        s = new AppMeasurement();

        design.Omniture.Tracking.configActionSource();

        var tEvt:TrackEvent = new TrackEvent("Design","Loading", "subModule");
        design.Omniture.Tracking.trackMetrics(tEvt);
    }


    private function parseComplete(data:Object):void {

        _data = data;

        _swfContainer = new Sprite();
        _swfContainer.x = _swfContainer.y = 0;
        addChild(_swfContainer);


        _featureContainer = new Sprite();
        _featureContainer.x = _featureContainer.y = 0;
        addChild(_featureContainer);

        //FEATURE 14 CONTAINER
        _featureContainer14 = new Sprite();
        _featureContainer14.name = "featureContainer14";
        _featureContainer14.x = _featureContainer14.y = 0;
        _featureContainer.addChild(_featureContainer14);


        //FEATURE 17 CONTAINER
        _featureContainer17 = new Sprite();
        _featureContainer17.name = "featureContainer17";
        _featureContainer17.x = 0;
        _featureContainer17.y = 0;
        _featureContainer17.alpha = 0;
        _featureContainer17.visible = false;
        _featureContainer.addChild(_featureContainer17);


        //FEATURE 18 CONTAINER
        _featureContainer18 = new Sprite();
        _featureContainer18.name = "featureContainer18";
        _featureContainer18.x = 0;
        _featureContainer18.y = 0;
        _featureContainer18.alpha = 0;
        _featureContainer18.visible = false;
        _featureContainer.addChild(_featureContainer18);

        _data.aw14.featureContainerAW14 = _featureContainer14;
        _data.aw14.featureContainerAW17 = _featureContainer17;
        _data.aw14.featureContainerAW18 = _featureContainer18;

        _data.aw17.featureContainerAW14 = _featureContainer14;
        _data.aw17.featureContainerAW17 = _featureContainer17;
        _data.aw17.featureContainerAW18 = _featureContainer18;

        _data.aw18.featureContainerAW14 = _featureContainer14;
        _data.aw18.featureContainerAW17 = _featureContainer17;
        _data.aw18.featureContainerAW18 = _featureContainer18;


        //SWF - AW14
        var aw14SWF:SWFLoader = queue.getLoader("aw14SWF");
        _swfAW14Root = aw14SWF.rawContent;
        _swfAW14Root.x = 0;
        _swfAW14Root.y = 0;
        _swfContainer.addChild(_swfAW14Root);
        _swfAW14Root.gotoAndStop(0);
        _data.aw14.swfRootAW14 = _swfAW14Root;

        //NAV BACKGROUND
        var uiBackground:Sprite = new Sprite();
        uiBackground.x = 328;
        uiBackground.y = 438;
        addChild(uiBackground);


        _sliderAW14 = new Slider();
        _sliderAW14.initialize(0, 180, 0);
        _sliderAW14.magnetic = false;
        _sliderAW14.smoothed = true;
        _sliderAW14.precision = 1;
        _sliderAW14.x = 480;
        _sliderAW14.y = 450;
        _sliderAW14.mc_value.alpha = 0;
        addChild(_sliderAW14);


        _sliderAW17 = new Slider();
        _sliderAW17.initialize(0, 180, 0);
        _sliderAW17.magnetic = false;
        _sliderAW17.smoothed = true;
        _sliderAW17.precision = 1;
        _sliderAW17.x = 480;
        _sliderAW17.y = 450;
        _sliderAW17.alpha = 0;
        _sliderAW17.visible = false;
        _sliderAW17.mc_value.alpha = 0;
        addChild(_sliderAW17);


        _sliderAW18 = new Slider();
        _sliderAW18.initialize(0, 180, 0);
        _sliderAW18.magnetic = false;
        _sliderAW18.smoothed = true;
        _sliderAW18.precision = 1;
        _sliderAW18.x = 480;
        _sliderAW18.y = 450;
        _sliderAW18.alpha = 0;
        _sliderAW18.visible = false;
        _sliderAW18.mc_value.alpha = 0;
        addChild(_sliderAW18);

        _data.aw14.sliderAW14 = _sliderAW14;
        _data.aw14.sliderAW17 = _sliderAW17;
        _data.aw14.sliderAW18 = _sliderAW18;

        _data.aw17.sliderAW14 = _sliderAW14;
        _data.aw17.sliderAW17 = _sliderAW17;
        _data.aw17.sliderAW18 = _sliderAW18;

        _data.aw18.sliderAW14 = _sliderAW14;
        _data.aw18.sliderAW17 = _sliderAW17;
        _data.aw18.sliderAW18 = _sliderAW18;


        _iconsSize = new design_assets();
        _iconsSize.x = 345;
        _iconsSize.y = 448;
        addChild(_iconsSize);
        _data.icons = _iconsSize;

        var divider:Sprite = new Sprite();
        divider.graphics.beginFill(UI_DIVIDER_COLOR, 1);
        divider.graphics.drawRect(0, 0, 1, 24);
        divider.graphics.endFill();
        divider.x = 455;
        divider.y = 447;
        addChild(divider);


        _btnOnOffAW14 = new OnOffButtonAW14(this, _data.buttonArray[0]);
        _btnOnOffAW14.name = "_btnOnOffAW14";
        _btnOnOffAW14.x = 733;
        _btnOnOffAW14.y = 443;
        addHandCurserNoChildren(_btnOnOffAW14);
        addChild(_btnOnOffAW14);
        _btnOnOffAW14.addEventListener(MouseEvent.CLICK, toggleAW14Callouts, false, 0, true);
        toggleOnOffAW14CallOuts = new Context_Button_ON_OFF(_btnOnOffAW14);
        toggleOnOffAW14CallOuts.setState(toggleOnOffAW14CallOuts.getOnButtonState());

        _btnOnOffAW17 = new OnOffButtonAW17(this, _data.buttonArray[0]);
        _btnOnOffAW17.name = "_btnOnOffAW17";
        _btnOnOffAW17.x = 733;
        _btnOnOffAW17.y = 443;
        _btnOnOffAW17.alpha = 0;
        _btnOnOffAW17.visible = false;
        addHandCurserNoChildren(_btnOnOffAW17);
        addChild(_btnOnOffAW17);
        _btnOnOffAW17.addEventListener(MouseEvent.CLICK, toggleAW17Callouts, false, 0, true);
        toggleOnOffAW17CallOuts = new Context_Button_ON_OFF(_btnOnOffAW17);
        toggleOnOffAW17CallOuts.setState(toggleOnOffAW17CallOuts.getOnButtonState());

        _btnOnOffAW18 = new OnOffButtonAW18(this, _data.buttonArray[0]);
        _btnOnOffAW18.name = "_btnOnOffAW18";
        _btnOnOffAW18.x = 733;
        _btnOnOffAW18.y = 443;
        _btnOnOffAW18.alpha = 0;
        _btnOnOffAW18.visible = false;
        addHandCurserNoChildren(_btnOnOffAW18);
        addChild(_btnOnOffAW18);
        _btnOnOffAW18.addEventListener(MouseEvent.CLICK, toggleAW18Callouts, false, 0, true);
        toggleOnOffAW18CallOuts = new Context_Button_ON_OFF(_btnOnOffAW18);
        toggleOnOffAW18CallOuts.setState(toggleOnOffAW18CallOuts.getOnButtonState());

        _data.aw14.onOffAW14 = toggleOnOffAW14CallOuts;
        _data.aw14.onOffAW17 = toggleOnOffAW17CallOuts;
        _data.aw14.onOffAW18 = toggleOnOffAW18CallOuts;

        _data.aw17.onOffAW14 = toggleOnOffAW14CallOuts;
        _data.aw17.onOffAW17 = toggleOnOffAW17CallOuts;
        _data.aw17.onOffAW18 = toggleOnOffAW18CallOuts;

        _data.aw18.onOffAW14 = toggleOnOffAW14CallOuts;
        _data.aw18.onOffAW17 = toggleOnOffAW17CallOuts;
        _data.aw18.onOffAW18 = toggleOnOffAW18CallOuts;

        var uiBGWidth:Number = (_btnOnOffAW18.x - uiBackground.x) + _btnOnOffAW14.unscaledWidth + 5;
        uiBackground.graphics.clear();
        uiBackground.graphics.beginFill(UI_BACKGROUND_COLOR, 1);
        uiBackground.graphics.drawRoundRect(0, 0, uiBGWidth, 40, 5);
        uiBackground.graphics.endFill();

        //TOGGLE ON OFF BUTTON

        moduleStates = new Context_Modules(_iconsSize);
        addChild(moduleStates);
        moduleStates.addAW14State(this, _data)
        moduleStates.activateDesign14();

//        callParent();

        //MonsterDebugger.trace(this, PathManager.baseURL + "assets/swf/design_17.swf", "DESIGN", "aw17SWF");
        //MonsterDebugger.trace(this, PathManager.baseURL + "assets/swf/design_18.swf", "DESIGN", "aw18SWF");

        queue2 = new LoaderMax({onComplete:loadAddtionalSwfs});
        queue2.append( new SWFLoader(PathManager.baseURL + "assets/swf/design_17.swf", {name:"design17"}));
        queue2.append( new SWFLoader(PathManager.baseURL + "assets/swf/design_18.swf", {name:"design18"}));
        queue2.load();
    }


    private function toggleAW14Callouts(event:MouseEvent):void {

        if (toggleOnOffAW14CallOuts.getState() === toggleOnOffAW14CallOuts.getOnButtonState()) {
            toggleOnOffAW14CallOuts.OFF();
            var tEvt1:TrackEvent = new TrackEvent('button','Design-TurnAW14CalloutsOFF');
            design.Omniture.Tracking.trackMetrics(tEvt1);
        } else {
            toggleOnOffAW14CallOuts.ON();
            var tEvt2:TrackEvent = new TrackEvent('button','Design-TurnAW14CalloutsON');
            design.Omniture.Tracking.trackMetrics(tEvt2);
        }
    }

    private function toggleAW17Callouts(event:MouseEvent):void {

        if (toggleOnOffAW17CallOuts.getState() === toggleOnOffAW17CallOuts.getOnButtonState()) {
            toggleOnOffAW17CallOuts.OFF();
            var tEvt1:TrackEvent = new TrackEvent('button','Design-TurnAW17CalloutsON');
            design.Omniture.Tracking.trackMetrics(tEvt1);
        } else {
            toggleOnOffAW17CallOuts.ON();
            var tEvt2:TrackEvent = new TrackEvent('button','Design-TurnAW17CalloutsOFF');
            design.Omniture.Tracking.trackMetrics(tEvt2);
        }
    }

    private function toggleAW18Callouts(event:MouseEvent):void {

        if (toggleOnOffAW18CallOuts.getState() === toggleOnOffAW18CallOuts.getOnButtonState()) {
            toggleOnOffAW18CallOuts.OFF();
            var tEvt1:TrackEvent = new TrackEvent('button','Design-TurnAW18CalloutsON');
            design.Omniture.Tracking.trackMetrics(tEvt1);
        } else {
            toggleOnOffAW18CallOuts.ON();
            var tEvt2:TrackEvent = new TrackEvent('button','Design-TurnAW18CalloutsOFF');
            design.Omniture.Tracking.trackMetrics(tEvt2);
        }
    }

    private function loadAddtionalSwfs(event:LoaderEvent):void {


        var aw17SWF:SWFLoader = queue2.getLoader("design17");
        _swfAW17Root = aw17SWF.rawContent;
        _swfAW17Root.x = 45;
        _swfAW17Root.y = 0;
        _swfAW17Root.alpha = 0;
        _swfAW17Root.visible = false;
        _swfContainer.addChild(_swfAW17Root);
        _swfAW17Root.gotoAndStop(0);
        _data.aw17.swfRootAW17 = _swfAW17Root;
        moduleStates.addAW17State(this, _data);

        var aw18SWF:SWFLoader = queue2.getLoader("design18");
        _swfAW18Root = aw18SWF.rawContent;
        _swfAW18Root.x = 45;
        _swfAW18Root.y = 0;
        _swfAW18Root.alpha = 0;
        _swfAW18Root.visible = false;
        _swfContainer.addChild(_swfAW18Root);
        _swfAW18Root.gotoAndStop(0);
        _data.aw18.swfRootAW18 = _swfAW18Root;
        moduleStates.addAW18State(this, _data);

        queue2.dispose();

    }

    private function callParent(event:LoaderEvent):void {
        if (this.parent != null) {
            if (this.parent.root != stage) // prevents compiler error when publishing child swf
            {
                MovieClip(this.parent.root).designTertiaryLoading( queue.rawProgress );
            }
        }
    }

    public function callChildFromParent(vars:Object):void {
        trace("Design child Called from parent")
        if (vars.transitionOff != null) {
//            TweenLite.to(this.parent.parent, .25, {autoAlpha: 0});
            if (queue.progress == 1) {
                queue2.pause();
            } else {
                queue.pause();
            }
        }

        if (vars.transitionOn != null) {
//            TweenLite.to(this.parent.parent, .25, {delay: .25, autoAlpha: 1});
            if (queue.progress == 1) {
                queue2.resume();
            } else {
                queue.resume();
            }

        }
    }


    public function get sliderAW18():Slider {
        return _sliderAW18;
    }

    public function get sliderAW17():Slider {
        return _sliderAW17;
    }

    public function get sliderAW14():Slider {
        return _sliderAW14;
    }

    public function get featureContainer18():Sprite {
        return _featureContainer18;
    }

    public function get featureContainer17():Sprite {
        return _featureContainer17;
    }

    public function get featureContainer14():Sprite {
        return _featureContainer14;
    }

    public function get swfAW17Root():MovieClip {
        return _swfAW17Root;
    }

    public function get swfAW14Root():MovieClip {
        return _swfAW14Root;
    }

    public function get swfAW18Root():MovieClip {
        return _swfAW18Root;
    }

    public function get btnOnOffAW14():AbstractCallOut {
        return _btnOnOffAW14;
    }

    public function get btnOnOffAW17():AbstractCallOut {
        return _btnOnOffAW17;
    }

    public function get btnOnOffAW18():AbstractCallOut {
        return _btnOnOffAW18;
    }


    public function get iconsSize():design_assets {
        return _iconsSize;
    }


}
}
