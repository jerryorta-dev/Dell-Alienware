package {

import com.dell.DocumentClass;
import com.dell.alienFx.GlobalAnim;
import com.dell.alienFx.SwatchAFX;
import com.dell.services.PathManager;
import com.dell.services.TrackEvent;
import com.demonsters.debugger.MonsterDebugger;
import com.dpa.utils.array.getObjectsArray;
import com.dpa.utils.displayObject.getLoaderInfo;
import com.dpa.utils.motion.rateOfSpeed;
import com.dpa.utils.object.addHandCurserNoChildren;
import com.dpa.utils.tracers.traceProps;
import com.greensock.BlitMask;
import com.greensock.TweenLite;
import com.greensock.TweenMax;
import com.greensock.easing.CustomEase;
import com.greensock.easing.Strong;
import com.greensock.loading.ImageLoader;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.XMLLoader;
import com.greensock.plugins.ThrowPropsPlugin;
import com.greensock.plugins.TintPlugin;
import com.greensock.plugins.TweenPlugin;
import com.omniture.AppMeasurement;

import commandCenter.Omniture.Tracking;

import flash.display.DisplayObject;

import flash.display.MovieClip;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.ime.IIMEClient;
import flash.utils.Dictionary;
import flash.utils.getTimer;

import flexunit.framework.ProtectedFinishTestCase;

import commandCenter.heroImages.HeroImage;

import commandCenter.loading.CCParser;

import commandCenter.uiFactoryPattern.CreateDescriptionText;
import commandCenter.uiFactoryPattern.CreateNAVText;
import commandCenter.uiFactoryPattern.CreateSUBNAV;

import utils.object.numProperties;

[SWF(width="965", height="500", backgroundColor="0x000000")]
public class Main_1115_CommandCenter extends DocumentClass {

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

    private var _data:Object;

    private var parser:CCParser;
    private var queue:LoaderMax;

    private var _maxItemNav:Number = 15;
    private var _fadedOpacity:Number = .2;

    private var ui:imageUI;
    private var tabUI:tabNav;
    private var subNavArray:Array;
    private var subNavLength:int;
    private var titleTxtArray:Array;
    private var heroImagesArray:Array;
    private var _imgDictionary:Dictionary;

    public static var s:AppMeasurement;
    public static var site:String 					= "AlienWare-1115";  //product name, this is used in tracking, so it is important.


    public function Main_1115_CommandCenter() {

    }

    override protected function init():void {
        super.init();

        graphics.beginFill(0x000000, 1);
        graphics.drawRect(0, 0, 965, 500);
        graphics.endFill();

        LoaderMax.activate([ImageLoader]);
        PathManager.init(getLoaderInfo(this));
        initTracking();
        MonsterDebugger.initialize(this);
        TweenPlugin.activate([ThrowPropsPlugin, TintPlugin]);

        // debug
        trace("country: " + PathManager.country);
        trace("language: " + PathManager.language);

        subNavArray = new Array();
        titleTxtArray = new Array();
        _imgDictionary = new Dictionary();
        heroImagesArray = new Array();

        loadXML();
    }

    public static function initTracking():void
    {

        s = new AppMeasurement();

        commandCenter.Omniture.Tracking.configActionSource();

        var tEvt:TrackEvent = new TrackEvent("CommandCenter","Loading", "subModule");
        commandCenter.Omniture.Tracking.trackMetrics(tEvt);
    }

    private function loadXML():void {
        parser = new CCParser({onComplete: buildUI});

        queue = new LoaderMax({name: "imageQueue", onComplete: parser.parseData, requireWithRoot: this.root});
        queue.append(new XMLLoader(PathManager.getConfigXML('commandCenter-config'), {name: "commandCenterConfig"}));
        queue.append(new XMLLoader(PathManager.getLocalizedXML(), {name: "commandCenterCopy"}));
        queue.load();
    }

    private var _totalListLength:Number;

    private function buildUI(data:Object):void {
        _data = data;

        //******************************************************************
        //******************************************************************
        //******************************************************************
        //IMAGE NAV

        ui = new imageUI()
        ui.x = 143;
        ui.y = 38;
        ui.container.fpo.alpha = 0;
//        ui.container.x -= 50;
        ui.bounds.alpha = 0;
        addChild(ui);

        ui.arrowLeft.hitBox.addEventListener(MouseEvent.MOUSE_DOWN, moveLeft, false, 0, true);
        ui.arrowRight.hitBox.addEventListener(MouseEvent.MOUSE_DOWN, moveRight, false, 0, true);
        addHandCurserNoChildren(ui.arrowLeft.hitBox);
        addHandCurserNoChildren(ui.arrowRight.hitBox);
        ui.arrowLeft.useHandCursor = false;
        ui.arrowLeft.ON.alpha = 0;

        //******************************************************************
        //******************************************************************
        //******************************************************************
        //TABS

        tabUI = new tabNav();
        tabUI.x = 144;
        tabUI.y = 345;


        tabUI.tab1.ON.alpha = 1;
        tabUI.tab2.ON.alpha = 0;
        tabUI.tab3.ON.alpha = 0;
        tabUI.tab4.ON.alpha = 0;
        tabUI.tab5.ON.alpha = 0;
        tabUI.tab6.ON.alpha = 0;
        addChild(tabUI);

        //******************************************************************
        //******************************************************************
        //******************************************************************
        //NAV TITLES

        var titleXPos:Number = 147;
        var titleYPos:Number = 457;
        var titleStagger:Number = 134;
        for (var n:int = 1; n < 7; n++) {
            var ntParams:Object = {};
            ntParams.xmlNode = _data.tabs["tab" + n].xmlNode;
            ntParams.name = "tabTitle" + n;
            ntParams.tabTarget = "tab" + n;
            ntParams.callBack = onTabMouseHandle;

            if (n == 1) {
                ntParams.isActive = true;
            }

            var nt:CreateNAVText = new CreateNAVText(ntParams);
            nt.x = titleXPos;
            nt.y = titleYPos;
            addChild(nt);
            titleXPos += titleStagger;
        }

        //******************************************************************
        //******************************************************************
        //******************************************************************
        //IMAGES AND TEXTFIELDS

        _totalListLength = numProperties(_data.images) + 1;
        _data.totalLength = _totalListLength - 1;
        var xPos:Number = 0;
        _data.stagger = 542;

        for (var i:int = 1; i < _totalListLength; i++) {

            var tfParams:Object = {};
            tfParams.xmlNode = _data.images["image" + i].xmlNode;
            tfParams.name = "tabDescription" + i;

            var tf:CreateDescriptionText = new CreateDescriptionText(tfParams);

            tf.x = 164;
            tf.y = 370;
            addChild(tf);

            var heroParams:Object = {};
            heroParams.url = _data.images["image" + i].med;
            heroParams.name = _data.images["image" + i].name;
            heroParams.medloaderName = _data.images["image" + i].medloaderName;
            heroParams.textFieldSprite = tf;
            heroParams.callBack = imageCallBack;
            heroParams.tabName = "tab" + _data.images["image" + i].tabItem;
            heroParams.subNavName = "subNav" + _data.images["image" + i].tabItem;
            heroParams.tabTitle = "tabTitle" + _data.images["image" + i].tabItem;
            heroParams.targetName = _data.images["image" + i].targetName;
            heroParams.num = i;
            heroParams.imageNum = "image" + i;
            var hero:HeroImage = new HeroImage(heroParams);
            hero.x = xPos;
            hero.y = 0;
            hero.alpha = (i == 1) ? 1 : _fadedOpacity;
            ui.container.addChild(hero);
            heroImagesArray.push(hero);
//            trace(_data.images["image" + i].name);
            _imgDictionary[heroParams.name] = xPos;
            _data.images["image" + i].xPos = xPos;

            addItemEventHandlers(hero);
            xPos += _data.stagger;

        }

        //******************************************************************
        //******************************************************************
        //******************************************************************
        //SUB NAV DOTS UNDER IMAGES

//        traceProps( numProperties( _data.tabs["tab5"].subNav ) );

        var tLen:int = numProperties(_data.tabs);


        for (var t:int = 1; t < tLen + 1; t++) {
            _data.tabs["tab" + t].callBack = seekImage;

            var sn:CreateSUBNAV = new CreateSUBNAV(_data.tabs["tab" + t], subNavArray);
            sn.x = 545;
            sn.y = 349;
            addChild(sn);
            if (t != 1) {
                sn.alpha = 0;
                sn.visible = false;
            }
        }

        subNavLength = subNavArray.length;

        for (var snA:int = 0; snA < subNavLength; snA++) {
            subNavArray[snA].name = "target" + (snA + 1);
            if (snA == 0) {
                subNavArray[snA].activate(true);
            } else {
                subNavArray[snA].deactivate();
            }
        }

        activeTextTile = "tabTitle1";
        _leftVisibleItemNumber = 1;
        newTargetName = clickedItemName = "heroImages1";
        buildThrowProps();
    }

    private var activeTextTile:String;
    private var dataCache:Object = {};

    private function onTabMouseHandle(_name:String, _action:String, _textTitle:String, _isActive:Boolean):void {

//        trace(_action);
//        trace(_textTile);
//        trace(_isActive);
        dataCache.name = _name;
        dataCache.action = _action;
        dataCache.textTitle = _textTitle;
        dataCache.isActive = _isActive;


        if (activeTextTile != _textTitle) {
            if (_action == "mouseOver") {
                TweenLite.to(tabUI[_name]["ON"], GlobalAnim.TRANSISITION, {alpha: 1});
                (getTabTile(_textTitle) as CreateNAVText).isActive = true;
            }

            if (_action == "mouseOut") {
                TweenLite.to(tabUI[_name]["ON"], GlobalAnim.TRANSISITION, {alpha: 0});
                (getTabTile(_textTitle) as CreateNAVText).isActive = false;
            }
        }

        if (_action == "mouseDown") {
            activeTextTile = _textTitle;
            onTabSeek(_name);
            TweenLite.to(tabUI[_name]["ON"], GlobalAnim.TRANSISITION, {alpha: 1});
            (getTabTile(_textTitle) as CreateNAVText).isActive = true;
        }

        for (var i:int = 1; i < 7; i++) {
            if (("tabTitle" + i) != activeTextTile && ("tabTitle" + i) != _textTitle) {
                TweenLite.to(tabUI["tab" + i]["ON"], GlobalAnim.TRANSISITION, {alpha: 0});
                (getTabTile("tabTitle" + i) as CreateNAVText).isActive = false;
//                TweenMax.to(getSubNav("subNav" + i), GlobalAnim.TRANSISITION, {autoAlpha:0});
            }
        }
    }

    private function onTabSeek(_name:String):void {

        if (_name == "tab1") {
            seekImage("heroImages1");
        } else if (_name == "tab2") {
            seekImage("heroImages2");
        } else if (_name == "tab3") {
            seekImage("heroImages5");
        } else if (_name == "tab4") {
            seekImage("heroImages8");
        } else if (_name == "tab5") {
            seekImage("heroImages10");
        } else if (_name == "tab6") {
            seekImage("heroImages13");
        }
    }

    private function reset():void {
        var hLen:int = heroImagesArray.length;
        for (var h:int = 0; h < hLen; h++) {
            heroImagesArray[h].stopEnterFrame();
        }

        for (var i:int = 0; i < hLen; i++) {
            heroImagesArray[i].stopEnterFrame();
        }
    }


//    private var isSeeking:Boolean = false;
    private function seekImage(imageName:String):void {
//        isSeeking = true;
//        trace(imageName);
//        trace(_imgDictionary[imageName]);

        var hLen:int = heroImagesArray.length;
        for (var h:int = 0; h < hLen; h++) {
            heroImagesArray[h].stopEnterFrame();
        }
        var nextXPos:Number = -(_imgDictionary[imageName]) + containerInitPos;
        TweenLite.to(ui.container, GlobalAnim.TRANSISITION * 2, {x: nextXPos, onComplete: onSeekComplete});

    }

    public function onSeekComplete():void {
        var hLen:int = heroImagesArray.length;
        for (var h:int = 0; h < hLen; h++) {
            heroImagesArray[h].startEnterFrame();
        }
//        onTabMouseHandle(dataCache.name, "mouseOut", dataCache.textTitle, dataCache.isActive);
        setXPosOfLeftItem();
        updateImageNav("null");
    }


    /**
     * Called from each image
     * @param data
     */
    private function imageCallBack(data:Object):void {
//        trace(data.name); //<- image name
//        trace(data.targetName);
        if (directionX == 1) {
            updateImageNav("right");
        } else {
            updateImageNav("left");
        }

//        traceProps(data);
        activeTarget = data.targetName;
        _leftVisibleItemNumber = data.imageNum;

        for (var i:int = 0; i < subNavLength; i++) {
//            trace("target: " + data.targetName + ", array: " + subNavArray[i].name);
            if (subNavArray[i].name == data.targetName) {
                subNavArray[i].activate();
            } else {
                subNavArray[i].deactivate();
            }
        }

        toggleTabs(data);

    }

    private var activeTab:String;
    private var activeSubNav:String;
    private var activeTitle:String;
    private var _tabNumber:int = 7;
    private var activeTarget:String;

    /**
     * Called from each image.
     * @param data
     */
    private function toggleTabs(data:Object):void {


        activeTab = data.tabName;
        activeTitle = data.tabTitle;
        activeSubNav = data.subNavName;
//        trace(activeSubNav);

        TweenLite.to(tabUI[activeTab].ON, GlobalAnim.TRANSISITION, {delay: GlobalAnim.TRANSISITION, alpha: 1});

        var aTF:TextField = (getTabTile(data.tabTitle) as CreateNAVText).getTitleField();

        TweenLite.to(aTF, GlobalAnim.TRANSISITION, {delay: GlobalAnim.TRANSISITION, tint: 0xFFFFFF});
        TweenMax.to(getSubNav(data.subNavName), GlobalAnim.TRANSISITION, {delay: GlobalAnim.TRANSISITION, autoAlpha: 1});

        for (var i:int = 1; i < _tabNumber; i++) {
            if (activeTab != ("tab" + i)) {

                TweenLite.to(tabUI["tab" + i].ON, GlobalAnim.TRANSISITION, {alpha: 0});

                var dtf:TextField = (getTabTile("tabTitle" + i) as CreateNAVText).getTitleField();
                TweenLite.to(dtf, GlobalAnim.TRANSISITION, {tint: SwatchAFX.CC_NAV_OFF});

                TweenMax.to(getSubNav("subNav" + i), GlobalAnim.TRANSISITION, {autoAlpha: 0});
            }
        }

    }

    //**************************************************************************************************
    //**************************************************************************************************
    //**************************************************************************************************
    //Add Event Handlers

    private function addItemEventHandlers(img:DisplayObject):void {
        img.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
        addHandCurserNoChildren(img);
    }

    private function clickHandler():void {
        var tEvt1:TrackEvent = new TrackEvent('button','CommandCenter-Thumbnail-' + newTargetName);
        commandCenter.Omniture.Tracking.trackMetrics(tEvt1);

        if (newTargetName != clickedItemName) {
            TweenMax.killAll(true);
            clickedItemName = newTargetName;
            var strLen:int = String("heroImages").length;
            var num:Number = Number(clickedItemName.substring(strLen, clickedItemName.length));
            var clickedImage:Sprite = (ui.container.getChildByName(clickedItemName) as Sprite);

        }
    }

    private function getTabTile(name:String):Sprite {
        return (this.getChildByName(name) as Sprite);
    }

    private function getImage(num:Number):Sprite {
        return (ui.container.getChildByName("heroImages" + num) as Sprite);
    }

    private function getSubNav(name:String):Sprite {
        return (this.getChildByName(name) as Sprite);
    }

    private function fadeOn(clickedImage:Sprite):void {
        TweenLite.to(clickedImage, GlobalAnim.TRANSISITION, {delay: GlobalAnim.TRANSISITION, alpha: 1});
    }

    private function fadeOff(num:Number):void {
        for (var i:int = 1; i < _totalListLength; i++) {
            var otherImage:Sprite = (ui.container.getChildByName("heroImages" + i) as Sprite);

            if (i != num) {
                TweenLite.to(otherImage, GlobalAnim.TRANSISITION, {alpha: _fadedOpacity});
            }

        }
    }


    //**************************************************************************************************
    //**************************************************************************************************
    //**************************************************************************************************
    //Horizonal Nav

    private function moveRight(event:MouseEvent = null):void {

        var tEvt1:TrackEvent = new TrackEvent('button','CommandCenter-RightNavButton');
        commandCenter.Omniture.Tracking.trackMetrics(tEvt1);

//        if (isMoving) {
        TweenLite.killTweensOf(ui.container);
        isMoving = false;
        setXPosOfLeftItem();
//        }


        if (_leftVisibleItemNumber < _maxItemNav) {
            var nextXPos:Number = -(_data.images["image" + (_leftVisibleItemNumber + 1)].xPos) + containerInitPos;
            TweenLite.to(ui.container, GlobalAnim.TRANSISITION, {x: nextXPos});
            _leftVisibleItemNumber += 1;
            fadeOn(getImage(_leftVisibleItemNumber));
            fadeOff(_leftVisibleItemNumber);
        }

        updateImageNav("right");
    }

    private function moveLeft(event:MouseEvent = null):void {

        var tEvt1:TrackEvent = new TrackEvent('button','CommandCenter-LeftNavButton');
        commandCenter.Omniture.Tracking.trackMetrics(tEvt1);

        TweenLite.killTweensOf(ui.container);
        isMoving = false;
        setXPosOfLeftItem();



        if (_leftVisibleItemNumber > 1) {
            var nextXPos:Number = -(_data.images["image" + (_leftVisibleItemNumber - 1)].xPos) + containerInitPos;
            TweenLite.to(ui.container, GlobalAnim.TRANSISITION, {x: nextXPos});
            _leftVisibleItemNumber -= 1;
            fadeOn(getImage(_leftVisibleItemNumber));
            fadeOff(_leftVisibleItemNumber);
        }

        updateImageNav("left");
    }

    private function updateImageNav(direction:String):void {

        isCatched = false;
//        setXPosOfLeftItem();
//        blitMask.disableBitmapMode();

        if (_leftVisibleItemNumber == _maxItemNav) {
            TweenLite.to(ui.arrowRight.ON, GlobalAnim.TRANSISITION, {alpha: 0});
            TweenLite.to(ui.arrowRight.OFF, GlobalAnim.TRANSISITION, {alpha: 1}); //Right arrow off
            ui.arrowRight.useHandCursor = false;
        } else {
            TweenLite.to(ui.arrowRight.ON, GlobalAnim.TRANSISITION, {alpha: 1});
            TweenLite.to(ui.arrowRight.OFF, GlobalAnim.TRANSISITION, {alpha: 0});
            ui.arrowRight.useHandCursor = true;
        }

        if (_leftVisibleItemNumber == 1) {
            TweenLite.to(ui.arrowLeft.ON, GlobalAnim.TRANSISITION, {alpha: 0});
            TweenLite.to(ui.arrowLeft.OFF, GlobalAnim.TRANSISITION, {alpha: 1});
            ui.arrowLeft.useHandCursor = false;
        } else {
            TweenLite.to(ui.arrowLeft.ON, GlobalAnim.TRANSISITION, {alpha: 1});
            TweenLite.to(ui.arrowLeft.OFF, GlobalAnim.TRANSISITION, {alpha: 0});
            ui.arrowLeft.useHandCursor = true;
        }


    }


    /**
     * Item click goes to a different event handler to capture it's name.
     *
     * As apposed to the "mouseDownHandler" method, which also tracks the blitMask that is clicked.
     */
    private function itemClickHandler(event:MouseEvent):void {
        newTargetName = event.target.name;
    }

    //**************************************************************************************************
    //**************************************************************************************************
    //**************************************************************************************************
    //Horizontal Throw Props scroll

//    private var blitMask:BlitMask;
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
    }

    private function mouseDownHandler(event:MouseEvent):void {
        newTargetName = event.target.name;

        TweenLite.killTweensOf(ui.container);
//        blitMask.disableBitmapMode();
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

        var x:Number = ui.container.mouseX - xOffset;
        //if mc's position exceeds the ui.bounds, make it drag only half as far with each mouse movement (like iPhone/iPad behavior)

        if (x > ui.bounds.x) { // <- container is within bounds
            ui.container.x = (x + ui.bounds.x) * 0.5;
        } else if (x < ui.bounds.x - xOverlap) { //<container is outside of bounds on the left side
            ui.container.x = (x + ui.bounds.x - xOverlap) * 0.5;
        } else {
            ui.container.x = x;
        }

//        blitMask.update(null, true);
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
            isMoving = false;
        } else {
            var tEvt:TrackEvent = new TrackEvent("CommandCenter","throwNav");
            commandCenter.Omniture.Tracking.trackMetrics(tEvt);

            directionX = getDirection(mouseXMoveOffset);
            directionY = getDirection(mouseYMoveOffset);
            isMoving = true;
        }


        ui.container.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
        ui.container.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);

        var time:Number = (getTimer() - t2) / 1000;
        var xVelocity:Number = ( ui.container.x - x2 ) / time;
        ThrowPropsPlugin.to(ui.container, {throwProps: { x: {velocity: xVelocity, max: (ui.bounds.x), min: (ui.bounds.x) - xOverlap, resistance: 300}
        }, onComplete: throwComplete, ease: Strong.easeOut
        }, 10, 0.3, 1);
    }


    private function throwComplete():void {
        setXPosOfLeftItem();
        if (directionX == 1) {
//            trace("right");
            updateImageNav("right");
        } else {
//            trace("left");
            updateImageNav("left");
        }
        var hLen:int = heroImagesArray.length;
        for (var h:int = 0; h < hLen; h++) {
//            heroImagesArray[h].checkIfHeroisInViewPort();
        }

       //checkIfHeroisInViewPort

    }

    private var _leftVisibleItemNumber:Number;

    private function setXPosOfLeftItem():void {
        var containerPos:Number = ui.container.x - (ui.bounds.x + boundsXAdjust);
        for (var i:int = 1; i < _data.totalLength + 1; i++) {
            if (-(_data.images["image" + i].xPos) > containerPos) {
                if (-( _data.images["image" + i].xPos + _data.stagger ) < containerPos) {

                    _leftVisibleItemNumber = i;
                    break;
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
