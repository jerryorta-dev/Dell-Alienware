/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 9:35 AM
 * To change this template use File | Settings | File Templates.
 */
package shell.uiFactoryPattern.concrete {
import com.dell.alienFx.SwatchAFX;
import com.dpa.text.TextUtil;
import com.dpa.text.params.TextFormatVars;

import flash.text.AntiAliasType;
import flash.text.GridFitType;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import shell.uiFactoryPattern.abstractWidgets.AbstractTextFieldWidget;


public class Concrete_DesignedFor_TextFieldWidget extends AbstractTextFieldWidget {

    override public function drawWidget(vars:Object = null):void {
        this.name = vars.name;

        var tf_TextFormatVars:TextFormatVars = new TextFormatVars();
        tf_TextFormatVars.color(0x34fd39);
        tf_TextFormatVars.size(50);
        tf_TextFormatVars.font("PillAlt600mg-Bold");
        tf_TextFormatVars.align(TextFormatAlign.CENTER);

        var tfTextFormt:TextFormat = TextUtil.createTextFormat(tf_TextFormatVars.vars);

//        var tfVars = new TextFieldVars();
        this.defaultTextFormat = tfTextFormt;
        this.embedFonts = true;
        this.gridFitType = GridFitType.NONE;

        //this.sharpness = 100;

        this.autoSize = TextFieldAutoSize.CENTER;
//        this.height = 20;
        this.multiline = false;
        this.selectable = false;
        this.border = false;
        this.borderColor = 0x000000;
        this.antiAliasType = AntiAliasType.ADVANCED;
        this.wordWrap = false;

        this.tabEnabled = false;
//        this.tabIndex = vars.tabIndex;
        this.type = TextFieldType.DYNAMIC;

        this.width = 300;
//        this.height = 100;

         this.htmlText = "DESIGNED FOR";
//        this.text = vars.text;

    }
}
}
