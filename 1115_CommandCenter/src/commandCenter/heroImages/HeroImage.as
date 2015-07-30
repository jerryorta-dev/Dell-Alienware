/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 6/3/13
 * Time: 2:51 PM
 * To change this template use File | Settings | File Templates.
 */
package commandCenter.heroImages {


import com.demonsters.debugger.MonsterDebugger;
import com.greensock.TweenLite;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.ImageLoader;
import com.greensock.loading.LoaderMax;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;

public class HeroImage extends Sprite {
    private var vars:Object;
    public var imageLoader:ImageLoader;

    private var globalBounsdsPoint:Number;

    private var textField:Sprite;

    private var callBack:Function;
    private var isActive:Boolean;
    private var parentCalled:Boolean;


    public function HeroImage(vars:Object) {
        this.vars = (vars != null) ? vars : {};
        this.name = vars.name;
//        trace(vars.name);
        this.textField = vars.textFieldSprite;
        this.callBack = vars.callBack;



        if (this.stage){
            init();
        }else{
            addEventListener(Event.ADDED_TO_STAGE, init);
        }


    }

    private function init(event:Event = null):void {
        if (event){
            removeEventListener(Event.ADDED_TO_STAGE, init);
        }

//        this.imageLoader = LoaderMax.getLoader(this.vars.medloaderName) as ImageLoader;
        this.imageLoader = new ImageLoader(this.vars.url, {onComplete:onComplete});
        MonsterDebugger.trace(this.imageLoader, this.imageLoader, "CommandCenter", "hero url", 0x0060ff);
        this.imageLoader.addEventListener(LoaderEvent.COMPLETE, onComplete, false, 0, true);
        this.imageLoader.load();

        globalBounsdsPoint = this.parent.parent.getChildByName("bounds").localToGlobal(new Point(0, 0)).x;

        startEnterFrame();

    }

    public function startEnterFrame():void {

        this.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
    }

    public function stopEnterFrame():void {
        this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
        isActive = false;
        parentCalled = false;
        TweenLite.to(this,.25, {alpha:1});
    }

    private function onEnterFrame(event:Event):void {
        var thisPoint:Number = this.localToGlobal(new Point(0, 0)).x;


        if (thisPoint > (globalBounsdsPoint - (this.width *.9)) && thisPoint < (globalBounsdsPoint  + this.width)) {
            TweenLite.to(this,.25, {alpha:1});
        } else {
            TweenLite.to(this,.25, {alpha:.2});
        }

        //Text
        if (thisPoint > (globalBounsdsPoint - (this.width *.5)) && thisPoint < (globalBounsdsPoint  + (this.width *.5))) {
            isActive = true;
            TweenLite.to(textField,.25, {alpha:1});
            callParent();
        } else {
            isActive = false;
            parentCalled = false;
            TweenLite.to(textField,.25, {alpha:0});
            callParent();
        }

    }

    public function checkIfHeroisInViewPort():void {
        var thisPoint:Number = this.localToGlobal(new Point(0, 0)).x;
       if (thisPoint > (globalBounsdsPoint - (this.width *.5)) && thisPoint < (globalBounsdsPoint  + (this.width *.5))) {
           if (this.callBack != null) {
               callBack.apply(null, [this.vars]);
           }
       }
    }

    private function onComplete(event:LoaderEvent):void {
//        trace(this.name + " load complete");
        this.imageLoader.removeEventListener(LoaderEvent.COMPLETE, onComplete);

        var img:DisplayObject = this.imageLoader.content;
        img.x = img.y = 0;
        addChild(img);
    }

    private function callParent():void {
        if (isActive) {
            if (!parentCalled) {
                parentCalled = true;
                if (this.callBack != null) {
                    callBack.apply(null, [this.vars]);
                }
            }
        }
    }
}
}
