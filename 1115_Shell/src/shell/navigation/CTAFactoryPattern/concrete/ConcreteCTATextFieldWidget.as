/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 9:35 AM
 * To change this template use File | Settings | File Templates.
 */
package shell.navigation.CTAFactoryPattern.concrete {
import com.dpa.text.TextUtil;
import com.dpa.text.params.TextFormatVars;

import flash.text.AntiAliasType;
import flash.text.GridFitType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import shell.navigation.CTAFactoryPattern.abstractWidgets.AbstractTextFieldWidget;

public class ConcreteCTATextFieldWidget extends AbstractTextFieldWidget {

    private var vars:Object;
    private var _onComplete:Function;



    override public function drawWidget(vars:Object = null):void {

        this.vars = (vars != null) ? vars : {};


        _onComplete = (this.vars.onComplete != null) ? this.vars.onComplete : null;

        this.name = (this.vars.name != null) ? this.vars.name : "tf";

        var tf_TextFormatVars:TextFormatVars = new TextFormatVars();
        tf_TextFormatVars.color(0x000000);
        tf_TextFormatVars.size(12.5);
        tf_TextFormatVars.font("PillAlt600mg-Bold");
        tf_TextFormatVars.align(TextFormatAlign.LEFT);

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

        //SET WIDTH OR HEIGHT BEFORE SETTING TEXT

//        this.width = 90;
        this.htmlText = vars.htmlText;
//        this.text = vars.text;

        if (this.vars.onComplete != null) {
            _onComplete.apply(null, null);
        }


    }

}
}
