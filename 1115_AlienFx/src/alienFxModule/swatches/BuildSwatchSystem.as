/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/28/13
 * Time: 3:15 PM
 * To change this template use File | Settings | File Templates.
 */
package alienFxModule.swatches {
import alienFxModule.Omniture.Tracking;

import com.dell.alienFx.ConfigGlobal;
import com.dell.alienFx.GlobalAnim;
import com.dell.services.TrackEvent;
import com.dpa.utils.object.addHandCurserNoChildren;
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.TweenMax;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import alienFxModule.swatches.swatchObserverPattern.cocncrete.SwatchObserver;

import alienFxModule.swatches.swatchObserverPattern.subjects.SwatchSubject;
import alienFxModule.swatches.swatchStatePattern.abstract.graphics.Swatch;

import flash.sampler._setSamplerCallback;


import utils.string.remove;

public class BuildSwatchSystem extends Sprite{

    private var _data:Object;
    private var _assets:MovieClip;

    private var _zones:MovieClip;
    private var _vZones:MovieClip;

    private var _numbers:MovieClip;
    private var _boxes:MovieClip;

    private var _currentZone:MovieClip;
    private var _currentNum:MovieClip;
    private var _currentBox:MovieClip;

    private var subject:SwatchSubject;

    private var _initColor:uint;

    private var _cachedState:uint;




    public function BuildSwatchSystem(assets:MovieClip, zones:MovieClip, numbers:MovieClip, boxes:MovieClip, data:Object) {

        _data = data;
        _assets = assets;

//        _zones = zones;

        _numbers = numbers
        _currentZone = assets.zone1;
        _currentNum = numbers.num1;
        _boxes = boxes;

        if (this.stage) {
            init();
        } else {
            addEventListener(Event.ADDED_TO_STAGE, init);
        }

    }

    private function init(event:Event = null):void {

        if (event) {
            removeEventListener(Event.ADDED_TO_STAGE, init);
        }

        subject = new SwatchSubject();
        subject.setActiveZone( _currentZone );

        var xPos:Number = 75;
        var xStagger:Number = 34;
        var initColor:int;

        for (var i:int = 0, len:int = _data.swatches.length; i < len; i++) {

            var params:Object = {};

            params.fillColor = _data.swatches[i].color;
            params.state = _data.swatches[i].state;
            params.stateName = String(_data.swatches[i].color);

            if (params.state == "on") {
                _initColor = _data.swatches[i].color;
                _cachedState = _initColor;
            }

            var sw:Swatch = new Swatch(params);

            sw.x = xPos;
            sw.y = 8;

            addChild(sw);


            xPos += xStagger;


            var swObserver:SwatchObserver = new SwatchObserver(sw, params);
            addChild(swObserver);

            subject.addObserver(swObserver);

        }

//        _zoneState = new Context_Zones(_zones, _numbers);

        var tl:TimelineLite = new TimelineLite({pause:true});

        for (var k:int = 1; k <= 10; k++) {

//            TweenLite.to(_assets["zone" + k], 0, {tint:_initColor});
//            TweenMax.to(_assets["zone" + k], 0, {glowFilter:{color:_initColor, alpha:1, blurX:20,blurY:ConfigGlobal.ALIENFX_NUMBER_BLUR}, tint:_initColor});
            TweenMax.to(_assets["zone" + k], 0, {glowFilter:{color:_initColor, quality:ConfigGlobal.ALIENFX_QUALITY ,strength:ConfigGlobal.ALIENFX_STRENGTH, alpha:1, blurX:ConfigGlobal.ALIENFX_NUMBER_BLUR , blurY:ConfigGlobal.ALIENFX_NUMBER_BLUR}, tint:_initColor});

            tl.insert(TweenLite.to(_assets["zone" + k], GlobalAnim.TRANSISITION, {alpha:1}));

            addHandCurserNoChildren(_assets["hs" + k]);
            _assets["hs" + k].addEventListener(MouseEvent.CLICK, setZoneState, false, 0, true);
        }

        tl.play();


//        TweenLite.to(_zones, GlobalAnim.TRANSISITION, {alpha:1});

        //Set Default State
        TweenLite.to(_numbers.num2.ON, GlobalAnim.TRANSISITION, {alpha: 1});
        TweenLite.to(_numbers.num2.OFF, GlobalAnim.TRANSISITION, {alpha: 0});

        _boxes.setChildIndex(_boxes.box2, _boxes.numChildren -1);
        _currentBox = _boxes.box2;
        _currentNum = _numbers.num2;

        TweenLite.to(_currentBox, GlobalAnim.TRANSISITION, {tint:0xffffff});

        subject.setActiveZone( _assets.zone2 );
    }





    private function setZoneState(event:MouseEvent):void {

        var tEvt:TrackEvent = new TrackEvent("AlienFx","Zone-" + String(event.target.name).substring(2) );
        alienFxModule.Omniture.Tracking.trackMetrics(tEvt);

        TweenLite.to(_currentNum.ON, GlobalAnim.TRANSISITION, {alpha: 0});
        TweenLite.to(_currentNum.OFF, GlobalAnim.TRANSISITION, {alpha: 1});

        TweenLite.to(_currentBox, GlobalAnim.TRANSISITION, {tint:0x808080});

        switch (event.target.name) {
            case "hs1":
                TweenLite.to(_numbers.num1.ON, GlobalAnim.TRANSISITION, {alpha: 1});
                TweenLite.to(_numbers.num1.OFF, GlobalAnim.TRANSISITION, {alpha: 0});
                _currentNum = _numbers.num1;
                subject.setActiveZone( _assets.zone1 );

                break;
            case "hs2":
                TweenLite.to(_numbers.num2.ON, GlobalAnim.TRANSISITION, {alpha: 1});
                TweenLite.to(_numbers.num2.OFF, GlobalAnim.TRANSISITION, {alpha: 0});

                TweenLite.to(_boxes.box2, GlobalAnim.TRANSISITION, {tint:0xffffff});
                _boxes.setChildIndex(_boxes.box2, _boxes.numChildren -1);
                _currentNum = _numbers.num2;
                _currentBox = _boxes.box2;

                subject.setActiveZone( _assets.zone2 );
                break;
            case "hs3":

                TweenLite.to(_numbers.num3.ON, GlobalAnim.TRANSISITION, {alpha: 1});
                TweenLite.to(_numbers.num3.OFF, GlobalAnim.TRANSISITION, {alpha: 0});
                _currentNum = _numbers.num3;

                TweenLite.to(_boxes.box3, GlobalAnim.TRANSISITION, {tint:0xffffff});
                _boxes.setChildIndex(_boxes.box3, _boxes.numChildren -1);
                _currentBox = _boxes.box3;

                subject.setActiveZone( _assets.zone3 );
                break;
            case "hs4":
                TweenLite.to(_numbers.num4.ON, GlobalAnim.TRANSISITION, {alpha: 1});
                TweenLite.to(_numbers.num4.OFF, GlobalAnim.TRANSISITION, {alpha: 0});
                _currentNum = _numbers.num4;

                TweenLite.to(_boxes.box4, GlobalAnim.TRANSISITION, {tint:0xffffff});
                _boxes.setChildIndex(_boxes.box4, _boxes.numChildren -1);
                _currentBox = _boxes.box4;

                subject.setActiveZone( _assets.zone4 );
                break;
            case "hs5":
                TweenLite.to(_numbers.num5.ON, GlobalAnim.TRANSISITION, {alpha: 1});
                TweenLite.to(_numbers.num5.OFF, GlobalAnim.TRANSISITION, {alpha: 0});
                _currentNum = _numbers.num5;

                TweenLite.to(_boxes.box5, GlobalAnim.TRANSISITION, {tint:0xffffff});
                _boxes.setChildIndex(_boxes.box5, _boxes.numChildren -1);
                _currentBox = _boxes.box5;

                subject.setActiveZone( _assets.zone5 );
                break;
            case "hs6":
                TweenLite.to(_numbers.num6.ON, GlobalAnim.TRANSISITION, {alpha: 1});
                TweenLite.to(_numbers.num6.OFF, GlobalAnim.TRANSISITION, {alpha: 0});
                _currentNum = _numbers.num6;
                subject.setActiveZone( _assets.zone6 );
                break;
            case "hs7":
                TweenLite.to(_numbers.num7.ON, GlobalAnim.TRANSISITION, {alpha: 1});
                TweenLite.to(_numbers.num7.OFF, GlobalAnim.TRANSISITION, {alpha: 0});
                _currentNum = _numbers.num7;
                subject.setActiveZone( _assets.zone7 );
                break;
            case "hs8":
                TweenLite.to(_numbers.num8.ON, GlobalAnim.TRANSISITION, {alpha: 1});
                TweenLite.to(_numbers.num8.OFF, GlobalAnim.TRANSISITION, {alpha: 0});
                _currentNum = _numbers.num8;
                subject.setActiveZone( _assets.zone8 );
                break;
            case "hs9":
                TweenLite.to(_numbers.num9.ON, GlobalAnim.TRANSISITION, {alpha: 1});
                TweenLite.to(_numbers.num9.OFF, GlobalAnim.TRANSISITION, {alpha: 0});
                _currentNum = _numbers.num9;
                subject.setActiveZone( _assets.zone9 );
                break;
            case "hs10":
                TweenLite.to(_numbers.num10.ON, GlobalAnim.TRANSISITION, {alpha: 1});
                TweenLite.to(_numbers.num10.OFF, GlobalAnim.TRANSISITION, {alpha: 0});
                _currentNum = _numbers.num10;
                subject.setActiveZone( _assets.zone10 );
                break;


        }




    }
    public function get initColor():uint {
        return _initColor;
    }


}
}
