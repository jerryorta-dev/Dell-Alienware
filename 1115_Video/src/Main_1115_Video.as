package {

import com.dell.DocumentClass;
import com.dell.alienFx.GlobalAnim;
import com.dell.alienFx.SwatchAFX;
import com.dell.services.PathManager;
import com.dell.services.TrackEvent;
import com.dell.video.playerFactoryPattern.playerFactory.abstractCreators.AbstractPlayerCreator;
import com.dell.video.playerFactoryPattern.playerFactory.creators.CreatePlayer;
import com.demonsters.debugger.MonsterDebugger;
import com.dpa.utils.displayObject.getLoaderInfo;
import com.dpa.utils.motion.rateOfSpeed;
import com.dpa.utils.object.addHandCurserNoChildren;
import com.greensock.BlitMask;
import com.greensock.TweenLite;
import com.greensock.TweenMax;
import com.greensock.easing.*;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.ImageLoader;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.XMLLoader;
import com.greensock.plugins.*;
import com.omniture.AppMeasurement;
import com.ooyala.api.FlashPlayer;

import flash.display.*;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.UncaughtErrorEvent;
import flash.geom.Point;
import flash.ui.Mouse;
import flash.utils.getTimer;

import video.Omniture.Tracking;

import video.loading.VideoParser;

import utils.object.numProperties;

import video.CreateCallOutThumbnail;
import video.loading.VideoParser;

[SWF(width="965", height="500", backgroundColor="0x000000", frameRate="40")]
public class Main_1115_Video extends DocumentClass {

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


    private var s:AppMeasurement = new AppMeasurement();
    private var _embedCode:String = "";
    private var _appName:String = "";
    private var _params:Object;
    private var _apiComplete:Boolean = false;
    private var langCodeArray:Array;
    private var validLanguage:Boolean = false;

    private var _player:FlashPlayer;
    private var _playerContainer:Sprite;
    private var _playerBorder:Sprite;
    private var _playerXPos:Number = 254;
    private var _PlayerYPos:Number = 50;
    private var _playerWidth:Number = 560;
    private var _playerHeight:Number = 315;

    private var parser:VideoParser;
    private var queue:LoaderMax;
    private var ui:videoUI;

    private var _data:Object;
    private var _initPlayer:Boolean = false;

    private var _maxItemNav:Number = 12;
    private var _activeVideo:String;

    private var _totalListLength:int;

    public static var s:AppMeasurement;
    public static var site:String 					= "AlienWare-1115";  //product name, this is used in tracking, so it is important.

    public function Main_1115_Video() {


    }

    private var paramObj:Object;

    /*
     Error #2044: Unhandled SecurityErrorEvent:. text=Error #2121: Security sandbox violation: http://sandbox.gsdprototypes.com/1115-product-launch-aw-17-ranger-flash/shell/Main-1115-Video.swf: http://player.ooyala.com/ cannot access . This may be worked around by calling Security.allowDomain.

     */

    override protected function init():void {

        graphics.beginFill(0x000000, 1);
        graphics.drawRect(0, 0, 965, 500);
        graphics.endFill();

        stage.addEventListener(MouseEvent.ROLL_OVER, showMouse, false, 0, true);

//        MonsterDebugger.initialize(this);
//        MonsterDebugger.trace(this, "Hello World!");
        LoaderMax.activate([ImageLoader]);
        PathManager.init(getLoaderInfo(this));
        initTracking();
        TweenPlugin.activate([ThrowPropsPlugin, TintPlugin]);


        //ooyala player hides mouse
//        stage.addEventListener(MouseEvent.ROLL_OVER, showMouse, false, 0, true);
        stage.addEventListener(Event.FULLSCREEN, adjustPlayerFullScreen, false, 0, true);


        // debug
        trace("country: " + PathManager.country);
        trace("language: " + PathManager.language);

        loadXML();
    }

    public static function initTracking():void
    {

        s = new AppMeasurement();

        video.Omniture.Tracking.configActionSource();

        var tEvt:TrackEvent = new TrackEvent("Video","Loading", "subModule");
        video.Omniture.Tracking.trackMetrics(tEvt);
    }



    private function adjustPlayerFullScreen(event:Event):void {
        if (stage.displayState == StageDisplayState.NORMAL)
        {
            ui.visible = true;
            _playerContainer.x = _playerXPos;
            _playerContainer.y = _PlayerYPos;

//            _playerContainer.width = _playerBorder.width = _player.width = _playerWidth;
//            _playerContainer.height = _playerBorder.height = _player.height = _playerHeight;

            _playerContainer.scaleX = 1;
            _playerContainer.scaleY = 1;
            _player.width = _playerWidth;
            _player.height = _playerHeight;

            _playerBorder.visible = true;
        }
        else
        {
            ui.visible = false;
            _playerContainer.x = _playerContainer.y = 0;
            _player.x = _player.y = 0;

            _playerContainer.width = stage.stageWidth;
            _playerContainer.height = stage.stageHeight;

            _playerBorder.visible = false;
        }
    }

    private function adjustPlayerNormal():void {

    }

    private function showMouse(event:MouseEvent):void {
        Mouse.show();
    }

    private function loadXML():void {
        parser = new VideoParser({onComplete: imgLoader});

        queue = new LoaderMax({name: "videoQueue", onComplete: parser.parseData, requireWithRoot: this.root});
        queue.append(new XMLLoader(PathManager.getConfigXML('video-config'), {name: "videoConfig"}));
        queue.append(new XMLLoader(PathManager.getLocalizedXML(), {name: "videoCopy"}));
        queue.load();
    }

    private var queue2:LoaderMax;

    public function imgLoader(data:Object):void {
        _data = data;

        queue2 = new LoaderMax({onComplete: buildPlayer, requireWithRoot: this.root});
        var _thumbs:XMLList = (queue.getContent("videoConfig") as XML).videoGallery.LoaderMax;
        for each (var _t:XML in _thumbs[0].ImageLoader) {
            queue2.append(new ImageLoader(PathManager.baseURL + "assets/image/" + _t.@url, {name:_t.@name}));

        }

        MonsterDebugger.trace(queue2, "Video Queue2");
        queue2.load();
    }

    private function buildPlayer(event:LoaderEvent):void {


        var playerInstance:AbstractPlayerCreator = new CreatePlayer();
        playerInstance.draw(CreatePlayer.PLAYER_INSTANCE, this, _playerXPos, _PlayerYPos, {name: "videoPlayerInstance", width: _playerWidth, height: _playerHeight});
//        _player = playerInstance.getPlayer(this, "videoPlayerInstance");
        _player = this.getChildByName("videoPlayerInstance")["player"] as FlashPlayer;
        _playerContainer = this.getChildByName("videoPlayerInstance") as Sprite;
        _playerBorder = this.getChildByName("videoPlayerInstance")["border"];

        buildUI();
    }


    private function getVideoWithAutoPlay(value:String):void {
        _player.queryStringParameters = "embedCode=" + _data[value].ooyalaID + "&autoplay=1&hide=fullscreen";
    }

    private function getVideoPaused(value:String):void {
        _player.queryStringParameters = "embedCode=" + _data[value].ooyalaID + "&autoplay=0&hide=fullscreen";
    }

    private function buildUI():void {


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

            if (String(_data["video" + i].ooyalaID).length > 0) {

                //init the initial player
                if (!_initPlayer) {
                    _initPlayer = true;
                    this.getVideoPaused("video" + i);
                }

                var refObj:Object = {};

                var _tnButton:tn = new tn();

                TweenLite.to(_tnButton.ON, 0, {tint: SwatchAFX.LINK_TEAL});

                if (i == 1) {
                    _tnButton.btnPlay.alpha = 0;
                    _tnButton.ON.alpha = 1;
                } else {
                    _tnButton.btnPlay.alpha = 0;
                    _tnButton.ON.alpha = 0;
                }

                _tnButton.name = "video" + i;
                _tnButton.x = xPos;
                _tnButton.y = 1;

                ui.container.addChild(_tnButton);
                refObj.movieclip = _tnButton;

//                var image:DisplayObject = LoaderMax.getContent("video" + i);
                var image:DisplayObject = (queue2.getLoader("video" + i) as ImageLoader).rawContent;
                refObj.name = "video" + i;
                image.x = image.y = 0;
                _tnButton.container.addChild(image);
                _tnButton.container.mask = _tnButton.Mask;
                _tnButton.Mask.alpha = 0;

                //Add Callout
                var callOut:CreateCallOutThumbnail = new CreateCallOutThumbnail({name: "videoCallout" + i, htmlText: _data["video" + i].xmlNode});
                callOut.alpha = 0;
                callOut.visible = false;
                callOut.x = _tnButton.localToGlobal(new Point(0, 0)).x;
                callOut.y = _tnButton.localToGlobal(new Point(0, 0)).y - callOut.rectHeight;
                callOut.refMC = _tnButton;

                addItemEventHandlers(_tnButton);

                addChild(callOut);

                _data["video" + i].xPos = xPos;
                btns.push(refObj);
                xPos += _data.stagger;
            }
        }

        _leftVisibleItemNumber = 1;
        clickedItemName = "video1";
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
        var tEvt:TrackEvent = new TrackEvent("Video","thumbnail-" + newTargetName);
        video.Omniture.Tracking.trackMetrics(tEvt);

        clickedItemName = newTargetName;
        this.getVideoWithAutoPlay(clickedItemName);

        var btnPlay:MovieClip = (ui.container.getChildByName(clickedItemName)["btnPlay"] as MovieClip);
        TweenLite.to(btnPlay, GlobalAnim.TRANSISITION, {alpha: 0});

        for (var i:int = 1; i < _totalListLength; i++) {
            var border:MovieClip = (ui.container.getChildByName("video" + i) as MovieClip);
            if (border.ON.alpha == 1 && (clickedItemName != ("video" + i))) {
                TweenLite.to(border.ON, GlobalAnim.TRANSISITION, {alpha: 0, onComplete: updateBlitMask});
                break;
            }
        }
    }

    private function updateBlitMask():void {
        blitMask.update(null, true);
    }

    //**************************************************************************************************
    //**************************************************************************************************
    //**************************************************************************************************
    //CALLOUT HANDLER


    private function callOutOnEnterFrame(value:Boolean):void {
        for (var c:int = 1; c < _totalListLength; c++) {
            this.getChildByName("videoCallout" + c)["setEnterFrame"] = value;
        }
    }

    //**************************************************************************************************
    //**************************************************************************************************
    //**************************************************************************************************
    //Horizonal Nav

    private function moveRight(event:MouseEvent):void {
        var tEvt:TrackEvent = new TrackEvent("Video","RightNavButton");
        video.Omniture.Tracking.trackMetrics(tEvt);

        callOutOnEnterFrame(true);
        if (_leftVisibleItemNumber < _maxItemNav) {
            var nextXPos:Number = -(_data["video" + (_leftVisibleItemNumber + 1)].xPos) + containerInitPos;
            TweenLite.to(ui.container, GlobalAnim.TRANSISITION, {x: nextXPos, onComplete: callOutOnEnterFrame, onCompleteParams: [false]});
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
        var tEvt:TrackEvent = new TrackEvent("Video","LeftNavButton");
        video.Omniture.Tracking.trackMetrics(tEvt);

        callOutOnEnterFrame(true);
        if (_leftVisibleItemNumber > 1) {
            var nextXPos:Number = -(_data["video" + (_leftVisibleItemNumber - 1)].xPos) + containerInitPos;
            TweenLite.to(ui.container, GlobalAnim.TRANSISITION, {x: nextXPos, onComplete: callOutOnEnterFrame, onCompleteParams: [false]});
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
        var tEvt:TrackEvent = new TrackEvent("Video","thumbnail: " + event.target.name);
        video.Omniture.Tracking.trackMetrics(tEvt);
        newTargetName = event.target.name;
    }

    private function onMouseOver(event:MouseEvent):void {
        if (event.target.name != clickedItemName) {
            var border:MovieClip = (event.target.getChildByName("ON") as MovieClip);
            var btnPlay:MovieClip = (event.target.getChildByName("btnPlay") as MovieClip);
            TweenLite.to(border, GlobalAnim.TRANSISITION, {alpha: 1});
            TweenLite.to(btnPlay, GlobalAnim.TRANSISITION, {alpha: 1});
        }

        var tName:String = event.target.name;
        var tnNum:String = tName.substring(5, tName.length);
        TweenMax.to(this.getChildByName("videoCallout" + tnNum), GlobalAnim.TRANSISITION, {autoAlpha: 1});
    }

    private function onMouseOut(event:MouseEvent):void {
        if (event.target.name != clickedItemName) {
            var border:MovieClip = (event.target.getChildByName("ON") as MovieClip);
            var btnPlay:MovieClip = (event.target.getChildByName("btnPlay") as MovieClip);
            TweenLite.to(border, GlobalAnim.TRANSISITION, {alpha: 0});
            TweenLite.to(btnPlay, GlobalAnim.TRANSISITION, {alpha: 0});
        }

        var tName:String = event.target.name;
        var tnNum:String = tName.substring(5, tName.length);
        TweenMax.to(this.getChildByName("videoCallout" + tnNum), GlobalAnim.TRANSISITION, {autoAlpha: 0});
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

        callOutOnEnterFrame(true);


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
            var tEvt:TrackEvent = new TrackEvent("Video","throwNav");
            video.Omniture.Tracking.trackMetrics(tEvt);

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

        callOutOnEnterFrame(false);

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
            if (-(_data["video" + i].xPos) > containerPos) {
                if (-( _data["video" + i].xPos + _data.stagger ) < containerPos) {

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
            if (-(_data["video" + i].xPos) > containerPos) {
                if (-( _data["video" + i].xPos + _data.stagger ) < containerPos) {

                    _leftVisibleItemNumber = i;

                    var pixelsPerSecond:Number = 400;
                    if (directionX > 0) { //direction is positive, going right
                        var timePos:Number = rateOfSpeed(Math.abs(containerPos), _data["video" + (i + 1)].xPos, pixelsPerSecond);
                        var targetXPosRight:Number = -_data["video" + (i + 1)].xPos + boundsXAdjust;
                        TweenLite.to(ui.container, timePos, {x: targetXPosRight, ease: CustomEase.byName("adjustAfterThrowPropsComplete")});
                    } else {
                        var timeNeg:Number = rateOfSpeed(_data["video" + (i)].xPos, Math.abs(containerPos), pixelsPerSecond);
                        var targetXPosLeft:Number = -_data["video" + i].xPos + boundsXAdjust;
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
            _player.pauseMovie();
        }

        if (vars.transitionOn != null) {
//            TweenLite.to(this.parent.parent, .25, {delay: .25, autoAlpha: 1});
            _player.playMovie();
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
