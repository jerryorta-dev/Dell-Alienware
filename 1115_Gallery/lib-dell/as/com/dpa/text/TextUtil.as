/**
 * VERSION:
 * AS3
 *
 * Created with IntelliJ IDEA.
 * User: jerry.orta
 * http://www.digitalproductionart.com/
 * jerryorta@gmail.com
 * Date: 10/15/12
 * Time: 1:07 PM
 */
package com.dpa.text
{
    import com.adobe.serialization.json.JSON_BC;
    import com.dpa.utils.objects.union;

    import flash.text.AntiAliasType;
    import flash.text.GridFitType;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFieldType;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;

    import flash.utils.ByteArray;
    import flash.utils.ByteArray;
    import flash.utils.getQualifiedClassName;
    import flash.geom.Transform;
    import flash.display.DisplayObject;

    public class TextUtil
    {
        public function TextUtil()
        {
        }

        /**
         * http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/TextFormat.html
         *
         * 	font:String (default = null) — The name of a font for text as a string.
         *
         * 	size:Object (default = null) — An integer that indicates the size in pixels.
         *
         * 	color:Object (default = null) — The color of text using this text format. A number containing three 8-bit RGB components; for example, 0xFF0000 is red, and 0x00FF00 is green.
         *
         * 	bold:Object (default = null) — A Boolean value that indicates whether the text is boldface.
         *
         * 	italic:Object (default = null) — A Boolean value that indicates whether the text is italicized.
         *
         * 	underline:Object (default = null) — A Boolean value that indicates whether the text is underlined.
         *
         * 	url:String (default = null) — The URL to which the text in this text format hyperlinks. If url is an empty string, the text does not have a hyperlink.
         *
         * 	target:String (default = null) — The target window where the hyperlink is displayed. If the target window is an empty string, the text is displayed in the default target window _self. If the url parameter is set to an empty string or to the value null, you can get or set this property, but the property will have no effect.
         *
         * 	align:String (default = null) — The alignment of the paragraph, as a TextFormatAlign value.
         *
         * 	leftMargin:Object (default = null) — Indicates the left margin of the paragraph, in pixels.
         *
         * 	rightMargin:Object (default = null) — Indicates the right margin of the paragraph, in pixels.
         *
         * 	indent:Object (default = null) — An integer that indicates the indentation from the left margin to the first character in the paragraph.
         *
         * 	leading:Object (default = null) — A number that indicates the amount of leading vertical space between lines.
         *
         * @param formatVars
         * @param copyFormat
         * @return
         */
        public static function createTextFormat(formatVars:Object = null):TextFormat
        {


            var tf:TextFormat = new TextFormat();
            //TODO add support for device fonts

            tf.font = (formatVars.font) ? formatVars.font : "_sans" ;

            tf.size = (formatVars.size) ? formatVars.size : 10 ;
            tf.color = (formatVars.color) ? formatVars.color : 0x000000;
            tf.bold = (formatVars.bold) ? formatVars.bold : false ;
            tf.italic = (formatVars.italic) ? formatVars.italic : false ;
            tf.underline = (formatVars.underline) ? formatVars.underline : false ;
            tf.url = (formatVars.url) ? formatVars.url : "" ;
            tf.target = (formatVars.target) ? formatVars.target : "_blank" ;
            tf.align = (formatVars.align) ? formatVars.align : TextFormatAlign.LEFT;
            tf.leftMargin = (formatVars.leftMargin) ? formatVars.leftMargin : 0 ;
            tf.rightMargin = (formatVars.rightMargin) ? formatVars.rightMargin : 0 ;
            tf.indent = (formatVars.indent) ? formatVars.indent : 0 ;
            tf.leading = (formatVars.leading) ? formatVars.leading : 0 ;


            return tf;
        }

        public static function createTextFieldParams(paramVars:Object):Object
        {
            return new Object();
        }

        /**
         * http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/TextField.html
         *
         *
         *
         * @param textFormat
         * @param vars
         * @return
         */
        public static function createTextField(vars:Object, defaultText:String = "TEST"):TextField
        {
           //OBJECT_PROPS.traceObjecProps(vars);

            var tf:TextField = new TextField();

            tf.defaultTextFormat = (vars.defaultTextFormat) ? vars.defaultTextFormat : null;

            tf.embedFonts = (vars.embedFonts) ? vars.embedFonts : false;

            //if type should scale with sprite or not
//            tf.gridFitType = (vars.gridFitType != null) ? vars.gridFitType : GridFitType.NONE;
            tf.gridFitType = (vars.gridFitType != null) ? vars.gridFitType : GridFitType.NONE;

            if (vars.sharpness) {
                tf.sharpness = vars.sharpness;
            }


            if (vars.autoSize) {
                tf.autoSize = vars.autoSize;
            } else {
                tf.autoSize = TextFieldAutoSize.LEFT;
            }

            tf.height = (vars.height) ? vars.height : 20;
            tf.multiline = (vars.multiline) ? vars.multiline : false;
            tf.selectable = (vars.selectable) ? vars.selectable : false;
            tf.border = (vars.border) ? vars.border : false;
            tf.borderColor = (vars.border && vars.borderColor) ? vars.borderColor : 0x000000;
            tf.antiAliasType = (vars.antiAliasType) ? vars.antiAliasType : AntiAliasType.NORMAL;
            tf.wordWrap = (vars.wordWrap) ? vars.wordWrap : false;


            if (vars.tabIndex)
            {
                tf.tabEnabled = true;
                tf.tabIndex = vars.tabIndex;
            } else {
                tf.tabEnabled = false;
            }

            if (vars.type)
            {
                tf.type = vars.type;
            }




            if (vars.width) {
                tf.width = vars.width;
            }
//            tf.width = (vars.width) ? vars.width : 100;
            if (vars.htmlText)
            {
                tf.htmlText = vars.htmlText;
            } else {
//                tf.text = defaultText;
            }

            return tf;
        }

        public static function setTextFieldLinesTo(tf:TextField, maxLines:int):Boolean {
            while(tf.numLines > maxLines){
                tf.width +=1;
            }

            return true;
        }



    }
}
