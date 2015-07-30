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

public class CTAButtonRender extends Sprite{

        private var vars:Object;
        private var _background:RoundedRectangle;

        private var _tf:TextField;
        private var _icon:MovieClip;
        private var _isActive:Boolean;
        private var _onComplete:Function;

        public function CTAButtonRender(vars:Object) {
            this.vars = (vars != null) ? vars : {};
            this.name = vars.name;
            //********  CREATE BACKGROUND
            ConfigGlobal.CTA.initState = vars.state;
            _background = new RoundedRectangle(ConfigGlobal.getCTA());

            //Leave this hard coded for now (coded here)
            _background.x = _background.y = 0;
            this.addChild(_background);

            //********  TEXT
            ConfigText.TextFieldVars_CTA.htmlText(this.vars.title);
            _tf = TextUtil.createTextField(ConfigText.TextFieldVars_CTA.vars);
            _tf.x = ConfigGlobal.CTA_TextField_XPOS;
            _tf.y = ConfigGlobal.CTA_TextField_YPOS;

            this.addChild(_tf);

            _tf.addEventListener(Event.ADDED_TO_STAGE, addIcon, false, 0, true);



        }

    private function addIcon(e:Event):void {
        //********  ICON

        TextUtil.setTextFieldLinesTo(_tf, 1);
//        trace("lineMetrics: "  + _tf.getLineMetrics(0).width);
//        trace("this.vars.icon: " + this.vars.icon);

        _icon = new shell_menu_icons()[this.vars.icon];
        _icon.x = _tf.x + _tf.getLineMetrics(0).width + ConfigGlobal.CTA_ICON_MARGIN_LEFT;
        _icon.y = ConfigGlobal.CTA_ICON_YPOS;

        this.addChild(_icon);
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
