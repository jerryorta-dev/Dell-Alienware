/**
 * Created with IntelliJ IDEA.
 * User: jerryorta
 * Date: 5/2/13
 * Time: 6:26 AM
 * To change this template use File | Settings | File Templates.
 */
package shell.uiGraphics {

import com.dell.alienFx.ConfigGlobal;
import com.dell.alienFx.ConfigText;
import com.dpa.graphics.RoundedRectangle;
import com.dpa.text.TextUtil;
import shell_menu_icons;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;

import shell.uiFactoryPattern.abstractCreators.AbstractTextFieldCreator;
import shell.uiFactoryPattern.creators.CreateTextField;

public class CTAIntro extends Sprite {

    private var vars:Object;
    private var _background:RoundedRectangle;

    private var _tf:TextField;
    private var _icon:MovieClip;
    private var _isActive:Boolean;
    private var _onComplete:Function;

    public function CTAIntro(vars:Object) {
        this.vars = (vars != null) ? vars : {};
        this.name = vars.name;

        if (this.stage) {
            inti();
        } else {
            addEventListener(Event.ADDED_TO_STAGE, inti);
        }
    }

    private function inti(event:Event = null):void {
        if (event) {
            removeEventListener(Event.ADDED_TO_STAGE, inti);
        }

        var bg:Sprite = new Sprite();
        addChild(bg);


        var tfShow:AbstractTextFieldCreator = new CreateTextField();

        //********  TEXT
        vars.name = "ctaIntroText";
        tfShow.draw(CreateTextField.INTRO_CTA, this, 10, 1, vars)
        _tf = this.getChildByName("ctaIntroText") as TextField;

        bg.graphics.beginFill(this.vars.fillColor, 1);
        bg.graphics.drawRoundRect(0, 0, _tf.width + 45, 28, 30);
        bg.graphics.endFill();



        _icon = new IntroCTAIcon().icon;
        _icon.x = _tf.x + _tf.width + 10;
        _icon.y = 4.5;

        addChild(_icon);

        var adjust:Number = -(this.width / 2);

        bg.x += adjust;
        _tf.x += adjust;
        _icon.x += adjust;

    }


    public function rollOver(func:Function = null):void {
//            TweenLite.to(_tf, GlobalAnim.TRANSISITION, {tint:SwatchAFX.SHELL_MENU_TEXT_ROLLOVER});
//            TweenLite.to(_menuHover, GlobalAnim.TRANSISITION, {alpha:1, onComplete:callBack, onCompleteParams:[func]});
    }

    public function click(func:Function = null):void {
//            TweenLite.to(_background, GlobalAnim.TRANSISITION, {matrixTx: ConfigShell.MENU_TAB_MATRIX_TX_ON});
//            TweenLite.to(_background, GlobalAnim.TRANSISITION, {pointX: ConfigShell.MENU_TAB_POINT_XPOS_ON});
//            TweenLite.to(_menuHover, GlobalAnim.TRANSISITION, {alpha:0});
//            TweenLite.to(_icon, GlobalAnim.TRANSISITION, {alpha:ConfigShell.MENU_TAB_ICON_INIT_ALPHA_ON, onComplete:callBack, onCompleteParams:[func]});
    }

    public function rollOut(func:Function = null):void {
//            TweenLite.to(_tf, GlobalAnim.TRANSISITION, {tint:SwatchAFX.SHELL_MENU_TEXT_ROLLOUT});
//            TweenLite.to(_menuHover, GlobalAnim.TRANSISITION, {alpha:0, onComplete:callBack, onCompleteParams:[func]});
    }


    public function deactivate(func:Function = null):void {
//            TweenLite.to(_background, GlobalAnim.TRANSISITION, {matrixTx: ConfigShell.MENU_TAB_MATRIX_TX_OFF});
//            TweenLite.to(_background, GlobalAnim.TRANSISITION, {pointX: ConfigShell.MENU_TAB_POINT_XPOS_OFF});
//            TweenLite.to(_menuHover, GlobalAnim.TRANSISITION, {alpha:0});
//            TweenLite.to(_icon, GlobalAnim.TRANSISITION, {alpha:ConfigShell.MENU_TAB_ICON_INIT_ALPHA_OFF, onComplete:callBack, onCompleteParams:[func]});
    }

    private function callBack(func:Function):void {
        if (func != null) {
            func.apply(null, null);
        }
    }


}
}
