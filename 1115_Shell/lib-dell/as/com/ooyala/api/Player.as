

/**
* GENERATED CODE!!!
* do not edit the .as file, which is generated, it will get overwriten at build. Edit the template instead
*/
package com.ooyala.api
{
  import flash.events.Event;

  import mx.core.UIComponent;
  import mx.events.ResizeEvent;

  /**
   * Ooyala Player API for Flex applications.
   */

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
  public class Player extends UIComponent
  {
    // The Flex API is largely a wrapper around the pure-actionscript player API.
    private const _flashPlayer:FlashPlayer = new FlashPlayer();

    public function Player()
    {
      super();
      _flashPlayer.eventDispatcher = this;
      this.addEventListener(ResizeEvent.RESIZE, onResize);
    }
    private function onResize(junk:Event = null):void
    {
      if (_flashPlayer.parent == this)
      {
        _flashPlayer.width = this.width;
        _flashPlayer.height = this.height;
      }
    }

    public function load():void
    {
      this.addChild(_flashPlayer);
      _flashPlayer.load();
      _flashPlayer.width = this.width;
      _flashPlayer.height = this.height;
    }

    public function playMovie():void {  _flashPlayer.playMovie(); }
    public function pauseMovie():void {  _flashPlayer.pauseMovie(); }
    public function playSynchronized(time:Number):void {  _flashPlayer.playSynchronized(time); }
    public function ivStartSearch(terms:String, params:Object = null):void {  _flashPlayer.ivStartSearch(terms, params ); }
    public function ivGetDescription(trackid:String):void {  _flashPlayer.ivGetDescription(trackid); }
    public function showChannel():void {  _flashPlayer.showChannel(); }
    public function changeCurrentItem(embedCode:String):Boolean { return _flashPlayer.changeCurrentItem(embedCode); }
    public function getPromoFor(embedCode:String, width:uint, height:uint):String { return _flashPlayer.getPromoFor(embedCode, width, height); }
    public function skipAd():void {  _flashPlayer.skipAd(); }
    public function fetchRelatedMedia(embedCode:String, options:Object = null):void {  _flashPlayer.fetchRelatedMedia(embedCode, options ); }
    public function fetchMetadata(embedCode:String):void {  _flashPlayer.fetchMetadata(embedCode); }
    public function getTimedText(start:Number, end:Number):Object { return _flashPlayer.getTimedText(start, end); }
    public function loadRatingsApi():void {  _flashPlayer.loadRatingsApi(); }
    public function incrementCurrentItemRating(rating:int):void {  _flashPlayer.incrementCurrentItemRating(rating); }

    public function set queryStringParameters(value:*):void{ _flashPlayer.queryStringParameters=value; }
    public function set embedCode(value:String):void{ _flashPlayer.embedCode=value; }
    public function set currentItemEmbedCode(value:String):void{ _flashPlayer.currentItemEmbedCode=value; }
    public function set playheadTime(value:Number):void{ _flashPlayer.playheadTime=value; }
    public function set volume(value:Number):void{ _flashPlayer.volume=value; }
    public function set targetBitrateQuality(value:String):void{ _flashPlayer.targetBitrateQuality=value; }
    public function set targetBitrate(value:Number):void{ _flashPlayer.targetBitrate=value; }
    public function set setClosedCaptionsLanguage(value:String):void{ _flashPlayer.setClosedCaptionsLanguage=value; }

    public function get loaded():Boolean{ return _flashPlayer.loaded; }
    [Bindable (event="embedCodeChanged")]
    public function get embedCode():String{ return _flashPlayer.embedCode; }
    [Bindable (event="totalTimeChanged")]
    public function get totalTime():Number{ return _flashPlayer.totalTime; }
    [Bindable (event="playheadTimeChanged")]
    public function get playheadTime():Number{ return _flashPlayer.playheadTime; }
    [Bindable (event="volumeChanged")]
    public function get volume():Number{ return _flashPlayer.volume; }
    public function get bufferLength():Number{ return _flashPlayer.bufferLength; }
    [Bindable (event="targetBitrateQualityChanged")]
    public function get targetBitrateQuality():String{ return _flashPlayer.targetBitrateQuality; }
    [Bindable (event="targetBitrateChanged")]
    public function get targetBitrate():Number{ return _flashPlayer.targetBitrate; }
    [Bindable (event="stateChanged")]
    public function get state():String{ return _flashPlayer.state; }
    [Bindable (event="currentItemEmbedCodeChanged")]
    public function get currentItemEmbedCode():String{ return _flashPlayer.currentItemEmbedCode; }
    [Bindable (event="fullscreenChanged")]
    public function get fullscreen():Boolean{ return _flashPlayer.fullscreen; }
    [Bindable (event="activePanelChanged")]
    public function get activePanel():String{ return _flashPlayer.activePanel; }

    public function set javaScriptCallback(value:String):void { setJavaScriptCallback(value); }

    public function setJavaScriptCallback(callback:String, priority:int = -1):void
    {
      _flashPlayer.setJavaScriptCallback0(callback, priority, this.callLater); //Use standard Flex call later
    }

    [Bindable (event="embedCodeChanged")]
    public function get item():ContentItemDescription { return _flashPlayer.item; }

    [Bindable (event="embedCodeChanged")]
    public function get title():String { return _flashPlayer.title; }

    [Bindable (event="embedCodeChanged")]
    public function get description():String { return _flashPlayer.description; }

    [Bindable (event="embedCodeChanged")]
    public function get lineup():Array { return _flashPlayer.lineup; }

    [Bindable (event="stateChanged")]
    public function get errorCode():Number { return _flashPlayer.errorCode; }

    [Bindable (event="stateChanged")]
    public function get errorText():String { return _flashPlayer.errorText; }

    [Bindable (event="currentItemEmbedCodeChanged")]
    public function get currentItem():ContentItemDescription { return _flashPlayer.currentItem; }

    [Bindable (event="currentItemEmbedCodeChanged")]
    public function get currentItemTitle():String { return _flashPlayer.currentItemTitle; }

    [Bindable (event="currentItemEmbedCodeChanged")]
    public function get currentItemDescription():String { return _flashPlayer.currentItemDescription; }

    [Bindable (event="ivUserClicked")]
    public function get ivclickobj():Object { return _flashPlayer.ivclickobj; }

    [Bindable (event="ivNewObjectPresent")]
    public function get ivMostRecentlyAppeared():Object { return _flashPlayer.ivMostRecentlyAppeared; }

    [Bindable (event="ivObjectDescriptionReady")]
    public function get cvdescobj():Object { return _flashPlayer.cvdescobj; }

    [Bindable ("ivSearchResultsReady")]
    public function get iv_search_results():Object { return _flashPlayer.iv_search_results; }

    public function get playerUrlBase():String { return _flashPlayer.playerUrlBase; }

    public function set playerUrlBase(value:String):void { _flashPlayer.playerUrlBase = value; }

    [Bindable (event="currentItemEmbedCodeChanged")]
    public function get canRateCurrentItem():Boolean
    {
      return _flashPlayer.canRateCurrentItem;
    }

    [Bindable (event="currentItemEmbedCodeChanged")]
    public function get currentItemRatings():Array
    {
      return _flashPlayer.currentItemRatings;
    }

    [Bindable (event="currentItemEmbedCodeChanged")]
    public function get currentItemAverageRating():int
    {
      return _flashPlayer.currentItemAverageRating;
    }

    [Bindable (event="currentItemEmbedCodeChanged")]
    public function get getCurrentItemClosedCaptionsLanguages():Object
    {
      return _flashPlayer.getCurrentItemClosedCaptionsLanguages;
    }

    [Bindable (event="currentItemEmbedCodeChanged")]
    public function get bitratesAvailable():Array
    {
      return _flashPlayer.bitratesAvailable;
    }

    [Bindable (event="currentItemEmbedCodeChanged")]
    public function get bitrateQualitiesAvailable():Array
    {
      return _flashPlayer.bitrateQualitiesAvailable;
    }
  }
}
