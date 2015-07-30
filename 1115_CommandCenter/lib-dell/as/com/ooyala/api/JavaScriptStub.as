

/**
* GENERATED CODE!!!
* do not edit the .as file, which is generated. Edit the template instead
*/

package com.ooyala.api
{
  import flash.display.Stage;
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.external.ExternalInterface;
  import flash.system.Security;

  /**
  * The stub to receive JavaScript invocations as well as handle
  * notification delivery.
  */
  internal final class JavaScriptStub
  {
    private var _flashPlayer:FlashPlayer;
    private var _callback:String;
    private var _eventDispatcher:EventDispatcher;
    private var _priority:int;

    private var _callLaterFunction:Function;

    public function JavaScriptStub(
      callback:String,
      player:FlashPlayer,
      eventDispatcher:EventDispatcher,
      priority:int = -1,
      callLaterFunction:Function = null)
    {
      this._flashPlayer = player;
      this._callback = callback;
      this._eventDispatcher = eventDispatcher;
      this._priority = priority;
      if (callLaterFunction == null)
      {
        this._callLaterFunction = this.callLater;
      }
      else
      {
        this._callLaterFunction = callLaterFunction;
      }

      if (player.loaded)
      {
        dispatchAppComplete();
      }
      else
      {
        eventDispatcher.addEventListener("loadComplete", dispatchAppComplete, false, priority);
      }
    }

    /**
    * This function is invoked when player ready (app complete had been dispatched already)
    * and we have javaScriptCallback set.
    */
    private function dispatchAppComplete(unused:Event = null):void
    {
      if (ExternalInterface.available)
      {
        Security.allowDomain("*");//To avoid potential problems when HTML page and outer SWF (the one which embeds player) are comming from different domains

        //BEGIN Generated: public functions

        ExternalInterface.addCallback("playMovie", _flashPlayer.playMovie);
        ExternalInterface.addCallback("pauseMovie", _flashPlayer.pauseMovie);
        ExternalInterface.addCallback("playSynchronized", _flashPlayer.playSynchronized);
        ExternalInterface.addCallback("ivStartSearch", _flashPlayer.ivStartSearch);
        ExternalInterface.addCallback("ivGetDescription", _flashPlayer.ivGetDescription);
        ExternalInterface.addCallback("showChannel", _flashPlayer.showChannel);
        ExternalInterface.addCallback("changeCurrentItem", _flashPlayer.changeCurrentItem);
        ExternalInterface.addCallback("getPromoFor", _flashPlayer.getPromoFor);
        ExternalInterface.addCallback("fetchRelatedMedia", _flashPlayer.fetchRelatedMedia);
        ExternalInterface.addCallback("fetchMetadata", _flashPlayer.fetchMetadata);
        ExternalInterface.addCallback("getTimedText", _flashPlayer.getTimedText);
        ExternalInterface.addCallback("loadRatingsApi", _flashPlayer.loadRatingsApi);
        ExternalInterface.addCallback("incrementCurrentItemRating", _flashPlayer.incrementCurrentItemRating);
        //END Generated

        //BEGIN Generated: public gets and sets

        ExternalInterface.addCallback("getLoaded", getLoaded);
        ExternalInterface.addCallback("getWidth", getWidth);
        ExternalInterface.addCallback("getHeight", getHeight);
        ExternalInterface.addCallback("getItem", getItem);
        ExternalInterface.addCallback("getTitle", getTitle);
        ExternalInterface.addCallback("getLineup", getLineup);
        ExternalInterface.addCallback("getDescription", getDescription);
        ExternalInterface.addCallback("getEmbedCode", getEmbedCode);
        ExternalInterface.addCallback("getTotalTime", getTotalTime);
        ExternalInterface.addCallback("getPlayheadTime", getPlayheadTime);
        ExternalInterface.addCallback("getVolume", getVolume);
        ExternalInterface.addCallback("getBufferLength", getBufferLength);
        ExternalInterface.addCallback("getBitratesAvailable", getBitratesAvailable);
        ExternalInterface.addCallback("getBitrateQualitiesAvailable", getBitrateQualitiesAvailable);
        ExternalInterface.addCallback("getTargetBitrateQuality", getTargetBitrateQuality);
        ExternalInterface.addCallback("getTargetBitrate", getTargetBitrate);
        ExternalInterface.addCallback("getState", getState);
        ExternalInterface.addCallback("getErrorCode", getErrorCode);
        ExternalInterface.addCallback("getErrorText", getErrorText);
        ExternalInterface.addCallback("getCurrentItem", getCurrentItem);
        ExternalInterface.addCallback("getCurrentItemEmbedCode", getCurrentItemEmbedCode);
        ExternalInterface.addCallback("getCurrentItemTitle", getCurrentItemTitle);
        ExternalInterface.addCallback("getCurrentItemDescription", getCurrentItemDescription);
        ExternalInterface.addCallback("getFullscreen", getFullscreen);
        ExternalInterface.addCallback("getActivePanel", getActivePanel);
        ExternalInterface.addCallback("getIvclickobj", getIvclickobj);
        ExternalInterface.addCallback("getCvdescobj", getCvdescobj);
        ExternalInterface.addCallback("getIv_search_results", getIv_search_results);
        ExternalInterface.addCallback("getIvMostRecentlyAppeared", getIvMostRecentlyAppeared);
        ExternalInterface.addCallback("getCanRateCurrentItem", getCanRateCurrentItem);
        ExternalInterface.addCallback("getCurrentItemRatings", getCurrentItemRatings);
        ExternalInterface.addCallback("getCurrentItemAverageRating", getCurrentItemAverageRating);

        ExternalInterface.addCallback("setWidth", setWidth);
        ExternalInterface.addCallback("setHeight", setHeight);
        ExternalInterface.addCallback("setQueryStringParameters", setQueryStringParameters);
        ExternalInterface.addCallback("setEmbedCode", setEmbedCode);
        ExternalInterface.addCallback("setCurrentItemEmbedCode", setCurrentItemEmbedCode);
        ExternalInterface.addCallback("setPlayheadTime", setPlayheadTime);
        ExternalInterface.addCallback("setVolume", setVolume);
        ExternalInterface.addCallback("setTargetBitrateQuality", setTargetBitrateQuality);
        ExternalInterface.addCallback("setTargetBitrate", setTargetBitrate);
        //END Generated

        //BEGIN Generated: events

        _eventDispatcher.addEventListener("loadComplete", onLoadComplete,false, _priority);
        _eventDispatcher.addEventListener("apiReady", onApiReady,false, _priority);
        _eventDispatcher.addEventListener("playComplete", onPlayComplete,false, _priority);
        _eventDispatcher.addEventListener("totalTimeChanged", onTotalTimeChanged,false, _priority);
        _eventDispatcher.addEventListener("playheadTimeChanged", onPlayheadTimeChanged,false, _priority);
        _eventDispatcher.addEventListener("volumeChanged", onVolumeChanged,false, _priority);
        _eventDispatcher.addEventListener("targetBitrateQualityChanged", onTargetBitrateQualityChanged,false, _priority);
        _eventDispatcher.addEventListener("targetBitrateChanged", onTargetBitrateChanged,false, _priority);
        _eventDispatcher.addEventListener("attemptFullScreenChange", onAttemptFullScreenChange,false, _priority);
        _eventDispatcher.addEventListener("activePanelChanged", onActivePanelChanged,false, _priority);
        _eventDispatcher.addEventListener("adStarted", onAdStarted,false, _priority);
        _eventDispatcher.addEventListener("adCompleted", onAdCompleted,false, _priority);
        _eventDispatcher.addEventListener("adError", onAdError,false, _priority);
        _eventDispatcher.addEventListener("adClicked", onAdClicked,false, _priority);
        _eventDispatcher.addEventListener("closedCaptionsTextReady", onClosedCaptionsTextReady,false, _priority);
        _eventDispatcher.addEventListener("relatedMediaReady", onRelatedMediaReady,false, _priority);
        _eventDispatcher.addEventListener("metadataReady", onMetadataReady,false, _priority);
        _eventDispatcher.addEventListener("ratingsApiReady", onRatingsApiReady,false, _priority);
        _eventDispatcher.addEventListener("companionAdsReady", onCompanionAdsReady,false, _priority);
        _eventDispatcher.addEventListener("seeked", onSeeked,false, _priority);
        //END Generated

        //Legacy Special functions and events that does not fit into generated code format, mainly around state returned by event
        ExternalInterface.addCallback("setCurrentItemEmbedCode", _flashPlayer.changeCurrentItem);
        ExternalInterface.addCallback("setClosedCaptionsLanguage", setClosedCaptionsLanguage);
        ExternalInterface.addCallback("getCurrentItemClosedCaptionsLanguages", getCurrentItemClosedCaptionsLanguages);
        _eventDispatcher.addEventListener("embedCodeChanged", onEmbedCodeChanged,false, _priority);
        _eventDispatcher.addEventListener("stateChanged", onStateChanged,false, _priority);
        _eventDispatcher.addEventListener("currentItemEmbedCodeChanged", onCurrentItemEmbedCodeChanged,false, _priority);
        _eventDispatcher.addEventListener("ivUserClicked",onCvUserClicked ,false, _priority);
        _eventDispatcher.addEventListener("ivObjectDescriptionReady", onObjectDescriptionReady,false, _priority);
        _eventDispatcher.addEventListener("ivSearchResultsReady", onCvSearchResultReady,false, _priority);
        _eventDispatcher.addEventListener("ivNewObjectPresent", onIvNewObjectPresent,false, _priority);

        notify("loadComplete",new Object());
      }
    }
    //BEGIN generated: gets and sets

    private function getLoaded():Boolean
    {
      return _flashPlayer.loaded;
    }
    private function getWidth():Number
    {
      return _flashPlayer.width;
    }
    private function getHeight():Number
    {
      return _flashPlayer.height;
    }
    private function getItem():ContentItemDescription
    {
      return _flashPlayer.item;
    }
    private function getTitle():String
    {
      return _flashPlayer.title;
    }
    private function getLineup():Array
    {
      return _flashPlayer.lineup;
    }
    private function getDescription():String
    {
      return _flashPlayer.description;
    }
    private function getEmbedCode():String
    {
      return _flashPlayer.embedCode;
    }
    private function getTotalTime():Number
    {
      return _flashPlayer.totalTime;
    }
    private function getPlayheadTime():Number
    {
      return _flashPlayer.playheadTime;
    }
    private function getVolume():Number
    {
      return _flashPlayer.volume;
    }
    private function getBufferLength():Number
    {
      return _flashPlayer.bufferLength;
    }
    private function getBitratesAvailable():Array
    {
      return _flashPlayer.bitratesAvailable;
    }
    private function getBitrateQualitiesAvailable():Array
    {
      return _flashPlayer.bitrateQualitiesAvailable;
    }
    private function getTargetBitrateQuality():String
    {
      return _flashPlayer.targetBitrateQuality;
    }
    private function getTargetBitrate():Number
    {
      return _flashPlayer.targetBitrate;
    }
    private function getState():String
    {
      return _flashPlayer.state;
    }
    private function getErrorCode():Number
    {
      return _flashPlayer.errorCode;
    }
    private function getErrorText():String
    {
      return _flashPlayer.errorText;
    }
    private function getCurrentItem():ContentItemDescription
    {
      return _flashPlayer.currentItem;
    }
    private function getCurrentItemEmbedCode():String
    {
      return _flashPlayer.currentItemEmbedCode;
    }
    private function getCurrentItemTitle():String
    {
      return _flashPlayer.currentItemTitle;
    }
    private function getCurrentItemDescription():String
    {
      return _flashPlayer.currentItemDescription;
    }
    private function getFullscreen():Boolean
    {
      return _flashPlayer.fullscreen;
    }
    private function getActivePanel():String
    {
      return _flashPlayer.activePanel;
    }
    private function getIvclickobj():Object
    {
      return _flashPlayer.ivclickobj;
    }
    private function getCvdescobj():Object
    {
      return _flashPlayer.cvdescobj;
    }
    private function getIv_search_results():Object
    {
      return _flashPlayer.iv_search_results;
    }
    private function getIvMostRecentlyAppeared():Object
    {
      return _flashPlayer.ivMostRecentlyAppeared;
    }
    private function getCanRateCurrentItem():Boolean
    {
      return _flashPlayer.canRateCurrentItem;
    }
    private function getCurrentItemRatings():Array
    {
      return _flashPlayer.currentItemRatings;
    }
    private function getCurrentItemAverageRating():int
    {
      return _flashPlayer.currentItemAverageRating;
    }

    private function setWidth(value:Number):void
    {
      _flashPlayer.width=value;
    }
    private function setHeight(value:Number):void
    {
      _flashPlayer.height=value;
    }
    private function setQueryStringParameters(value:*):void
    {
      _flashPlayer.queryStringParameters=value;
    }
    private function setEmbedCode(value:String):void
    {
      _flashPlayer.embedCode=value;
    }
    private function setCurrentItemEmbedCode(value:String):void
    {
      _flashPlayer.currentItemEmbedCode=value;
    }
    private function setPlayheadTime(value:Number):void
    {
      _flashPlayer.playheadTime=value;
    }
    private function setVolume(value:Number):void
    {
      _flashPlayer.volume=value;
    }
    private function setTargetBitrateQuality(value:String):void
    {
      _flashPlayer.targetBitrateQuality=value;
    }
    private function setTargetBitrate(value:Number):void
    {
      _flashPlayer.targetBitrate=value;
    }
    //END generated

    //BEGIN Generated: events

    private function onLoadComplete(unused:Event = null):void
    {
      notify("loadComplete", new Object());
    }
    private function onApiReady(unused:Event = null):void
    {
      notify("apiReady", new Object());
    }
    private function onPlayComplete(unused:Event = null):void
    {
      notify("playComplete", new Object());
    }
    private function onTotalTimeChanged(unused:Event = null):void
    {
      notify("totalTimeChanged", {totalTime:_flashPlayer.totalTime});
    }
    private function onPlayheadTimeChanged(unused:Event = null):void
    {
      notify("playheadTimeChanged", {playheadTime:_flashPlayer.playheadTime});
    }
    private function onVolumeChanged(unused:Event = null):void
    {
      notify("volumeChanged", {volume:_flashPlayer.volume});
    }
    private function onTargetBitrateQualityChanged(unused:Event = null):void
    {
      notify("targetBitrateQualityChanged", {targetBitrateQuality:_flashPlayer.targetBitrateQuality});
    }
    private function onTargetBitrateChanged(unused:Event = null):void
    {
      notify("targetBitrateChanged", {targetBitrate:_flashPlayer.targetBitrate});
    }
    private function onAttemptFullScreenChange(unused:Event = null):void
    {
      notify("attemptFullScreenChange", new Object());
    }
    private function onActivePanelChanged(unused:Event = null):void
    {
      notify("activePanelChanged", {activePanel:_flashPlayer.activePanel});
    }
    private function onAdStarted(unused:Event = null):void
    {
      notify("adStarted", new Object());
    }
    private function onAdCompleted(unused:Event = null):void
    {
      notify("adCompleted", new Object());
    }
    private function onAdError(unused:Event = null):void
    {
      notify("adError", new Object());
    }
    private function onAdClicked(unused:Event = null):void
    {
      notify("adClicked", new Object());
    }
    private function onClosedCaptionsTextReady(unused:Event = null):void
    {
      notify("closedCaptionsTextReady", new Object());
    }
    private function onRelatedMediaReady(unused:Event = null):void
    {
      notify("relatedMediaReady", new Object());
    }
    private function onMetadataReady(unused:Event = null):void
    {
      notify("metadataReady", new Object());
    }
    private function onRatingsApiReady(unused:Event = null):void
    {
      notify("ratingsApiReady", new Object());
    }
    private function onCompanionAdsReady(unused:Event = null):void
    {
      notify("companionAdsReady", new Object());
    }
    private function onSeeked(unused:Event = null):void
    {
      notify("seeked", new Object());
    }
    //END Generated

    //Legacy Special cases that does not fit into generated code format, mainly around state returned by event
    private function getCurrentItemClosedCaptionsLanguages():Object
    {
      return _flashPlayer.getCurrentItemClosedCaptionsLanguages;
    }
    private function setClosedCaptionsLanguage(value:String):void
    {
      _flashPlayer.setClosedCaptionsLanguage=value;
    }

    private function onEmbedCodeChanged(unused:Event = null):void
    {
      notify("embedCodeChanged", _flashPlayer.item);
    }

    private function onStateChanged(unused:Event = null):void
    {
      notify("stateChanged", {state:_flashPlayer.state, errorCode:_flashPlayer.errorCode, errorText:_flashPlayer.errorText});
    }

    private function onCurrentItemEmbedCodeChanged(unused:Event = null):void
    {
      notify("currentItemEmbedCodeChanged", _flashPlayer.currentItem);
    }

    private function onFullscreenChanged(unused:Event = null):void
    {
      notify("fullscreenChanged",{state:this.getFullscreen() ? "fullScreen" : "normal"});
    }

    private function onCvUserClicked(unused:Event = null):void
    {
      notify("ivUserClicked", _flashPlayer.ivclickobj);
    }

    private function onObjectDescriptionReady(unused:Event = null):void
    {
      notify("objectDescriptionReady", _flashPlayer.cvdescobj);
    }

    private function onCvSearchResultReady(unused:Event = null):void
    {
      notify("ivSearchResultsReady", _flashPlayer.iv_search_results);
    }

    private function onIvNewObjectPresent(unused:Event = null):void
    {
      notify("ivNewObjectPresent", _flashPlayer.ivMostRecentlyAppeared);
    }

    /**
    * JavaScript notifications.
    * javascript notifications are dispatched always asynchronously
    * (same behavior is when using javascript APIs with player directly, otherwise
    * some browser are having problems dispatching notifications from as direct
    * result of API method call, e.g. delievery of volume changed notification
    * due to JavaScript API call setVolume(0.5) may fail sporadically, so the real solution
    * is to deliever all notifications asynchronously)
    */
    private function notify(name:String, o:Object):void
    {
      if (!_flashPlayer.loaded)
      {
        //trace("app complete has not been dispatched yet");
        return;
      }

      _callLaterFunction(ExternalInterface.call, [_callback, ExternalInterface.objectID, name, o]);
    }

    private var _boundToFrame:Boolean = false;
    private var _callLaterQueue:Array = [];
    /**
    * This is backported callLater function to use in case of absence of Flex.
    * In the case of Flex's embedding the Flex's standard callLater will be used
    * to have consitant order, e.g. for following pseudo-code
    *
    * UIComponenent.callLater(a);
    * FlashPlayer.callLater(b);
    *
    * function a() has to be executed always before b() in callLater dispatchers.
    *
    * If Flex's version of player is not used (it's still possible to use FlashPlayer inside of Flex app)
    * this behavior is not guaranteed, i.e. sporadically you may see a()
    * executed before or after b().
    */
    private function callLater(f:Function, args:Array):void
    {
      _callLaterQueue.push(new MethodQueueElement(f, args));
      const stage:Stage = _flashPlayer.stage;
      if (!_boundToFrame)
      {
        _boundToFrame = true;
        stage.addEventListener(Event.RENDER, callLaterDispatcher);
        stage.addEventListener(Event.ENTER_FRAME, callLaterDispatcher);
      }
      // Force a "render" event to happen soon:
      stage.invalidate();
    }
    private function callLaterDispatcher(unused:Event = null):void
    {
      const stage:Stage = _flashPlayer.stage;
      if (_boundToFrame)
      {
        _boundToFrame = false;
        stage.removeEventListener(Event.RENDER, callLaterDispatcher);
        stage.removeEventListener(Event.ENTER_FRAME, callLaterDispatcher);
      }
      const q:Array = this._callLaterQueue;
      this._callLaterQueue = [];
      for each (var mqe:MethodQueueElement in q)
      {
        mqe.method.apply(null, mqe.args);
      }
    }
  }//end of class
}

internal class MethodQueueElement
{
  public function MethodQueueElement(method:Function, args:Array = null)
  {
    super();

    this.method = method;
    this.args = args;
  }
  public var method:Function;
  public var args:Array;
}
