/**
 * Created with IntelliJ IDEA.
 * User: jerryorta
 * Date: 5/2/13
 * Time: 11:39 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.alienFx {
    import com.dpa.text.TextUtil;
    import com.dpa.text.params.TextFieldVars;
    import com.dpa.text.params.TextFormatVars;

    import flash.text.AntiAliasType;
import flash.text.GridFitType;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;



    public class ConfigText {

        public static var isInit:Boolean = false;

        public static var TextFormatVars_SHELL_MENU:TextFormatVars = new TextFormatVars();
        public static var TextFieldVars_SHELL_MENU:TextFieldVars = new TextFieldVars();

        public static var TexTFormatVars_CTA:TextFormatVars = new TextFormatVars();
        public static var TextFieldVars_CTA:TextFieldVars = new TextFieldVars();

        public static var TextFormatVars_DesignCalloutLabel:TextFormatVars = new TextFormatVars();
        public static var TextFieldVars_DesignCaloutLabel:TextFieldVars = new TextFieldVars();

        public static var TextFormatVars_DesignCalloutCopy:TextFormatVars = new TextFormatVars();
        public static var TextFieldVars_DesignCalloutCopy:TextFieldVars = new TextFieldVars();

        public static function init():void {

            ConfigText.isInit = true;

            ConfigText.TextFormatVars_SHELL_MENU.color(0xffffff).size(13).font("PillAlt600mg-Medium").align(TextFormatAlign.RIGHT);
            var shellMenuTf:TextFormat = TextUtil.createTextFormat(ConfigText.TextFormatVars_SHELL_MENU.vars);
            ConfigText.TextFieldVars_SHELL_MENU.defaultTextFormat(shellMenuTf).multiline(true).wordWrap(true).embedFonts(true).antiAliasType(AntiAliasType.ADVANCED);

            ConfigText.TexTFormatVars_CTA.color(0x000000).size(12.5).font("PillAlt600mg-Bold").align(TextFormatAlign.LEFT);
            var ctaTF:TextFormat = TextUtil.createTextFormat(ConfigText.TexTFormatVars_CTA.vars);
            ConfigText.TextFieldVars_CTA.defaultTextFormat(ctaTF).multiline(true).wordWrap(true).embedFonts(true).antiAliasType(AntiAliasType.ADVANCED).autoSize(TextFieldAutoSize.LEFT);

            ConfigText.TextFormatVars_DesignCalloutLabel.color(0xffffff).size(13).font("PillAlt600mg-Bold").align(TextFormatAlign.LEFT);
            var designCallOutTF:TextFormat = TextUtil.createTextFormat(ConfigText.TextFormatVars_DesignCalloutLabel.vars);
            ConfigText.TextFieldVars_DesignCaloutLabel.defaultTextFormat(designCallOutTF).multiline(true).wordWrap(true).embedFonts(true).antiAliasType(AntiAliasType.ADVANCED).autoSize(TextFieldAutoSize.LEFT);

            ConfigText.TextFormatVars_DesignCalloutCopy.color(0xffffff).size(13).font("PillAlt600mg-Regular").align(TextFormatAlign.LEFT).leading(4);
            var designCallOutCopyTF:TextFormat = TextUtil.createTextFormat(ConfigText.TextFormatVars_DesignCalloutCopy.vars);
            ConfigText.TextFieldVars_DesignCalloutCopy.defaultTextFormat(designCallOutCopyTF).multiline(true).wordWrap(true).embedFonts(true).antiAliasType(AntiAliasType.ADVANCED).autoSize(TextFieldAutoSize.LEFT);





        }
    }
}
