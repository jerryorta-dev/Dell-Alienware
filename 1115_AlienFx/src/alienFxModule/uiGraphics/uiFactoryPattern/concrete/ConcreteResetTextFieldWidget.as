/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 9:35 AM
 * To change this template use File | Settings | File Templates.
 */
package alienFxModule.uiGraphics.uiFactoryPattern.concrete {
import com.dpa.text.TextUtil;
import com.dpa.text.params.TextFormatVars;

import flash.text.AntiAliasType;
import flash.text.GridFitType;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import alienFxModule.uiGraphics.uiFactoryPattern.abstractWidgets.AbstractTextFieldWidget;


public class ConcreteResetTextFieldWidget extends AbstractTextFieldWidget {

    override public function drawWidget(vars:Object = null):void {
        this.name = vars.name;

        var tf_TextFormatVars:TextFormatVars = new TextFormatVars();
        tf_TextFormatVars.color(0x848488);
//        tf_TextFormatVars.color(0xffffff);
        tf_TextFormatVars.size(12);
        tf_TextFormatVars.font("PillAlt600mg-Medium");
        tf_TextFormatVars.align(TextFormatAlign.CENTER);

        var tfTextFormt:TextFormat = TextUtil.createTextFormat(tf_TextFormatVars.vars);

//        var tfVars = new TextFieldVars();
        this.defaultTextFormat = tfTextFormt;
        this.embedFonts = true;
        this.gridFitType = GridFitType.NONE;

        //this.sharpness = 100;

        this.autoSize = TextFieldAutoSize.LEFT;
//        this.height = 20;
        this.multiline = true;
        this.selectable = false;
        this.border = false;
        this.borderColor = 0x000000;
        this.antiAliasType = AntiAliasType.ADVANCED;
        this.wordWrap = true;

        this.tabEnabled = false;
//        this.tabIndex = vars.tabIndex;
        this.type = TextFieldType.DYNAMIC;

        this.width = 62;
//        this.height = 100;

         this.htmlText = vars.htmlText;
//        this.text = vars.text;

    }
}
}
