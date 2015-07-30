package com.ooyala.api {
/**
 * Important Note:
 *   If you are embedding the Ooyala Player from within a swf loaded in your main swf (i.e. in a different
 *   ApplicationDomain), you will need to add the following code to your main swf to ensure that
 *   Flash's Proxy class is available to our player. See the following Adobe bug for more information about
 *   why this is necessary: http://bugs.adobe.com/jira/browse/FP-939
 *
 * Code to add:
 *   var proxy:Proxy = new Proxy();
 */

import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.display.Sprite;
import flash.errors.IllegalOperationError;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.display.StageDisplayState;
import flash.events.UncaughtErrorEvent;
import flash.geom.Point;
import flash.net.URLRequest;
import flash.net.URLVariables;
import flash.system.Security;
import flash.utils.Proxy;

[Event(name="loadComplete", type="flash.events.Event")]
[Event(name="apiReady", type="flash.events.Event")]
[Event(name="playComplete", type="flash.events.Event")]
[Event(name="embedCodeChanged")]
[Event(name="totalTimeChanged")]
[Event(name="playheadTimeChanged")]
[Event(name="volumeChanged")]
[Event(name="targetBitrateQualityChanged")]
[Event(name="targetBitrateChanged")]
[Event(name="stateChanged")]
[Event(name="currentItemEmbedCodeChanged")]
[Event(name="attemptFullScreenChange")]
[Event(name="fullscreenChanged")]
[Event(name="activePanelChanged")]
[Event(name="ivUserClicked")]
[Event(name="ivObjectDescriptionReady")]
[Event(name="ivSearchResultsReady")]
[Event(name="ivNewObjectPresent")]
[Event(name="adStarted")]
[Event(name="adCompleted")]
[Event(name="adError")]
[Event(name="adClicked")]
[Event(name="closedCaptionsTextReady")]
[Event(name="relatedMediaReady")]
[Event(name="metadataReady")]
[Event(name="ratingsApiReady")]
[Event(name="companionAdsReady")]
[Event(name="seeked")]
public class FlashPlayer extends Sprite {
    public var playerUrlBase:String = "http://player.ooyala.com/player.swf?version=2&embedType=flashplayer.as"

    private var _ooyalaPlayerLoader:Loader;

    private var _loaded:Boolean = false;
    private const _savedDimensions:Point = new Point();
    private var _resizing:Boolean = false;
    private var _eventDispatcher:EventDispatcher;
    private var _loadRequested:Boolean = false;
    private var _savedParameters:Object;
    private var _originalEmbedCode:String;

    private var _totalTime:Number;
    private var _playheadTime:Number;
    private var _volume:Number;
    private var _targetBitrateQuality:String;
    private var _targetBitrate:Number = -1;
    private var _state:String;

    private var _errorCode:Number;
    private var _errorText:String;
    private var _activePanel:String = '';
    private var _cvobj:Object;
    private var _cvSearchObj:Object;

    private var _javaScriptStub:JavaScriptStub;

    public function FlashPlayer() {
        super();
        _eventDispatcher = this;
        this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

        // See the comment up top.
        var proxy:Proxy = new Proxy();
    }

    private function onAddedToStage(event:Boolean):void {
        if (_loadRequested) {
            _loadRequested = false;//force load, we just added to stage...
            load();
        }
        initiateResize();
    }

    public function get loaded():Boolean {
        return _loaded;
    }

    public function set javaScriptCallback(value:String):void {
        setJavaScriptCallback0(value);
    }

    public function setJavaScriptCallback(callback:String, priority:int = -1):void {
        setJavaScriptCallback0(callback, priority);
    }

    internal function setJavaScriptCallback0(callback:String, priority:int = -1, callLaterFunction:Function = null):void {
        if (_javaScriptStub) {
            throw new IllegalOperationError("JavaScript callback may be set only once");
        }
        _javaScriptStub = new JavaScriptStub(callback, this, _eventDispatcher, priority, callLaterFunction);
    }

    /**
     * Internal property to avoid event bubbling and dispatch events directly on target.
     */
    internal function set eventDispatcher(value:EventDispatcher):void {
        this._eventDispatcher = value;
    }

    public function load():void {
        if (_loadRequested) {
            return;
        }
        _loadRequested = true;
        if (this.stage == null) {
            return;
        }
        // one more check to prevent bad things:
        if (_ooyalaPlayerLoader) {
            // load been requested already, no more load
            return;
        }
        _ooyalaPlayerLoader = new Loader();
        this.addChild(_ooyalaPlayerLoader);
        _ooyalaPlayerLoader.visible = false;
        _ooyalaPlayerLoader.contentLoaderInfo.addEventListener(Event.INIT, onOoyalaPlayerInit);

        /*
         * Please send request to http://www.ooyala.com/player.swf
         * and server will redirect you to most recent version of player.
         */
        _ooyalaPlayerLoader.x = 0;
        _ooyalaPlayerLoader.y = 0;
        _ooyalaPlayerLoader.scaleX = 1;
        _ooyalaPlayerLoader.scaleY = 1;

        var playerUrl:String = playerUrlBase + "&";
        if (this._savedParameters) {
            var queryString:Array = [];
            for (var param:String in this._savedParameters) {
                queryString.push(encodeURIComponent(param) + "=" + encodeURIComponent(this._savedParameters[param]));
            }
            playerUrl += queryString.join("&");
            this._originalEmbedCode = this._savedParameters["embedCode"];
            this._savedParameters = null;
        }
        _ooyalaPlayerLoader.load(new URLRequest(playerUrl));

        _ooyalaPlayerLoader.contentLoaderInfo.addEventListener(Event.INIT, function (event:Event):void {
            const url:String = _ooyalaPlayerLoader.contentLoaderInfo.url;
            const host:String = getServerName(url);
            /*
             * The actual player may come from multiple domains (CDN load-balancing)
             * so we need to trust that "final" location.
             * We do not need the permissions to access external code,
             * but Flex does want to access Stage... It's in too many places
             * to safely clean out this access...
             */
//        trace("Actual location",url, "host=", host);
            Security.allowDomain(host);
            Security.allowInsecureDomain(host);
        });
    }

    private function onOoyalaPlayerInit(event:Event):void {
        /*
         * Here is the earliest place where we can access shared events.
         *
         * Player will dispatch "applicationComplete" event when it's ready
         */
        const sharedEvents:EventDispatcher = _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents;
        sharedEvents.addEventListener("applicationComplete", onOoyalaPlayerComplete);
        sharedEvents.addEventListener("embedCodeChanged", onEmbedCodeChanged);
        sharedEvents.addEventListener("totalTimeChanged", onTotalTimeChanged);
        sharedEvents.addEventListener("playheadTimeChanged", onPlayheadTimeChanged);
        sharedEvents.addEventListener("volumeChanged", onVolumeChanged);
        sharedEvents.addEventListener("stateChanged", onStateChanged);
        sharedEvents.addEventListener("currentItemEmbedCodeChanged", onCurrentItemEmbedCodeChanged);
        sharedEvents.addEventListener("playComplete", onPlayingFinished);
        sharedEvents.addEventListener("attemptFullScreenChange", onAttemptFullScreenChange);
        sharedEvents.addEventListener("fullscreenChanged", onFullScreenToggled);
        sharedEvents.addEventListener("activePanelChanged", onActivePanelChanged);
        sharedEvents.addEventListener("ivUserClicked", onCvUserClicked);
        sharedEvents.addEventListener("ivObjectDescriptionReady", onObjectDescriptionReady);
        sharedEvents.addEventListener("ivSearchResultsReady", onCvSearchResultReady);
        sharedEvents.addEventListener("ivNewObjectPresent", onIvNewObjectPresent);
        sharedEvents.addEventListener("apiReady", onApiReady);
        sharedEvents.addEventListener("adStarted", onAdEvent);
        sharedEvents.addEventListener("adClicked", onAdEvent);
        sharedEvents.addEventListener("adCompleted", onAdEvent);
        sharedEvents.addEventListener("adError", onAdEvent);
        sharedEvents.addEventListener("closedCaptionsTextReady", onClosedCaptionsTextReady);
        sharedEvents.addEventListener("relatedMediaReady", onRelatedMediaReady);
        sharedEvents.addEventListener("metadataReady", onMetadataReady);
        sharedEvents.addEventListener("ratingsApiReady", onRatingApiReady);
        sharedEvents.addEventListener("companionAdsReady", onAdEvent);
        sharedEvents.addEventListener("targetBitrateQualityChanged", onTargetBitrateQualityChanged);
        sharedEvents.addEventListener("targetBitrateChanged", onTargetBitrateChanged);
        sharedEvents.addEventListener("seeked", onSeeked);
    }

    private function resize(event:Event = null):void {
        _resizing = false;
        this.removeEventListener(Event.ENTER_FRAME, resize);
        const e:DynamicEvent = new DynamicEvent("resize");
        e.width = this.width;
        e.height = this.height;
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(e);
    }

    private function initiateResize():void {
        if (!_loaded || _resizing) {
            return;
        }
        _resizing = true;
        this.addEventListener(Event.ENTER_FRAME, resize);
    }

    override public function set width(value:Number):void {
        this._savedDimensions.x = value;
        initiateResize();
    }

    override public function set height(value:Number):void {
        this._savedDimensions.y = value;
        initiateResize();
    }

    override public function get width():Number {
        return _savedDimensions.x;
    }

    override public function get height():Number {
        return _savedDimensions.y;
    }

    private function onOoyalaPlayerComplete(event:Event):void {
        _loaded = true;
        /*
         * Player is ready to be scripted out
         */
        /*
         * You can position player by direct assigning .x and .y properties
         */
        _ooyalaPlayerLoader.x = 0;
        _ooyalaPlayerLoader.y = 0;
        /*
         * Unfortunatelly direct assigning width/height doesn't work (Flash just scales nested SWF)
         * So, you need to tell player to resize itself:
         */
        initiateResize();
        /*
         * We can make it visible now.
         * Please note, that you can make it visible right when you created it
         * but it will draw preloader on top of your content and will take 100%/100% size until you
         * resize it, so create it invisible and show when it's ready and has right size
         */
        _ooyalaPlayerLoader.visible = true;

        if (_savedParameters) {
            this.queryStringParameters = _savedParameters;
        }

        _eventDispatcher.dispatchEvent(new Event("loadComplete"));

    }

    public function set queryStringParameters(parameters:*):void {
        if (parameters is String) {
            parameters = new URLVariables(parameters as String);
        }

        if (!_loaded) {
            this._savedParameters = parameters;
            return;
        }
        else {
            _savedParameters = null;
        }

        const e2:DynamicEvent = new DynamicEvent("parameters");
        e2.parameters = parameters;
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(e2);
    }

    [Bindable(event="embedCodeChanged")]
    public function get item():ContentItemDescription {
        const event:DynamicEvent = new DynamicEvent("getItem");
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(event);
        // Historically this API has always returned a non-null item, so we're preserving that behavior here.
        return event.result ? ContentItemDescription.copyFrom(event.result) : new ContentItemDescription();
    }

    [Bindable(event="embedCodeChanged")]
    public function get title():String {
        return this.item.title;
    }

    [Bindable(event="embedCodeChanged")]
    public function get lineup():Array {
        return this.item.lineup;
    }

    [Bindable(event="embedCodeChanged")]
    public function get description():String {
        return this.item.description;
    }

    [Bindable(event="embedCodeChanged")]
    public function get embedCode():String {
        if (this.item.embedCode) {
            return this.item.embedCode;
        }
        return _originalEmbedCode;
    }

    public function set embedCode(value:String):void {
        /*
         * Time to tell what to play:
         */
        const params:Object = new Object();
        /*
         * Take actual embed code from snippet, for example for the snippet:
         * <script src="http://www.ooyala.com/player.js?width=480&height=360&embedCode=8wNTqa-6MkpEB1c7fNGOpoSJytLptmm9"></script><noscript><table width="480" height="360" style="background-color:black;color:white"><tr><td align="center">You need to have JavaScript enabled to see this content.</td></tr></table></noscript>
         * embedCode would be 8wNTqa-6MkpEB1c7fNGOpoSJytLptmm9
         */
        params['embedCode'] = value;//'FiYzE6osOtiz31b6V2gdPZezTMSf4C9Z';
        this.queryStringParameters = params;
    }

    private function onEmbedCodeChanged(event:Event):void {
        _eventDispatcher.dispatchEvent(new Event("embedCodeChanged"));
    }

    public function playMovie():void {
        if (!_loaded) {
            return;
        }
        const e:Event = new Event("playMovie");
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(e);
    }

    public function pauseMovie():void {
        if (!_loaded) {
            return;
        }
        const e:Event = new Event("pauseMovie");
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(e);
    }

    public function playSynchronized(time:Number):void {
        if (!_loaded) {
            return;
        }
        const e:DynamicEvent = new DynamicEvent("playSynchronized");
        e.time = time;
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(e);
    }

    public function ivStartSearch(terms:String, params:Object = null):void {
        if (!_loaded) {
            return;
        }
        const e:DynamicEvent = new DynamicEvent("ivStartSearch");
        e.searchTerms = terms;
        e.searchParams = params;
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(e);
    }

    public function ivGetDescription(trackid:String):void {
        if (!_loaded) {
            return;
        }
        const e:DynamicEvent = new DynamicEvent("ivGetDescription");
        e.trackid = trackid;
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(e);
    }

    public function showChannel():void {
        if (!_loaded) {
            return;
        }
        const e:Event = new Event("showChannel");
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(e);
    }

    public function changeCurrentItem(embedCode:String):Boolean {
        if (!_loaded) {
            return false;
        }
        const e:DynamicEvent = new DynamicEvent("changeCurrentItem");
        e.embedCode = embedCode;
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(e);
        return Boolean(e.result);
    }

    public function getPromoFor(embedCode:String, width:uint, height:uint):String {
        if (!_loaded) {
            return null;
        }
        const e:DynamicEvent = new DynamicEvent("getPromoFor");
        e.embedCode = embedCode;
        e.width = width;
        e.height = height;
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(e);
        return e.result;
    }

    public function set currentItemEmbedCode(value:String):void {
        changeCurrentItem(value);
    }

    [Bindable(event="totalTimeChanged")]
    public function get totalTime():Number {
        if (!_loaded) {
            return NaN;
        }
        return _totalTime;
    }

    private function onTotalTimeChanged(event:Event):void {
        const o:Object = Object(event);
        const value:Number = o.totalTime;
        if (value == _totalTime) {
            return;
        }
        _totalTime = value;
        _eventDispatcher.dispatchEvent(new Event("totalTimeChanged"));
    }

    [Bindable(event="playheadTimeChanged")]
    public function get playheadTime():Number {
        if (isNaN(_playheadTime)) {
            var event:DynamicEvent = new DynamicEvent("getPlayheadTime");
            _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(event);
            // The v1 player does not support the getPlayheadTime query; in v1, we depend on getting an initial
            // playheadUpdate event to initialize the _playheadTime.
            if (event.result != null) {
                _playheadTime = event.result as Number;
            }
        }

        return _playheadTime;
    }

    public function set playheadTime(value:Number):void {
        const e:DynamicEvent = new DynamicEvent("seek");
        e.playheadTime = value;
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(e);
    }

    private function onPlayheadTimeChanged(event:Event):void {
        const o:Object = Object(event);
        const value:Number = o.playheadTime;
        if (value == _playheadTime) {
            return;
        }
        _playheadTime = value;
        _eventDispatcher.dispatchEvent(new Event("playheadTimeChanged"));
    }

    [Bindable(event="volumeChanged")]
    public function get volume():Number {
        if (isNaN(_volume)) {
            var event:DynamicEvent = new DynamicEvent("getVolume");
            _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(event);
            // The v1 player does not support the getVolume query; in v1, we depend on getting an initial
            // volumeChanged event to initialize _volume.
            if (event.result != null) {
                _volume = event.result as Number;
            }
        }
        return _volume;
    }

    private function onVolumeChanged(event:Event):void {
        const o:Object = Object(event);
        const value:Number = o.volume;

        if (value == _volume) {
            return;
        }
        _volume = value;
        _eventDispatcher.dispatchEvent(new Event("volumeChanged"));
    }

    public function set volume(value:Number):void {
        const e:DynamicEvent = new DynamicEvent("volume");
        e.volume = value;
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(e);
    }

    public function get bufferLength():Number {
        var event:DynamicEvent = new DynamicEvent("getBufferLength");
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(event);
        if (event.result != null) {
            return event.result as Number;
        }
        else {
            return -1;
        }
    }

    [Bindable(event="embedCodeChanged")]
    public function get bitratesAvailable():Array {
        var event:DynamicEvent = new DynamicEvent("getBitratesAvailable");
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(event);
        if (event.result != null) {
            return event.result as Array;
        }
        else {
            return [];
        }
    }

    [Bindable(event="embedCodeChanged")]
    public function get bitrateQualitiesAvailable():Array {
        var event:DynamicEvent = new DynamicEvent("getBitrateQualitiesAvailable");
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(event);
        if (event.result != null) {
            return event.result as Array;
        }
        else {
            return [];
        }
    }

    [Bindable(event="targetBitrateQualityChanged")]
    public function get targetBitrateQuality():String {
        if (!_targetBitrateQuality) {
            var event:DynamicEvent = new DynamicEvent("getTargetBitrateQuality");
            _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(event);
            if (event.result != null) {
                _targetBitrateQuality = event.result as String;
            }
        }

        return _targetBitrateQuality;
    }

    private function onTargetBitrateQualityChanged(event:Event):void {
        const o:Object = Object(event);
        const value:String = o.targetBitrateQuality;

        if (value == _targetBitrateQuality) {
            return;
        }
        _targetBitrateQuality = value;
        _targetBitrate = -1; // reset this value to force refetch the new bitrate
        _eventDispatcher.dispatchEvent(new Event("targetBitrateQualityChanged"));
    }

    public function set targetBitrateQuality(value:String):void {
        const e:DynamicEvent = new DynamicEvent("targetBitrateQuality");
        e.targetBitrateQuality = value;
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(e);
    }

    [Bindable(event="targetBitrateChanged")]
    public function get targetBitrate():Number {
        if (isNaN(_targetBitrate) || _targetBitrate < 0) {
            var event:DynamicEvent = new DynamicEvent("getTargetBitrate");
            _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(event);
            if (event.result != null) {
                _targetBitrate = event.result as Number;
            }
        }
        return _targetBitrate;
    }

    private function onTargetBitrateChanged(event:Event):void {
        const o:Object = Object(event);
        const value:Number = o.targetBitrate;

        if (value == _targetBitrate) {
            return;
        }
        _targetBitrate = value;
        _targetBitrateQuality = null; // reset to force refetch the quality.
        _eventDispatcher.dispatchEvent(new Event("targetBitrateChanged"));
    }

    public function set targetBitrate(value:Number):void {
        const e:DynamicEvent = new DynamicEvent("targetBitrate");
        e.targetBitrate = value;
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(e);
    }

    [Bindable(event="stateChanged")]
    public function get state():String {
        return _state;
    }

    [Bindable(event="stateChanged")]
    public function get errorCode():Number {
        return _errorCode;
    }

    [Bindable(event="stateChanged")]
    public function get errorText():String {
        return _errorText;
    }

    private function onStateChanged(event:Event):void {
        const o:Object = Object(event);
        const value:String = o.state;
        if (value == _state) {
            return;
        }
        _state = value;
        _errorCode = o.errorCode;
        _errorText = o.errorText;
        _eventDispatcher.dispatchEvent(new Event("stateChanged"));
    }

    [Bindable(event="currentItemEmbedCodeChanged")]
    public function get currentItem():ContentItemDescription {
        const event:DynamicEvent = new DynamicEvent("getCurrentItem");
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(event);
        // Historically this API has always returned a non-null item, so we're preserving that behavior here.
        return event.result ? ContentItemDescription.copyFrom(event.result) : new ContentItemDescription();
    }

    [Bindable(event="currentItemEmbedCodeChanged")]
    public function get currentItemEmbedCode():String {
        return this.currentItem.embedCode;
    }

    [Bindable(event="currentItemEmbedCodeChanged")]
    public function get currentItemTitle():String {
        return this.currentItem.title;
    }

    [Bindable(event="currentItemEmbedCodeChanged")]
    public function get currentItemDescription():String {
        return this.currentItem.description;
    }

    private function onCurrentItemEmbedCodeChanged(event:Event):void {
        _eventDispatcher.dispatchEvent(new Event("currentItemEmbedCodeChanged"));
    }

    private function onPlayingFinished(event:Event):void {
        _eventDispatcher.dispatchEvent(new Event("playComplete"));
    }

    private function onAttemptFullScreenChange(event:Event):void {
        _eventDispatcher.dispatchEvent(new Event("attemptFullScreenChange"));
    }

    private function onFullScreenToggled(event:Event):void {
        _eventDispatcher.dispatchEvent(new Event("fullscreenChanged"));
    }

    private function onSeeked(event:Event):void {
        _eventDispatcher.dispatchEvent(new Event("seeked"));
    }

    [Bindable(event="fullscreenChanged")]
    public function get fullscreen():Boolean {
        return stage.displayState == StageDisplayState.FULL_SCREEN;
    }

    private function onActivePanelChanged(event:Event):void {
        const o:Object = Object(event);
        const activePanel:String = o.activePanel;
        if (activePanel == this._activePanel) {
            return;
        }
        _activePanel = activePanel;
        _eventDispatcher.dispatchEvent(new Event("activePanelChanged"));
    }

    [Bindable("activePanelChanged")]
    public function get activePanel():String {
        return _activePanel;
    }

    private function onApiReady(event:Event):void {
        _eventDispatcher.dispatchEvent(new Event("apiReady"));
    }

    private function onClosedCaptionsTextReady(event:Event):void {
        var output:DynamicEvent = new DynamicEvent(event.type);
        copy(event, output);
        _eventDispatcher.dispatchEvent(output);
    }

    private function onRelatedMediaReady(event:Event):void {
        var mediaEvent:DynamicEvent = new DynamicEvent(event.type);
        copy(event, mediaEvent);
        _eventDispatcher.dispatchEvent(mediaEvent);
    }

    private function onMetadataReady(event:Event):void {
        var metadataEvent:DynamicEvent = new DynamicEvent(event.type);
        copy(event, metadataEvent);
        _eventDispatcher.dispatchEvent(metadataEvent);
    }

    private function onRatingApiReady(event:Event):void {
        var ratingApiReadyEvent:DynamicEvent = new DynamicEvent(event.type);
        copy(event, ratingApiReadyEvent);
        _eventDispatcher.dispatchEvent(ratingApiReadyEvent);
    }

    private function onAdEvent(event:Event):void {
        // Copy the event so that the source isn't traceable.
        var output:DynamicEvent = new DynamicEvent(event.type);
        copy(event, output);
        _eventDispatcher.dispatchEvent(output);
    }

    public function skipAd():void {
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(new DynamicEvent("skipAd"));
    }

    [Bindable(event="ivUserClicked")]
    public function get ivclickobj():Object {
        return _cvobj;
    }

    private function onCvUserClicked(event:Event):void {
        const o:Object = Object(event);
        const de0:DynamicEvent = new DynamicEvent("ivUserClicked");
        _cvobj = o.trackingobj;
        de0.trackingobj = o.trackingobj;
        _eventDispatcher.dispatchEvent(de0);
    }

    [Bindable(event="ivObjectDescriptionReady")]
    public function get cvdescobj():Object {
        return _cvobj;
    }

    private function onObjectDescriptionReady(event:Event):void {
        const o:Object = Object(event);
        const de:DynamicEvent = new DynamicEvent("ivObjectDescriptionReady");
        _cvobj = o.trackingobj;
        de.trackingobj = o.trackingobj;
        _eventDispatcher.dispatchEvent(de);
    }

    [Bindable(event="ivSearchResultsReady")]
    public function get iv_search_results():Object {
        return _cvSearchObj;
    }

    private function onCvSearchResultReady(event:Event):void {
        const o:Object = Object(event);
        const de0:DynamicEvent = new DynamicEvent("ivSearchResultsReady");
        _cvSearchObj = o.iv_search_results;
        de0.iv_search_results = o.iv_search_results;
        _eventDispatcher.dispatchEvent(de0);

    }

    [Bindable(event="ivNewObjectPresent")]
    public function get ivMostRecentlyAppeared():Object {
        return _cvobj;
    }

    private function onIvNewObjectPresent(event:Event):void {
        _cvobj = Object(event);
        const de:DynamicEvent = new DynamicEvent("ivNewObjectPresent");
        copy(event, de);
        _eventDispatcher.dispatchEvent(de);
    }

    [Bindable(event="currentItemEmbedCodeChanged")]
    public function get getCurrentItemClosedCaptionsLanguages():Object {
        var event:DynamicEvent = new DynamicEvent("getCurrentItemClosedCaptionsLanguages");
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(event);
        return event.result;
    }

    /**
     * @param languageCode ISO-639-1; special handling for Chinese.
     *   zh-hans for Simplified Chinese
     *   zh-hant for Traditional Chinese
     */
    public function set setClosedCaptionsLanguage(languageCode:String):void {
        var event:DynamicEvent = new DynamicEvent("setClosedCaptionsLanguage");
        event.languageCode = languageCode;
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(event);
    }

    public function fetchRelatedMedia(embedCode:String, options:Object = null):void {
        var event:DynamicEvent = new DynamicEvent("fetchRelatedMedia");
        event.embedCode = embedCode;
        event.options = options;
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(event);
    }

    public function fetchMetadata(embedCode:String):void {
        var event:DynamicEvent = new DynamicEvent("fetchMetadata");
        event.embedCode = embedCode;
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(event);
    }

    public function getTimedText(start:Number, end:Number):Object {
        var event:DynamicEvent = new DynamicEvent("getTimedText");
        event.start = start;
        event.end = end;
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(event);
        return event.result ? event.result : event;
    }

    public function get canRateCurrentItem():Boolean {
        var event:DynamicEvent = new DynamicEvent("getCanRateCurrentItem");
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(event);
        return event.result;
    }

    public function get currentItemRatings():Array {
        var event:DynamicEvent = new DynamicEvent("getCurrentItemRatings");
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(event);
        return event.result;
    }

    public function get currentItemAverageRating():int {
        var event:DynamicEvent = new DynamicEvent("getCurrentItemAverageRating");
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(event);
        return event.result;
    }

    public function loadRatingsApi():void {
        var event:DynamicEvent = new DynamicEvent("loadRatingsApi");
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(event);
    }

    public function incrementCurrentItemRating(rating:int):void {
        var event:DynamicEvent = new DynamicEvent("incrementCurrentItemRating");
        event.rating = rating;
        _ooyalaPlayerLoader.contentLoaderInfo.sharedEvents.dispatchEvent(event);
    }

    protected static function copy(fromObj:Object, toObj:Object):void {
        for (var p:String in fromObj) {
            toObj[p] = fromObj[p];
        }
    }

    public static function getServerWithPort(url:String):String {
        if (url == null) {
            return "";
        }
        var start:uint = url.indexOf(":");
        //skip slashes
        if (start < 0) {
            return "";
        }
        for (start++; url.charAt(start) == '/'; start++) {
        }
        //now get tailing slash:
        const end:uint = url.indexOf("/", start);
        if (end < 0) {
            return url.substring(start);
        }
        else {
            return url.substring(start, end);
        }
        return null;
    }

    public static function getServerName(url:String):String {
        const sp:String = getServerWithPort(url);
        const colon:uint = sp.indexOf(":");
        if (colon < 0) {
            return sp;
        }
        else {
            return sp.substring(0, colon);
        }
    }


}//end of class
}

import flash.events.Event;

internal dynamic class DynamicEvent extends Event {
    public function DynamicEvent(type:String) {
        super(type);
    }
}
