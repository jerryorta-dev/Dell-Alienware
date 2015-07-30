﻿package design.moduleStatePattern{import com.dell.alienFx.GlobalAnim;import com.dell.alienFx.SwatchAFX;import com.greensock.TimelineLite;import com.greensock.TweenAlign;import com.greensock.TweenLite;import com.greensock.plugins.TintPlugin;import com.greensock.plugins.TweenPlugin;import design.calloutObserverPattern.observers.CallOut;import design.calloutObserverPattern.observers.CallOutContainer;import design.calloutObserverPattern.observers.controls.abstract.Context_Button_ON_OFF;import design.calloutObserverPattern.subjects.ConcreteCallOutSubject;import flash.display.MovieClip;import design.moduleStatePattern.abstract.Context_Modules;import design.moduleStatePattern.abstract.IState;import flash.display.Sprite;//Play State	public class Design18 implements IState	{        private var modules:Context_Modules;        private var callNumExpanded:int;        private var target:MovieClip;        private var data:Object;        //LOADER VARS        private var observerSubjectVars:Object;        private var _swfRootAW14:MovieClip;        private var _swfRootAW17:MovieClip;        private var _swfRootAW18:MovieClip;        private var concreteSubject:ConcreteCallOutSubject;        private var _callOutParentContainer:Sprite;        private var _featureContainer14:Sprite;        private var _featureContainer17:Sprite;        private var _featureContainer18:Sprite;        private var _callOutContainer:Sprite;        private var _sliderAW14:Slider;        private var _sliderAW17:Slider;        private var _sliderAW18:Slider;        private var _btnOnOffAW14:Context_Button_ON_OFF;        private var _btnOnOffAW17:Context_Button_ON_OFF;        private var _btnOnOffAW18:Context_Button_ON_OFF;        private var _icons:MovieClip;        private var  newState:Number;		public function Design18(_modules:Context_Modules, _target:MovieClip, _data:Object, icons:MovieClip)		{            TweenPlugin.activate([TintPlugin]);            this.data = _data;            this.modules = _modules;            this.target = _target;            _swfRootAW14 = _data.swfRootAW18;            _featureContainer14 = _data.featureContainerAW14;            _featureContainer17 = _data.featureContainerAW17;            _featureContainer18 = _data.featureContainerAW18;            _sliderAW14 = data.sliderAW14;            _sliderAW17 = data.sliderAW17;            _sliderAW18 = data.sliderAW18;            _btnOnOffAW14 = data.onOffAW14;            _btnOnOffAW17 = data.onOffAW17;            _btnOnOffAW18 = data.onOffAW18;            _icons = icons;            buildUI();		}		public function activateDesign14():void		{            newState = 14;            modules.removeEventHandlers();            var delay:Number = GlobalAnim.TRANSISITION + .2;            var close:TimelineLite = new TimelineLite();            close.insertMultiple([                TweenLite.to(modules.coaw18Array[1], GlobalAnim.TRANSISITION, {alpha:0}),                TweenLite.to(modules.coaw18Array[5], GlobalAnim.TRANSISITION, {alpha:0}),                TweenLite.to(modules.coaw18Array[0], GlobalAnim.TRANSISITION, {alpha:0}),                TweenLite.to(modules.coaw18Array[2], GlobalAnim.TRANSISITION, {alpha:0}),                TweenLite.to(modules.coaw18Array[4], GlobalAnim.TRANSISITION, {alpha:0}),                TweenLite.to(modules.coaw18Array[6], GlobalAnim.TRANSISITION, {alpha:0}),                TweenLite.to(modules.coaw18Array[3], GlobalAnim.TRANSISITION, {alpha:0})            ],0, TweenAlign.NORMAL,.05)            //Slider switch            TweenLite.to(target.sliderAW18, GlobalAnim.TRANSISITION, {autoAlpha: 0});            TweenLite.to(target.sliderAW17, GlobalAnim.TRANSISITION, {autoAlpha: 0});            TweenLite.to(target.sliderAW14, GlobalAnim.TRANSISITION, {delay:delay, autoAlpha: 1});            //ON OFF button switch            TweenLite.to(target.btnOnOffAW18, GlobalAnim.TRANSISITION, {autoAlpha: 0});            TweenLite.to(target.btnOnOffAW17, GlobalAnim.TRANSISITION, {autoAlpha: 0});            TweenLite.to(target.btnOnOffAW14, GlobalAnim.TRANSISITION, {delay:delay, autoAlpha: 1});            //FEATURES            TweenLite.to(target.featureContainer18, GlobalAnim.TRANSISITION, {delay:delay, autoAlpha: 0});            TweenLite.to(target.featureContainer17, GlobalAnim.TRANSISITION, {delay:delay, autoAlpha: 0});            TweenLite.to(target.featureContainer14, GlobalAnim.TRANSISITION, {delay:delay, autoAlpha: 1});            for (var i:int = 1, len:int = 7; i <= len; i++) {                modules.coaw14Array[i].alpha = 0;                if (modules.coaw14Array[i].isExpanded) {                    callNumExpanded = i;                    modules.coaw14Array[i].close();                }            }            var open:TimelineLite = new TimelineLite({delay:delay, onComplete:onTimeLineComplete, onCompleteParams:[14]});            open.insertMultiple([                TweenLite.to(modules.coaw14Array[3], GlobalAnim.TRANSISITION, {alpha:1}),                TweenLite.to(modules.coaw14Array[6], GlobalAnim.TRANSISITION, {alpha:1}),                TweenLite.to(modules.coaw14Array[5], GlobalAnim.TRANSISITION, {alpha:1}),                TweenLite.to(modules.coaw14Array[2], GlobalAnim.TRANSISITION, {alpha:1}),                TweenLite.to(modules.coaw14Array[0], GlobalAnim.TRANSISITION, {alpha:1}),                TweenLite.to(modules.coaw14Array[4], GlobalAnim.TRANSISITION, {alpha:1}),                TweenLite.to(modules.coaw14Array[7], GlobalAnim.TRANSISITION, {alpha:1}),                TweenLite.to(modules.coaw14Array[1], GlobalAnim.TRANSISITION, {alpha:1})            ],0, TweenAlign.NORMAL,.05)            TweenLite.to(target.swfAW18Root, GlobalAnim.TRANSISITION, {autoAlpha: 0});            TweenLite.to(target.swfAW17Root, GlobalAnim.TRANSISITION, {autoAlpha: 0});            TweenLite.to(target.swfAW14Root, GlobalAnim.TRANSISITION, {delay:delay, autoAlpha: 1});            TweenLite.to(target.iconsSize.aw14.fill, GlobalAnim.TRANSISITION, {delay:delay, tint: SwatchAFX.LINK_TEAL});            TweenLite.to(target.iconsSize.aw18.fill, GlobalAnim.TRANSISITION, {tint: SwatchAFX.DESIGN_ICON_OFF});            TweenLite.to(target.iconsSize.aw17.fill, GlobalAnim.TRANSISITION, {tint: SwatchAFX.DESIGN_ICON_OFF});		}		public function activateDesign17():void		{            newState = 17;            modules.removeEventHandlers();            var delay:Number = GlobalAnim.TRANSISITION + .2;            var close:TimelineLite = new TimelineLite();            close.insertMultiple([                TweenLite.to(modules.coaw18Array[1], GlobalAnim.TRANSISITION, {alpha:0}),                TweenLite.to(modules.coaw18Array[5], GlobalAnim.TRANSISITION, {alpha:0}),                TweenLite.to(modules.coaw18Array[0], GlobalAnim.TRANSISITION, {alpha:0}),                TweenLite.to(modules.coaw18Array[2], GlobalAnim.TRANSISITION, {alpha:0}),                TweenLite.to(modules.coaw18Array[4], GlobalAnim.TRANSISITION, {alpha:0}),                TweenLite.to(modules.coaw18Array[6], GlobalAnim.TRANSISITION, {alpha:0}),                TweenLite.to(modules.coaw18Array[3], GlobalAnim.TRANSISITION, {alpha:0})            ],0, TweenAlign.NORMAL,.05)            //Slider switch            TweenLite.to(target.sliderAW18, GlobalAnim.TRANSISITION, {autoAlpha: 0});            TweenLite.to(target.sliderAW14, GlobalAnim.TRANSISITION, {autoAlpha: 0});            TweenLite.to(target.sliderAW17, GlobalAnim.TRANSISITION, {delay:delay, autoAlpha: 1});            //ON OFF button switch            TweenLite.to(target.btnOnOffAW18, GlobalAnim.TRANSISITION, {autoAlpha: 0});            TweenLite.to(target.btnOnOffAW14, GlobalAnim.TRANSISITION, {autoAlpha: 0});            TweenLite.to(target.btnOnOffAW17, GlobalAnim.TRANSISITION, {delay:delay, autoAlpha: 1});            //FEATURES            TweenLite.to(target.featureContainer18, GlobalAnim.TRANSISITION, {delay:delay, autoAlpha: 0});            TweenLite.to(target.featureContainer14, GlobalAnim.TRANSISITION, {delay:delay, autoAlpha: 0});            TweenLite.to(target.featureContainer17, GlobalAnim.TRANSISITION, {delay:delay, autoAlpha: 1});            for (var i:int = 0, len:int = 7; i < len; i++) {                modules.coaw17Array[i].alpha = 0;                if (modules.coaw17Array[i].isExpanded) {                    callNumExpanded = i;                    modules.coaw17Array[i].close();                }            }            var open:TimelineLite = new TimelineLite({delay:delay, onComplete:onTimeLineComplete, onCompleteParams:[17]});            open.insertMultiple([                TweenLite.to(modules.coaw17Array[3], GlobalAnim.TRANSISITION, {alpha:1}),                TweenLite.to(modules.coaw17Array[6], GlobalAnim.TRANSISITION, {alpha:1}),                TweenLite.to(modules.coaw17Array[4], GlobalAnim.TRANSISITION, {alpha:1}),                TweenLite.to(modules.coaw17Array[2], GlobalAnim.TRANSISITION, {alpha:1}),                TweenLite.to(modules.coaw17Array[0], GlobalAnim.TRANSISITION, {alpha:1}),                TweenLite.to(modules.coaw17Array[5], GlobalAnim.TRANSISITION, {alpha:1}),                TweenLite.to(modules.coaw17Array[1], GlobalAnim.TRANSISITION, {alpha:1})            ],0, TweenAlign.NORMAL,.05)            //SWFS            TweenLite.to(target.swfAW18Root, GlobalAnim.TRANSISITION, {autoAlpha: 0});            TweenLite.to(target.swfAW17Root, GlobalAnim.TRANSISITION, {delay:delay, autoAlpha: 1});            TweenLite.to(target.iconsSize.aw17.fill, GlobalAnim.TRANSISITION, {delay:delay, tint: SwatchAFX.LINK_TEAL});            TweenLite.to(target.iconsSize.aw14.fill, GlobalAnim.TRANSISITION, {tint: SwatchAFX.DESIGN_ICON_OFF});            TweenLite.to(target.iconsSize.aw18.fill, GlobalAnim.TRANSISITION, {tint: SwatchAFX.DESIGN_ICON_OFF});		}        public function activateDesign18():void {//            trace("Your already in 17 State");        }//        private function getCallout(num:Number, i:Number):CallOut {//            return target["featureContainer" + num].getChildByName("design" + num + "LabelContainer").getChildByName("feature" + i + "Container").getChildByName("feature" + i);//        }        private function onTimeLineComplete(num:Number):void {            TweenLite.delayedCall(.4, addModuleEventHandlers)            if (newState == 14) {                modules.coaw14Array[callNumExpanded].expand();            }            if (newState == 17) {                modules.coaw17Array[callNumExpanded].expand();            }        }        private function addModuleEventHandlers():void {            modules.addEventHandlers();            if (newState == 14) {                modules.setState(modules.getDesign14State());            }            if (newState == 17) {                modules.setState(modules.getDesign17State());            }        }        public function buildUI():void {//            trace("Bulding design 18 UI");            _callOutParentContainer = CallOutContainer.createLabelContainer(data.containerRectangle);            _callOutParentContainer.name = "design18LabelContainer";//            _callOutParentContainer.alpha = 0;//            _callOutParentContainer.visible = false;            _featureContainer18.addChild(_callOutParentContainer);            _featureContainer18.getChildByName("design18LabelContainer").x = 965 - _callOutParentContainer.width - 85;            _featureContainer18.getChildByName("design18LabelContainer").y = 0;            _featureContainer18.alpha = 0;            _featureContainer18.visible = false;            observerSubjectVars = {};            observerSubjectVars.sliderInitRotation = data.sliderInitRotation;            observerSubjectVars.slider = _sliderAW18;            observerSubjectVars.swfRoot = _swfRootAW14;            concreteSubject = new ConcreteCallOutSubject(observerSubjectVars);//            var callOutArray:Array = new Array();            var len:int = data.featureArray.length;            for (var i:int = 0; i < len; i++) {                data.featureArray[i].lineToTarget = _swfRootAW14[data.featureArray[i].lineToTargetName];                data.featureArray[i].container = _swfRootAW14;                data.featureArray[i].slider = _sliderAW18;//                traceProps(_data.featureArray[i]);                _callOutContainer = CallOutContainer.createCallOutContainer(data.featureArray[i]);                CallOutContainer.addCallOutContainerToLabelContainer(_callOutParentContainer, _callOutContainer);                data.featureArray[i].isAW = 18;                var callout:CallOut = new CallOut(data.featureArray[i]);                callout.name = "feature" + (i + 1);                modules.coaw18Array.push(callout);                _callOutContainer.addChild(callout);                concreteSubject.addObserver(callout, null);                _callOutParentContainer.parent.setChildIndex(_callOutParentContainer, _callOutParentContainer.parent.numChildren - 1);                target.setChildIndex(target.sliderAW18, target.numChildren - 1);                target.setChildIndex(target.btnOnOffAW18, target.numChildren - 1);            }            concreteSubject.tweenTo({teenTo: 0});            var vars:Object = new Object();            vars.close = true;            vars.state = "feature6";            vars.enterFrame = false;//            vars.to = 0;            concreteSubject.setState(vars);            //ADD ON OFF BUTTON            concreteSubject.addOnOFF(_btnOnOffAW18);        }        public function get featureContainer17():Sprite {            return _featureContainer17;        }        public function set featureContainer17(value:Sprite):void {            _featureContainer17 = value;        }        public function get swfRootAW14():MovieClip {            return _swfRootAW14;        }        public function set swfRootAW14(value:MovieClip):void {            _swfRootAW14 = value;        }    }}