/**
 * VERSION:
 * AS3
 *
 * Created with IntelliJ IDEA.
 * User: jerry.orta
 * http://www.digitalproductionart.com
 *
 * Date: 10/31/12
 * Time: 9:13 AM
 */
package com.dpa.text.params
{
    import com.dpa.utils.objects.union;
    import utils.object.clone;
    import com.dpa.text.StringUtil;

    import flash.text.TextFormat;

    import flash.utils.getQualifiedClassName;

    public class TextFieldVars
    {
        /** @private **/
        public static const version:Number = 1.0;

        /** @private **/
        protected var _vars:Object;


        public function TextFieldVars(vars:Object = null)
        {
            //_target = target;
            _vars = (vars != null) ? clone(vars) : new Object();

        }

        /** @private **/
        protected function _set(property:String, value:*, requirePlugin:Boolean=false):TextFieldVars {
            if (value == null) {
                delete _vars[property]; //in case it was previously set
            } else {
                _vars[property] = value;
            }
            /* if (requirePlugin && !(property in _target.plugins)) {
             trace("WARNING: you must activate() the " + property + " plugin in order for the feature to work in TweenLite. See http://www.greensock.com/tweenlite/#plugins for details.");
             }*/
            return this;
        }

        public function prop(property:String, value:Number, relative:Boolean=false):TextFieldVars {
            return _set(property, (relative) ? String(value) : value);
        }

        public function addVars(newVars:Object):TextFieldVars {
            _vars = union(_vars,  newVars);

            return this;
        }

        //---- PROPERTIES -------------------------------------------------------------------------------------------------------------

        /**
         * The type of anti-aliasing used for this text field. Use flash.text.AntiAliasType constants for this property. You can control this setting only if the font is embedded (with the embedFonts property set to true). The default setting is flash.text.AntiAliasType.NORMAL.

         To set values for this property, use the following string values:

         String value	Description
         flash.text.AntiAliasType.NORMAL	Applies the regular text anti-aliasing. This value matches the type of anti-aliasing that Flash Player 7 and earlier versions used.
         flash.text.AntiAliasType.ADVANCED	Applies advanced anti-aliasing, which makes text more legible. (This feature became available in Flash Player 8.) Advanced anti-aliasing allows for high-quality rendering of font faces at small sizes. It is best used with applications with a lot of small text. Advanced anti-aliasing is not recommended for fonts that are larger than 48 points.


         * @param antiAliasType
         * @return
         */
        public function antiAliasType(antiAliasType:String):TextFieldVars {
            return _set("antiAliasType", antiAliasType);
        }


        /**
         * Specifies whether the text field has a border. If true, the text field has a border. If false, the text field has no border. Use the borderColor property to set the border color.

         The default value is false.
         *
         * @param border
         * @return
         */
        public function border(border:Boolean):TextFieldVars {
            return _set("border", border);
        }

        /**
         *  The color of the text field border. The default value is 0x000000 (black). This property can be retrieved or set, even if there currently is no border, but the color is visible only if the text field has the border property set to true.
         *
         * @param borderColor
         * @return
         */
        public function borderColor(borderColor:uint = undefined):TextFieldVars {
            return _set("borderColor", borderColor);
        }


        /**
         *
         * Controls automatic sizing and alignment of text fields. Acceptable values for the TextFieldAutoSize constants: TextFieldAutoSize.NONE (the default), TextFieldAutoSize.LEFT, TextFieldAutoSize.RIGHT, and TextFieldAutoSize.CENTER.

         If autoSize is set to TextFieldAutoSize.NONE (the default) no resizing occurs.

         If autoSize is set to TextFieldAutoSize.LEFT, the text is treated as left-justified text, meaning that the left margin of the text field remains fixed and any resizing of a single line of the text field is on the right margin. If the text includes a line break (for example, "\n" or "\r"), the bottom is also resized to fit the next line of text. If wordWrap is also set to true, only the bottom of the text field is resized and the right side remains fixed.

         If autoSize is set to TextFieldAutoSize.RIGHT, the text is treated as right-justified text, meaning that the right margin of the text field remains fixed and any resizing of a single line of the text field is on the left margin. If the text includes a line break (for example, "\n" or "\r"), the bottom is also resized to fit the next line of text. If wordWrap is also set to true, only the bottom of the text field is resized and the left side remains fixed.

         If autoSize is set to TextFieldAutoSize.CENTER, the text is treated as center-justified text, meaning that any resizing of a single line of the text field is equally distributed to both the right and left margins. If the text includes a line break (for example, "\n" or "\r"), the bottom is also resized to fit the next line of text. If wordWrap is also set to true, only the bottom of the text field is resized and the left and right sides remain fixed.
         *
         * @param autoSize
         * @return
         */
        public function autoSize(autoSize:String):TextFieldVars {
            return _set("autoSize", autoSize);
        }

        /**
         *
         * Specifies the format applied to newly inserted text, such as text entered by a user or text inserted with the replaceSelectedText() method.

         Note: When selecting characters to be replaced with setSelection() and replaceSelectedText(), the defaultTextFormat will be applied only if the text has been selected up to and including the last character. Here is an example:

         var my_txt:TextField new TextField();
         my_txt.text = "Flash Macintosh version";
         var my_fmt:TextFormat = new TextFormat();
         my_fmt.color = 0xFF0000;
         my_txt.defaultTextFormat = my_fmt;
         my_txt.setSelection(6,15); // partial text selected - defaultTextFormat not applied
         my_txt.setSelection(6,23); // text selected to end - defaultTextFormat applied
         my_txt.replaceSelectedText("Windows version");

         When you access the defaultTextFormat property, the returned TextFormat object has all of its properties defined. No property is null.

         Note: You can't set this property if a style sheet is applied to the text field.


         *
         * @param defaultTextFormat
         * @return
         */
        public function defaultTextFormat(defaultTextFormat:TextFormat):TextFieldVars {
            return _set("defaultTextFormat", defaultTextFormat);
        }

        /**
         *
         * Specifies whether to render by using embedded font outlines. If false, Flash Player renders the text field by using device fonts.

         If you set the embedFonts property to true for a text field, you must specify a font for that text by using the font property of a TextFormat object applied to the text field. If the specified font is not embedded in the SWF file, the text is not displayed.

         The default value is false.
         *
         * @param embedFonts
         * @return
         */
        public function embedFonts(embedFonts:Boolean):TextFieldVars {
            return _set("embedFonts", embedFonts);
        }

        /**
         * Indicates whether field is a multiline text field. If the value is true, the text field is multiline; if the value is false, the text field is a single-line text field. In a field of type TextFieldType.INPUT, the multiline value determines whether the Enter key creates a new line (a value of false, and the Enter key is ignored). If you paste text into a TextField with a multiline value of false, newlines are stripped out of the text.

         The default value is false.

         * @param multiline
         * @return
         */
        public function multiline(multiline:Boolean):TextFieldVars {
            return _set("multiline", multiline);
        }


        /**
         * A Boolean value that indicates whether the text field is selectable. The value true indicates that the text is selectable. The selectable property controls whether a text field is selectable, not whether a text field is editable. A dynamic text field can be selectable even if it is not editable. If a dynamic text field is not selectable, the user cannot select its text.

         If selectable is set to false, the text in the text field does not respond to selection commands from the mouse or keyboard, and the text cannot be copied with the Copy command. If selectable is set to true, the text in the text field can be selected with the mouse or keyboard, and the text can be copied with the Copy command. You can select text this way even if the text field is a dynamic text field instead of an input text field.

         The default value is true.

         * @param selectable
         * @return
         */
        public function selectable(selectable:Boolean):TextFieldVars {
            return _set("selectable", selectable);
        }

        /**
         * A Boolean value that indicates whether the text field has word wrap. If the value of wordWrap is true, the text field has word wrap; if the value is false, the text field does not have word wrap. The default value is false.
         *
         * @param wordWrap
         * @return
         */
        public function wordWrap(wordWrap:Boolean):TextFieldVars {
            return _set("wordWrap", wordWrap);
        }

        /**
         * Specifies whether this object is in the tab order. If this object is in the tab order, the value is true; otherwise, the value is false. By default, the value is false, except for the following:

         For a SimpleButton object, the value is true.
         For a TextField object with type = "input", the value is true.
         For a Sprite object or MovieClip object with buttonMode = true, the value is true.


         * @param tabEnabled
         * @return
         */
        public function tabEnabled(tabEnabled:Boolean):TextFieldVars {
            return _set("tabEnabled", tabEnabled);
        }


        /**
         * Specifies the tab ordering of objects in a SWF file. The tabIndex property is -1 by default, meaning no tab index is set for the object.

         If any currently displayed object in the SWF file contains a tabIndex property, automatic tab ordering is disabled, and the tab ordering is calculated from the tabIndex properties of objects in the SWF file. The custom tab ordering includes only objects that have tabIndex properties.

         The tabIndex property can be a non-negative integer. The objects are ordered according to their tabIndex properties, in ascending order. An object with a tabIndex value of 1 precedes an object with a tabIndex value of 2. Do not use the same tabIndex value for multiple objects.

         The custom tab ordering that the tabIndex property defines is flat. This means that no attention is paid to the hierarchical relationships of objects in the SWF file. All objects in the SWF file with tabIndex properties are placed in the tab order, and the tab order is determined by the order of the tabIndex values.

         Note: To set the tab order for TLFTextField instances, cast the display object child of the TLFTextField as an InteractiveObject, then set the tabIndex property. For example:

         InteractiveObject(tlfInstance.getChildAt(1)).tabIndex = 3;

         To reverse the tab order from the default setting for three instances of a TLFTextField object (tlfInstance1, tlfInstance2 and tlfInstance3), use:
         InteractiveObject(tlfInstance1.getChildAt(1)).tabIndex = 3;
         InteractiveObject(tlfInstance2.getChildAt(1)).tabIndex = 2;
         InteractiveObject(tlfInstance3.getChildAt(1)).tabIndex = 1
         * @param tabIndex
         * @return
         */
        public function tabIndex(tabIndex:int):TextFieldVars {
            return _set("tabIndex", tabIndex);
        }


        /**
         * The type of the text field. Either one of the following TextFieldType constants: TextFieldType.DYNAMIC, which specifies a dynamic text field, which a user cannot edit, or TextFieldType.INPUT, which specifies an input text field, which a user can edit.

         The default value is dynamic.

         * @param type
         * @return
         */
        public function type(type:String):TextFieldVars {
            return _set("type", type);
        }


        public function gridFitType(gridFitType:String):TextFieldVars {
            return _set("gridFitType", gridFitType);
        }

        public function sharpness(sharpness:Number):TextFieldVars {
            return _set("sharpness", sharpness);
        }

        /**
         *
         * Contains the HTML representation of the text field contents.

         http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/TextField.html#htmlText

         * @param htmlText
         * @return
         */
        public function htmlText(htmlText:String):TextFieldVars {
            _vars["isHtmlText"] = true;
            return _set("htmlText", htmlText);
        }

        public function isHtmlText(isHtmlText:Boolean):TextFieldVars {
            return _set("isHtmlText", isHtmlText);
        }

        /**
         * A string that is the current text in the text field. Lines are separated by the carriage return character ('\r', ASCII 13). This property contains unformatted text in the text field, without HTML tags.

         To get the text in HTML form, use the htmlText property.

         Note: If a style sheet is applied to the text field the content of the text property will be interpreted as HTML.

         * @param text
         * @return
         */
        public function text(text:String):TextFieldVars {
            return _set("text", text);
        }

        //---- COMPONENT PROPERTIES -------------------------------------------------------------------------------------------------------------


        public function width(width:Number):TextFieldVars {
            return _set("width", width);
        }



        public function height(height:Number):TextFieldVars {
            return _set("height", height);
        }

        //---- GETTERS / SETTERS -------------------------------------------------------------------------------------------------------------

        /** The generic object populated by all of the method calls in the TweenLiteVars instance. This is the raw data that gets passed to the tween. **/
        public function get vars():Object {
            return _vars;
        }

        /** @private **/
        public function get isTextFieldVars():Boolean {
            return true;
        }
    }
}
