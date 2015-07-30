/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 6/4/13
 * Time: 4:55 AM
 * To change this template use File | Settings | File Templates.
 */
package commandCenter.uiFactoryPattern {
import com.dell.alienFx.GlobalAnim;
import com.dell.alienFx.SwatchAFX;
import com.dell.services.TrackEvent;
import com.dpa.utils.object.addHandCurserNoChildren;
import com.greensock.TweenLite;

import commandCenter.Omniture.Tracking;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import commandCenter.uiFactoryPattern.abstractCreators.AbstractTextFieldCreator;
import commandCenter.uiFactoryPattern.creators.CreateTextField;

public class CreateNAVText extends Sprite {
    private var vars:Object;
    private var totalHeight:Number = 32;
    private var callBack:Function;
    private var hitBox:Sprite;
    private var action:String;
    private var tabTarget:String;

    private var _isActive:Boolean = false;;
    public function CreateNAVText(vars:Object) {
        this.vars = (vars != null) ? vars : {};
        this.name = vars.name;
        callBack = vars.callBack;
        tabTarget = vars.tabTarget;
        _isActive = (vars.isActive != null) ? vars.isActive : false;

        init();
    }

    private function init(event:Event = null):void {

        var tf:AbstractTextFieldCreator = new CreateTextField();
        var titleParams:Object = {};
        titleParams.name = "title";
        titleParams.xmlNode = vars.xmlNode;
//        trace(vars.xmlNode.title);
        tf.draw(CreateTextField.NAV_TEXT, this, 5, 0, titleParams);

        hitBox = new Sprite;
        hitBox.graphics.beginFill(0xffffff, 0);
        hitBox.graphics.drawRect(0, 0, 130, 33);
        hitBox.graphics.endFill();

        hitBox.x = 0;
        hitBox.y = 0;
        addChild(hitBox);

        addHandCurserNoChildren(hitBox);

        hitBox.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
        hitBox.addEventListener(MouseEvent.ROLL_OVER, onMouseOver, false, 0, true);
        hitBox.addEventListener(MouseEvent.ROLL_OUT, onMouseOut, false, 0, true);


        getTitleField().y = (totalHeight - getTitleField().height) / 2;
    }

    public function getTitleField():TextField {
        return this.getChildByName("title") as TextField;
    }

    private function onMouseDown(event:MouseEvent):void {
       action = "mouseDown";
        var tEvt1:TrackEvent = new TrackEvent('button','CommandCenter-Tab-' + this.name);
        commandCenter.Omniture.Tracking.trackMetrics(tEvt1);
        _isActive = true;
//        ON();
        callBackHandler();
    }

    private function onMouseOver(event:MouseEvent):void {
        action = "mouseOver";
//        ON();
        callBackHandler();
    }

    private function onMouseOut(event:MouseEvent):void {
//        if (!_isActive) {
            action = "mouseOut";

        callBackHandler();
//        OFF();
        //        }


    }

    private function callBackHandler():void {
        if (callBack != null) {
            callBack.apply(null, [tabTarget, action, this.name, _isActive]);
        }
    }

    public function kill():void {
        hitBox.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    }

    public function get isActive():Boolean {
        return _isActive;
    }

    public function set isActive(value:Boolean):void {
        _isActive = value;
        if (value) {
            ON();
        } else {
            OFF();
        }
    }

    private function OFF():void {
        TweenLite.to(getTitleField(), GlobalAnim.TRANSISITION, {tint:SwatchAFX.CC_NAV_OFF});
    }

    private function ON():void {
        TweenLite.to(getTitleField(), GlobalAnim.TRANSISITION, {tint:0xffffff});
    }
}
}
