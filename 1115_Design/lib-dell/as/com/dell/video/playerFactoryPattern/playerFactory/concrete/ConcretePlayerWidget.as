/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/24/13
 * Time: 4:14 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.video.playerFactoryPattern.playerFactory.concrete {
import com.dell.services.PathManager;
import com.dell.video.playerFactoryPattern.playerFactory.abstractWidgets.AbstractPlayerWidget;
import com.dpa.interactive.TopLevel;
import com.dpa.utils.displayObject.getRootDisplayObject;
import com.ooyala.api.FlashPlayer;

import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageDisplayState;
import flash.events.UncaughtErrorEvent;
import flash.ui.Mouse;
import flash.events.Event;


public class ConcretePlayerWidget extends AbstractPlayerWidget {

    private var vars:Object;

    private var _player:FlashPlayer;

    private var _playerWidth:Number;
    private var _playerHeight:Number;

//    private var _unscaledWidth:Number;
//    private var _unscaledHeight:Number;

    private var _apiComplete:Boolean = false;
    private var langCodeArray:Array;
    private var validLanguage:Boolean = false;

    private var _defaultLanguage:String;
    private var _border:Sprite;




    override public function drawWidget(vars:Object = null):void {
        this.vars = (vars != null) ? vars : {};

        if (this.vars.name != null) {
            this.name = this.vars.name;
        }

        _playerWidth = ( this.vars.width != null ) ? this.vars.width : 480;
        _playerHeight = ( this.vars.height != null ) ? this.vars.height : 320;

        _defaultLanguage = ( this.vars.defaultLanguage ) ? this.vars.defaultLanguage : "en";

        init();
    }

    private function init():void {




        _player = new FlashPlayer();



//        this.addEventListener(Event.RESIZE, resize);



        //Placement of player parent is handled by the parent
        _player.x = _player.y = 0;
        _player.width = _playerWidth;
        _player.height = _playerHeight;// - 30;

        this.addChild(_player);

        _player.load();

        _player.addEventListener( "playComplete", playCompleteHandler );
        _player.addEventListener( "playheadTimeChanged", playheadTimeChangedHandler );
        _player.addEventListener( "apiReady", apiReadyHandler );
        _player.addEventListener( "playheadTimeChanged" , progress);
        _player.addEventListener( "playheadTimeChanged" , progress);

//        var _embedCode:String = "g5bnBjOTokYcPaj9W_vRY5OYWVb52CUC";
//        _player.embedCode = _embedCode;

        // static example
//        _player.queryStringParameters = "embedCode=IzMDNwYjr_s8lhBVUZ6qLhZ4dkJI7k27&autoplay=1";



        _border = new Sprite();
        _border.graphics.lineStyle(.5, 0x555555);
        _border.graphics.beginFill(0xffffff, 0);
        _border.graphics.drawRect(0, 0, _playerWidth, _playerHeight);
        _border.graphics.endFill();
        _border.x = border.y = 0;
        addChild(_border);

        _border.mouseEnabled = false;
        _border.mouseChildren = false;

        this.addEventListener(Event.RESIZE, resize);
        this.addEventListener(Event.RENDER, resize);
        resize(null);

    }

    private function onCC( event:Event ):void {

    }

    private function onPause( event:Event ):void {

    }

    private function onPlay( event:Event ):void {

    }

    private function get totalTime():Number {
        return _player.totalTime;
    }

    private function progress(event:Event):void {
//        trace(event.target.playheadTime);
    }

    private function resize(junk:Event):void
    {
        if (TopLevel._stage.displayState == StageDisplayState.NORMAL)
        {
            _border.width = _player.width = _playerWidth;
            _border.height =_player.height = _playerHeight;// - 30;
        } else {
            _player.width = TopLevel._stage.stageWidth;
            _player.height = TopLevel._stage.stageHeight;// - 30;
        }

//        _border.visible = false;
    }

    // used to estimate when the CC is ready
    private function apiReadyHandler( event:Event ):void
    {
        if( !_apiComplete )
        {
            _apiComplete = true;
            trace( "===================" );
            trace( "API ready" );
            trace( "===================" );
        }
        else
        {
            if (PathManager.language != "en") {
                updateClosedCaptions();
            }
        }
    }

    private function updateClosedCaptions():void
    {
        // check for CC
        var languages:String = String( _player.getCurrentItemClosedCaptionsLanguages ); // this actually returns a String
        langCodeArray = new Array();
        // HACK: Split the string/object and use indexOf
        var _languages:Array = languages.split( "," );
        var _languageCountry:String = PathManager.language + "_" + PathManager.country;
        // iterate through the new array
        if( _languages.length > 0 && PathManager.language != null )
        {
            // special for ZH
            if( PathManager.language.toLowerCase() == "zh" )
            {
                if( PathManager.country.toLowerCase() == "cn")
                {
                    _languageCountry = "zh_hans";
                }
                else
                {
                    _languageCountry = "zh_hant";
                }

            }
            for( var _i:int = 0; _i < _languages.length; _i++ )
            {
                if( _languages[_i].indexOf( _languageCountry ) > -1 )
                {
                    validLanguage = true;
                    _player.setClosedCaptionsLanguage = _languageCountry;
                }
                else if( _languages[_i].indexOf( PathManager.language ) )
                {
                    validLanguage = true;
                    _player.setClosedCaptionsLanguage = PathManager.language;
                }
            }
        }
    }

    private function playCompleteHandler( event:Event ):void
    {

        trace( "complete" );
    }

    private function playheadTimeChangedHandler( event:Event ):void
    {
        var _time:Number = (event.target as FlashPlayer).playheadTime;
    }

//    public function get unscaledWidth():Number {
//        return _playerWidth;
//    }
//
//    public function get unscaledHeight():Number {
//        return _playerHeight;
//    }

    public function get player():FlashPlayer {
        return _player;
    }

    public function get border():Sprite {
        return _border;
    }


}
}
