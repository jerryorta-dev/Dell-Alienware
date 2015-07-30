package {

import com.dell.DocumentClass;
import com.dell.alienFx.ConfigText;
import com.dell.services.PathManager;
import com.dell.services.TrackEvent;
import com.demonsters.debugger.MonsterDebugger;
import com.dpa.utils.displayObject.getLoaderInfo;
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.XMLLoader;
import com.greensock.plugins.TintPlugin;
import com.greensock.plugins.TweenPlugin;
import com.omniture.AppMeasurement;

import flash.display.MovieClip;

import alienFxModule.loading.AlienConfigParser;

import alienFxModule.swatches.BuildSwatchSystem;
import alienFxModule.Omniture.Tracking;

import alienFxModule.uiGraphics.CreateHideControlButton;
import alienFxModule.uiGraphics.uiFactoryPattern.abstractCreators.AbstractTextFieldCreator;
import alienFxModule.uiGraphics.uiFactoryPattern.creators.CreateUITextField;

[SWF(width="965", height="500", backgroundColor="0x000000")]
public class Main_1115_AlienFx extends DocumentClass {


    [Embed(source="/assets/fonts/PillAlt600mg-Medium.ttf",
            fontName="PillAlt600mg-Medium",
            fontFamily="PillAlt600mg-Medium",
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

    [Embed(source="/assets/fonts/PillAlt600mg-Regular.ttf",
            fontName="PillAlt600mg-Regular",
            fontFamily="PillAlt600mg-Regular",
            mimeType="application/x-font",
            fontWeight="normal",
            fontStyle="normal",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
    private var embeddedFont3:Class;

    private var queue:LoaderMax;

    private var assets:alienFx;
    private var _numbers:MovieClip;
    private var zones:MovieClip;
    private var _boxes:MovieClip;
    private var ui:MovieClip;
    private var parser:AlienConfigParser;

    private var swatchSystem:BuildSwatchSystem;

    private var hideShow:CreateHideControlButton;

    private var timeline:TimelineLite;

    public static var s:AppMeasurement;
    public static var site:String = "AlienWare-1115";  //product name, this is used in tracking, so it is important.


    public function Main_1115_AlienFx() {


    }

    override protected function init():void {
        super.init();

//        graphics.beginFill(0x000000, 1);
//        graphics.drawRect(0, 0, 965, 500);
//        graphics.endFill();

        loadXML();

    }

    private function loadXML():void {
        PathManager.init( getLoaderInfo(this) );
        ConfigText.init();
        initTracking();
        TweenPlugin.activate([TintPlugin]);
        MonsterDebugger.initialize(this);
        assets = new alienFx();
        assets.x = 150;
        assets.y = 0;
        addChild(assets);

        _numbers = assets.numbers;
        zones = assets.zones;
        _boxes = assets.numbers;
        ui = assets.ui;

        parser = new AlienConfigParser({onComplete: buildUI});

        queue = new LoaderMax({name:"mainQueue", onComplete: parser.parseData, requireWithRoot: this.root});
        queue.append(new XMLLoader(PathManager.getConfigXML('alianFx-config'), {name: "alienFxConfig"}));
        queue.append(new XMLLoader(PathManager.getLocalizedXML(), {name: "alienFxCopy"}));
        queue.load();
    }

    public static function initTracking():void
    {

        s = new AppMeasurement();

        alienFxModule.Omniture.Tracking.configActionSource();

        var tEvt:TrackEvent = new TrackEvent("AlienFx","Loading", "subModule");
        alienFxModule.Omniture.Tracking.trackMetrics(tEvt);
    }

    private function buildUI(data:Object):void {

        swatchSystem = new BuildSwatchSystem(assets, zones, _numbers, _boxes, data);
        swatchSystem.x = 170;
        swatchSystem.y = 427;
        addChild(swatchSystem);

        var tf:AbstractTextFieldCreator = new CreateUITextField();
        var tfParams:Object = {};
        tfParams.name = "descriptionTf";
        tfParams.htmlText = data.description;
        tf.draw(CreateUITextField.DESCRIPTION, this, 170, 390, tfParams);

        hideShow = new CreateHideControlButton(this, data);
        hideShow.x = 169;
        hideShow.y = 426;
        addChild(hideShow);

     /*
        var reset:CreateResetlButton = new CreateResetlButton(assets, swatchSystem.initColor);
        reset.x = 860;
        reset.y = 375;
        addChild(reset);
     */

    }

    private function callParent():void {
        if (this.parent.root != stage) // prevents compiler error when publishing child swf
        {
            MovieClip(this.parent.root).callFromChildSwf();
        }
    }

    public function callChildFromParent(vars:Object):void {
        trace("alienFX child Called from parent");

        if (vars.transitionOff != null) {

            timeline = new TimelineLite({pause:true, onComplete:onTimelineComplete});

            for (var k:int = 1; k <= 10; k++) {
                timeline.insert(TweenLite.to(assets["zone" + k],.25, {alpha:0}));
            }

            timeline.play();

//            TweenLite.to(this.parent.parent, .25, {autoAlpha: 0, delay: .25});
        }

        if (vars.transitionOn != null) {
            trace(this.parent.name);
//            TweenLite.to(this.parent.parent, .25, {delay: .4, autoAlpha: 1});

            timeline = new TimelineLite({pause:true, delay:.6, onComplete:onTimelineComplete});

            for (var j:int = 1; j <= 10; j++) {
                timeline.insert(TweenLite.to(assets["zone" + j],.25, {alpha:1}));
            }

            timeline.play();

        }


    }

    private function onTimelineComplete():void {
        timeline.kill();
    }

    public function get boxes():MovieClip {
        return _boxes;
    }

    public function get numbers():MovieClip {
        return _numbers;
    }
}
}
