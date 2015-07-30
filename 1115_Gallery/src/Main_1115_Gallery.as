package {

import com.dell.DocumentClass;
import com.dell.alienFx.GlobalAnim;
import com.dell.alienFx.SwatchAFX;
import com.dell.services.PathManager;
import com.dell.services.TrackEvent;
import com.demonsters.debugger.MonsterDebugger;
import com.dpa.utils.displayObject.getLoaderInfo;
import com.dpa.utils.motion.rateOfSpeed;
import com.dpa.utils.object.addHandCurserNoChildren;
import com.greensock.BlitMask;
import com.greensock.TweenLite;
import com.greensock.TweenMax;
import com.greensock.easing.CustomEase;
import com.greensock.easing.Strong;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.ImageLoader;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.XMLLoader;
import com.greensock.plugins.ThrowPropsPlugin;
import com.greensock.plugins.TintPlugin;
import com.greensock.plugins.TweenPlugin;
import com.omniture.AppMeasurement;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.utils.getTimer;

import gallery.Omniture.Tracking;

import gallery.heroImages.HeroImage;

import gallery.loading.GalleryParser;

import utils.object.numProperties;

[SWF(width="965", height="500", backgroundColor="0x000000")]
public class Main_1115_Gallery extends DocumentClass {

    private const HERO_IMG_X:Number = 170;
    private const HERO_IMG_Y:Number = 20;
    private const HERO_TEXT_Y:Number = 20;

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


    private var parser:GalleryParser;
    private var queue:LoaderMax;
    private var ui:videoUI;

    private var _data:Object;

    private var _maxItemNav:Number = 5;

    public static var s:AppMeasurement;
    public static var site:String = "AlienWare-1115";  //product name, this is used in tracking, so it is important.


    public function Main_1115_Gallery() {

    }

    override protected function init():void {
        super.init();

        graphics.beginFill(0x000000, 1);
        graphics.drawRect(0, 0, 965, 500);
        graphics.endFill();

        LoaderMax.activate([ImageLoader]);
        initTracking();
        PathManager.init(getLoaderInfo(this));
        TweenPlugin.activate([ThrowPropsPlugin, TintPlugin]);
        MonsterDebugger.initialize(this);
        // debug
        trace("country: " + PathManager.country);
        trace("language: " + PathManager.language);

        loadXML();
    }

    public static function initTracking():void {

        s = new AppMeasurement();

        gallery.Omniture.Tracking.configActionSource();

        var tEvt:TrackEvent = new TrackEvent("Gallery", "Loading", "subModule");
        gallery.Omniture.Tracking.trackMetrics(tEvt);
    }

    private function loadXML():void {
        parser = new GalleryParser({onComplete: imgLoader});
        queue = new LoaderMax({name: "imageQueue", onComplete: parser.parseData, requireWithRoot: this.root});
        queue.append(new XMLLoader(PathManager.getConfigXML('gallery-config'), {name: "galleryConfig"}));
        queue.append(new XMLLoader(PathManager.getLocalizedXML(), {name: "galleryCopy"}));
        queue.load();
    }

    private var _totalListLength:Number;

    private var queue2:LoaderMax;

    public function imgLoader(data:Object):void {
        _data = data;

        queue2 = new LoaderMax({onComplete: buildUI})
        var _thumbs:XMLList = (queue.getContent("galleryConfig") as XML).gallery.LoaderMax;
        for each (var _t:XML in _thumbs[0].ImageLoader) {

            MonsterDebugger.trace(this, _t.@name.toString());

            queue2.append(new ImageLoader( PathManager.baseURL + "assets/image/" + _t.@url, {name:_t.@name}));
        }
        queue2.load();
    }

    private function buildUI(event:LoaderEvent):void {


        ui = new videoUI();
        ui.x = 127;
        ui.y = 415;
        addChild(ui);

        ui.arrowLeft.addEventListener(MouseEvent.MOUSE_DOWN, moveLeft, false, 0, true);
        ui.arrowRight.addEventListener(MouseEvent.MOUSE_DOWN, moveRight, false, 0, true);
        addHandCurserNoChildren(ui.arrowLeft);
        addHandCurserNoChildren(ui.arrowRight);
        ui.arrowLeft.useHandCursor = false;
        ui.arrowLeft.ON.alpha = 0;

        _totalListLength = numProperties(_data) + 1;
        _data.totalLength = _totalListLength - 1;
        var xPos:Number = 0;
        _data.stagger = 123;

        for (var i:int = 1; i < _totalListLength; i++) {
            //Create Hero Image
            var heroParams:Object = {};
            heroParams.url = _data["heroImages" + i].med;
            heroParams.name = ("med" + i);
            heroParams.xmlNode = _data["heroImages" + i].xmlNode;

            var hero:HeroImage = new HeroImage(heroParams);
            hero.x = this.HERO_IMG_X
            hero.y = this.HERO_IMG_Y;
            addChild(hero);

            //Create Thumnail
            var refObj:Object = {};
            var _tnButton:tn = new tn();
            TweenLite.to(_tnButton.ON, 0, {tint: SwatchAFX.LINK_TEAL});

            if (i == 1) {
                _tnButton.btnPlay.alpha = 0;
                _tnButton.ON.alpha = 1;
                this.getChildByName("med1").alpha = 1;
            } else {
                _tnButton.btnPlay.alpha = 0;
                _tnButton.ON.alpha = 0;
            }

            _tnButton.name = "heroImages" + i;
            _tnButton.x = xPos;
            _tnButton.y = 1;

            ui.container.addChild(_tnButton);
            refObj.movieclip = _tnButton;


            var image:DisplayObject = (queue2.getLoader("tn" + i) as ImageLoader).rawContent;
            refObj.name = "heroImages" + i;
            image.x = image.y = 0;
            _tnButton.container.addChild(image);
            _tnButton.container.mask = _tnButton.Mask;
            _tnButton.Mask.alpha = 0;

            addItemEventHandlers(_tnButton);

            _data["heroImages" + i].xPos = xPos;
            xPos += _data.stagger;
        }


        _leftVisibleItemNumber = 1;
        newTargetName = clickedItemName = "heroImages1";
        buildThrowProps();
    }

    //**************************************************************************************************
    //**************************************************************************************************
    //**************************************************************************************************
    //Add Event Handlers

    private function addItemEventHandlers(img:DisplayObject):void {
        img.addEventListener(MouseEvent.MOUSE_DOWN, itemClickHandler, false, 0, true);
        img.addEventListener(MouseEvent.ROLL_OVER, onMouseOver, false, 0, true);
        img.addEventListener(MouseEvent.ROLL_OUT, onMouseOut, false, 0, true);
        addHandCurserNoChildren(img);
    }

    private function clickHandler():void {
        var tEvt:TrackEvent = new TrackEvent("Gallery", "thumbnail-" + newTargetName.substr(10));
        gallery.Omniture.Tracking.trackMetrics(tEvt);

        if (newTargetName != clickedItemName) {
            TweenMax.killAll(true);
            clickedItemName = newTargetName;
            var strLen:int = String("heroImages").length;
            var medName:String = "med" + clickedItemName.substring(strLen, clickedItemName.length);
            var heroImage:Sprite = this.getChildByName(medName) as Sprite;
            var clickedBorder:MovieClip = (ui.container.getChildByName(clickedItemName) as MovieClip);

            TweenLite.to(clickedBorder.ON, GlobalAnim.TRANSISITION, {delay: GlobalAnim.TRANSISITION, alpha: 1});
            TweenLite.to(heroImage, GlobalAnim.TRANSISITION, {delay: GlobalAnim.TRANSISITION, alpha: 1});

            for (var i:int = 1; i < _totalListLength; i++) {
                var border:MovieClip = (ui.container.getChildByName("heroImages" + i) as MovieClip);
                var medImage:Sprite = this.getChildByName("med" + i) as Sprite;
                TweenLite.to(border.ON, GlobalAnim.TRANSISITION, {alpha: 0, onComplete: updateBlitMask});
                TweenLite.to(medImage, GlobalAnim.TRANSISITION, {alpha: 0});
            }
        }
    }

    private function updateBlitMask():void {
        blitMask.update(null, true);
    }


    //**************************************************************************************************
    //**************************************************************************************************
    //**************************************************************************************************
    //Horizonal Nav

    private function moveRight(event:MouseEvent):void {
        var tEvt:TrackEvent = new TrackEvent("Gallery", "RightNavButton");
        gallery.Omniture.Tracking.trackMetrics(tEvt);

        if (_leftVisibleItemNumber < _maxItemNav) {
            var nextXPos:Number = -(_data["heroImages" + (_leftVisibleItemNumber + 1)].xPos) + containerInitPos;
            TweenLite.to(ui.container, GlobalAnim.TRANSISITION, {x: nextXPos});
            _leftVisibleItemNumber += 1;
        }

        if (_leftVisibleItemNumber == _maxItemNav) {
            TweenLite.to(ui.arrowRight.ON, GlobalAnim.TRANSISITION, {alpha: 0});
            TweenLite.to(ui.arrowRight.OFF, GlobalAnim.TRANSISITION, {alpha: 1});
            ui.arrowRight.useHandCursor = false;
        }

        if (ui.arrowLeft.ON.alpha == 0) {
            TweenLite.to(ui.arrowLeft.ON, GlobalAnim.TRANSISITION, {alpha: 1});
            TweenLite.to(ui.arrowLeft.OFF, GlobalAnim.TRANSISITION, {alpha: 0});
            ui.arrowLeft.useHandCursor = true;
        }
    }

    private function moveLeft(event:MouseEvent):void {
        var tEvt:TrackEvent = new TrackEvent("Gallery", "LeftNavButton");
        gallery.Omniture.Tracking.trackMetrics(tEvt);

        if (_leftVisibleItemNumber > 1) {
            var nextXPos:Number = -(_data["heroImages" + (_leftVisibleItemNumber - 1)].xPos) + containerInitPos;
            TweenLite.to(ui.container, GlobalAnim.TRANSISITION, {x: nextXPos});
            _leftVisibleItemNumber -= 1;
        }

        if (_leftVisibleItemNumber == 1) {
            TweenLite.to(ui.arrowLeft.ON, GlobalAnim.TRANSISITION, {alpha: 0});
            TweenLite.to(ui.arrowLeft.OFF, GlobalAnim.TRANSISITION, {alpha: 1});
            ui.arrowLeft.useHandCursor = false;
        }

        if (ui.arrowRight.ON.alpha == 0) {
            TweenLite.to(ui.arrowRight.ON, GlobalAnim.TRANSISITION, {alpha: 1});
            TweenLite.to(ui.arrowRight.OFF, GlobalAnim.TRANSISITION, {alpha: 0});
            ui.arrowRight.useHandCursor = true;
        }
    }


    /**
     * Item click goes to a different event handler to capture it's name.
     *
     * As apposed to the "mouseDownHandler" method, which also tracks the blitMask that is clicked.
     */
    private function itemClickHandler(event:MouseEvent):void {
        var tEvt:TrackEvent = new TrackEvent("Gallery", "thumbnail: " + event.target.name);
        gallery.Omniture.Tracking.trackMetrics(tEvt);
        newTargetName = event.target.name;
    }

    private function onMouseOver(event:MouseEvent):void {
        if (event.target.name != clickedItemName) {
            var border:MovieClip = (event.target.getChildByName("ON") as MovieClip);
            var btnPlay:MovieClip = (event.target.getChildByName("btnPlay") as MovieClip);
            TweenLite.to(border, GlobalAnim.TRANSISITION, {alpha: 1});
//            TweenLite.to(btnPlay, GlobalAnim.TRANSISITION, {alpha: 1});
        }

        var tName:String = event.target.name;
        var tnNum:String = tName.substring(5, tName.length);
//        TweenLite.to(this.getChildByName("videoCallout" + tnNum), GlobalAnim.TRANSISITION, {alpha: 1});
    }

    private function onMouseOut(event:MouseEvent):void {
        if (event.target.name != clickedItemName) {
            var border:MovieClip = (event.target.getChildByName("ON") as MovieClip);
            var btnPlay:MovieClip = (event.target.getChildByName("btnPlay") as MovieClip);
            TweenLite.to(border, GlobalAnim.TRANSISITION, {alpha: 0});
//            TweenLite.to(btnPlay, GlobalAnim.TRANSISITION, {alpha: 0});
        }

        var tName:String = event.target.name;
        var tnNum:String = tName.substring(5, tName.length);
//        TweenLite.to(this.getChildByName("videoCallout" + tnNum), GlobalAnim.TRANSISITION, {alpha: 0});
    }

    //**************************************************************************************************
    //**************************************************************************************************
    //**************************************************************************************************
    //Horizontal Throw Props scroll

    private var blitMask:BlitMask;
    private var t1:uint, t2:uint, x1:Number, x2:Number, xOverlap:Number, xOffset:Number;

    private var btns:Array = [];
    private var mouseDownX:Number; //for recording the x position of the mouse when it is pressed
    private var mouseDownY:Number; //for recording the y position of the mouse when it is pressed
    private var clickedItemName:String; //for recording the button that is pressed
    private var newTargetName:String;
    private var newTargetHero:String;
    private var isMoving:Boolean = false;
    private var isCatched:Boolean = false;

    private var directionX:int; //-1 = left, 1 = right; 0 = not moving;
    private var directionY:int //-1 = up, 1 = down, 0 = not moving;
    private var directionZ:int; //-1 = away from viewer, 1 = towards viewer, 0 = not moving;

    private var containerInitPos:Number;

    private var boundsXAdjust:Number = 40;


    private function buildThrowProps():void {
        containerInitPos = ui.container.x;

        blitMask = new BlitMask(ui.container, ui.bounds.x, ui.bounds.y, ui.bounds.width, ui.bounds.height, false);
        blitMask.bitmapMode = false;
        blitMask.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
    }

    private function mouseDownHandler(event:MouseEvent):void {

        TweenLite.killTweensOf(ui.container);
        blitMask.disableBitmapMode();
        if (isMoving == true) {
            isCatched = true;
            isMoving = false;
        }

        stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);

        //now record the mouse position and button that's pressed
        mouseDownX = stage.mouseX;
        mouseDownY = stage.mouseY;

        x1 = x2 = ui.container.x;
        xOffset = ui.container.mouseX - ui.container.x;

        xOverlap = Math.max(0, ui.container.width - ui.bounds.width);
        t1 = t2 = getTimer();
        ui.container.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
        ui.container.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
    }

    private function mouseMoveHandler(event:MouseEvent):void {

        isMoving = true;
        if (blitMask.bitmapMode == false) {
            blitMask.enableBitmapMode();
        }

        var x:Number = ui.container.mouseX - xOffset;
        //if mc's position exceeds the ui.bounds, make it drag only half as far with each mouse movement (like iPhone/iPad behavior)

        if (x > ui.bounds.x) { // <- container is within bounds
            ui.container.x = (x + ui.bounds.x) * 0.5;
        } else if (x < ui.bounds.x - xOverlap) { //<container is outside of bounds on the left side
            ui.container.x = (x + ui.bounds.x - xOverlap) * 0.5;
        } else {
            ui.container.x = x;
        }

        blitMask.update(null, true);
        var t:uint = getTimer();
        //if the frame rate is too high, we won't be able to track the velocity as well, so only update the values 20 times per second

        if (t - t2 > 50) {
            x2 = x1;
            t2 = t1;
            x1 = ui.container.x;
            t1 = t;
        }
        event.updateAfterEvent();
    }

    private function mouseUpHandler(event:MouseEvent):void {

        ui.container.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);

        //if the mouse has moved less than 3 pixels in either direction when the mouse is released, treat it as a click. Otherwise ignore it.
        var tolerance:int = 15;
        var mouseXMoveOffset:Number = mouseDownX - stage.mouseX;//positive number if moving left
        var mouseYMoveOffset:Number = mouseDownY - stage.mouseY;//positive number if moving down
        if (Math.abs(mouseXMoveOffset) < tolerance && Math.abs(mouseYMoveOffset) < tolerance) {
            clickHandler();
        } else {
            var tEvt:TrackEvent = new TrackEvent("Gallery", "throwNav");
            gallery.Omniture.Tracking.trackMetrics(tEvt);

            directionX = getDirection(mouseXMoveOffset);
            directionY = getDirection(mouseYMoveOffset);
        }

        ui.container.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
        ui.container.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);

        var time:Number = (getTimer() - t2) / 1000;
        var xVelocity:Number = ( ui.container.x - x2 ) / time;
        ThrowPropsPlugin.to(ui.container, {throwProps: { x: {velocity: xVelocity, max: (ui.bounds.x), min: (ui.bounds.x) - xOverlap, resistance: 300}
        }, onUpdate: blitMask.update, onComplete: throwComplete, ease: Strong.easeOut
        }, 10, 0.3, 1);
    }

    private function throwComplete():void {

        isMoving = false;
        isCatched = false;
        blitMask.disableBitmapMode();
        setXPosOfLeftItem();
//        setXPos();
    }

    private var _leftVisibleItemNumber:Number;

    private function setXPosOfLeftItem():void {
        var containerPos:Number = ui.container.x - (ui.bounds.x + boundsXAdjust);
        for (var i:int = 1; i < _data.totalLength + 1; i++) {
            if (-(_data["heroImages" + i].xPos) > containerPos) {
                if (-( _data["heroImages" + i].xPos + _data.stagger ) < containerPos) {

                    _leftVisibleItemNumber = i;
                    break;
                }
            }
        }
    }


    private function setXPos():void {
        var containerPos:Number = ui.container.x - (ui.bounds.x + boundsXAdjust);
        trace("contianerPos: " + containerPos);
        for (var i:int = 1; i < _data.totalLength + 1; i++) {
            if (-(_data["heroImages" + i].xPos) > containerPos) {
                if (-( _data["heroImages" + i].xPos + _data.stagger ) < containerPos) {

                    _leftVisibleItemNumber = i;

                    var pixelsPerSecond:Number = 400;
                    if (directionX > 0) { //direction is positive, going right
                        var timePos:Number = rateOfSpeed(Math.abs(containerPos), _data["heroImages" + (i + 1)].xPos, pixelsPerSecond);
                        var targetXPosRight:Number = -_data["heroImages" + (i + 1)].xPos + boundsXAdjust;
                        TweenLite.to(ui.container, timePos, {x: targetXPosRight, ease: CustomEase.byName("adjustAfterThrowPropsComplete")});
                    } else {
                        var timeNeg:Number = rateOfSpeed(_data["heroImages" + (i)].xPos, Math.abs(containerPos), pixelsPerSecond);
                        var targetXPosLeft:Number = -_data["heroImages" + i].xPos + boundsXAdjust;
                        TweenLite.to(ui.container, timeNeg, {x: targetXPosLeft, ease: CustomEase.byName("adjustAfterThrowPropsComplete")});
                    }
                }
            }
        }
    }

    CustomEase.create("adjustAfterThrowPropsComplete", [
        {s: 0, cp: 0.044, e: 0.366},
        {s: 0.366, cp: 0.688, e: 1}
    ]);

    private function getDirection(value:Number):Number {
        if (value > 0) { //right, down, away from viewer
            return 1
        } else if (value < 0) {  //left, up, or towards viewer
            return -1;
        } else {
            return 0; //no movement
        }
    }

    //**************************************************************************************************
    //**************************************************************************************************
    //**************************************************************************************************
    //Talk to parent
    public function callChildFromParent(vars:Object):void {
        trace("alienFX child Called from parent");
        if (vars.transitionOff != null) {
//            TweenLite.to(this.parent.parent, .25, {autoAlpha: 0});
        }

        if (vars.transitionOn != null) {
//            TweenLite.to(this.parent.parent, .25, {delay: .25, autoAlpha: 1});
        }
    }

    private function callParent():void {
        if (this.parent.root != stage) // prevents compiler error when publishing child swf
        {
            MovieClip(this.parent.root).callFromChildSwf();
        }
    }
}
}
