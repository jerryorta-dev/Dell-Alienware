/**
 * VERSION:
 * AS3
 *
 * Created with IntelliJ IDEA.
 * User: jerry.orta
 * http://www.digitalproductionart.com
 *
 * Date: 10/31/12
 * Time: 9:14 AM
 */
package com.dpa.text.params
{
    import com.adobe.serialization.json.JSON_BC;
    import com.dpa.utils.objects.union;
    import com.dpa.text.CloneTextObjects;
    import com.dpa.text.StringUtil;
    import com.dpa.text.TextUtil;

    import flash.text.Font;

    import flash.text.TextFormat;
    import flash.utils.getQualifiedClassName;

    import utils.type.getClassName;


    public class TextFormatVars
    {
        protected var _format:TextFormat;
        
        public function TextFormatVars(vars:TextFormat = null)
        {
            //_target = target;
            _format = (vars != null) ? CloneTextObjects.clone(vars) : new TextFormat();
        }

        /** @private **/
        protected function _set(property:String, value:*, requirePlugin:Boolean=false):TextFormatVars {
            if (value == null) {
                delete _format[property]; //in case it was previously set
            } else {
                _format[property] = value;
            }
            /* if (requirePlugin && !(property in _target.plugins)) {
             trace("WARNING: you must activate() the " + property + " plugin in order for the feature to work in TweenLite. See http://www.greensock.com/tweenlite/#plugins for details.");
             }*/

            //trace(_format[property]);
            return this;
        }

        protected function _setFont(property:String,  value:Font):TextFormatVars {
            _format[property] = value as Font;
            return this;
        }


        //---- PROPERTIES -------------------------------------------------------------------------------------------------------------

        /**
         * Indicates the alignment of the paragraph. Valid values are TextFormatAlign constants.
         *
         * The default value is TextFormatAlign.LEFT.
         *
         * @param align
         * @return
         */
        public function align(align:String):TextFormatVars {
            return _set("align", align);
        }

        /**
         * Indicates the block indentation in pixels. Block indentation is applied to an entire block of text; that is, to all lines of the text. In contrast, normal indentation (TextFormat.indent) affects only the first line of each paragraph. If this property is null, the TextFormat object does not specify block indentation (block indentation is 0).
         *
         * @param blockIndent
         * @return
         */
        public function blockIndent(blockIndent:Number):TextFormatVars {
            return _set("blockIndent", blockIndent);
        }

        /**
         * Specifies whether the text is boldface. The default value is null, which means no boldface is used. If the value is true, then the text is boldface.
         *
         * @param bold
         * @return
         */
        public function bold(bold:Boolean):TextFormatVars {
            return _set("bold", bold);
        }

        /**
         * Indicates that the text is part of a bulleted list. In a bulleted list, each paragraph of text is indented. To the left of the first line of each paragraph, a bullet symbol is displayed. The default value is null, which means no bulleted list is used.
         *
         * @param bullet
         * @return
         */
        public function bullet(bullet:Boolean):TextFormatVars {
            return _set("bullet", bullet);
        }

        /**
         * Indicates the color of the text. A number containing three 8-bit RGB components; for example, 0xFF0000 is red, and 0x00FF00 is green. The default value is null, which means that Flash Player uses the color black (0x000000).
         *
         * @param color
         * @return
         */
        public function color(color:uint):TextFormatVars {
            return _set("color", color);
        }

        /**
         * The name of the font for text in this text format, as a string. The default value is null, which means that Flash Player uses Times New Roman font for the text.
         *
         * @param font
         * @return
         */
        public function font(font:*):TextFormatVars {

            var fontName:String = "";
            var fontClass:String = getClassName(font);

            if (fontClass == "String") {
                fontName = font;
            } else {
                fontName = font.fontName;
            }

            return _set("font", fontName);
        }

        /**
         * Indicates the indentation from the left margin to the first character in the paragraph. The default value is null, which indicates that no indentation is used.
         *
         * @param indent
         * @return
         */
        public function indent(indent:Number):TextFormatVars {
            return _set("indent", indent);
        }

        /**
         * Indicates whether text in this text format is italicized. The default value is null, which means no italics are used.
         *
         * @param italic
         * @return
         */
        public function italic(italic:Boolean):TextFormatVars {
            return _set("italic", italic);
        }

        /**
         * A Boolean value that indicates whether kerning is enabled (true) or disabled (false). Kerning adjusts the pixels between certain character pairs to improve readability, and should be used only when necessary, such as with headings in large fonts. Kerning is supported for embedded fonts only.
         *
         * Certain fonts such as Verdana and monospaced fonts, such as Courier New, do not support kerning.
         *
         * The default value is null, which means that kerning is not enabled.
         *
         * @param kerning
         * @return
         */
        public function kerning(kerning:Boolean):TextFormatVars {
            return _set("kerning", kerning);
        }

        /**
         * An integer representing the amount of vertical space (called leading) between lines. The default value is null, which indicates that the amount of leading used is 0.
         *
         * @param leading
         * @return
         */
        public function leading(leading:Number):TextFormatVars {
            return _set("leading", leading);
        }

        /**
         * The left margin of the paragraph, in pixels. The default value is null, which indicates that the left margin is 0 pixels.
         *
         * @param leftMargin
         * @return
         */
        public function leftMargin(leftMargin:Number):TextFormatVars {
            return _set("leftMargin", leftMargin);
        }

        /**
         * A number representing the amount of space that is uniformly distributed between all characters. The value specifies the number of pixels that are added to the advance after each character. The default value is null, which means that 0 pixels of letter spacing is used. You can use decimal values such as 1.75.
         *
         * @param letterSpacing
         * @return
         */
        public function letterSpacing(letterSpacing:Number):TextFormatVars {
            return _set("letterSpacing", letterSpacing);
        }

        /**
         * The right margin of the paragraph, in pixels. The default value is null, which indicates that the right margin is 0 pixels.
         *
         * @param rightMargin
         * @return
         */
        public function rightMargin(rightMargin:Number):TextFormatVars {
            return _set("rightMargin", rightMargin);
        }

        /**
         * The size in pixels of text in this text format. The default value is null, which means that a size of 12 is used.
         *
         * @param size
         * @return
         */
        public function size(size:Number):TextFormatVars {
            return _set("size", size);
        }

        /**
         * Specifies custom tab stops as an array of non-negative integers. Each tab stop is specified in pixels. If custom tab stops are not specified (null), the default tab stop is 4 (average character width).
         *
         * @param tabStops
         * @return
         */
        public function tabStops(tabStops:Array):TextFormatVars {
            return _set("tabStops", tabStops);
        }

        /**
         * Indicates the target window where the hyperlink is displayed. If the target window is an empty string, the text is displayed in the default target window _self. You can choose a custom name or one of the following four names: _self specifies the current frame in the current window, _blank specifies a new window, _parent specifies the parent of the current frame, and _top specifies the top-level frame in the current window. If the TextFormat.url property is an empty string or null, you can get or set this property, but the property will have no effect.
         *
         * @param target
         * @return
         */
        public function target(target:String):TextFormatVars {
            return _set("target", target);
        }

        /**
         * Indicates whether the text that uses this text format is underlined (true) or not (false). This underlining is similar to that produced by the <U> tag, but the latter is not true underlining, because it does not skip descenders correctly. The default value is null, which indicates that underlining is not used.
         *
         * @param underline
         * @return
         */
        public function underline(underline:Boolean):TextFormatVars {
            return _set("underline", underline);
        }

        /**
         * Indicates the target URL for the text in this text format. If the url property is an empty string, the text does not have a hyperlink. The default value is null, which indicates that the text does not have a hyperlink.
         *
         * Note: The text with the assigned text format must be set with the htmlText property for the hyperlink to work.
         *
         * @param bold
         * @return
         */
        public function url(url:String):TextFormatVars {
            return _set("url", url);
        }


        //---- GETTERS / SETTERS -------------------------------------------------------------------------------------------------------------

        /** The generic object populated by all of the method calls in the TweenLiteVars instance. This is the raw data that gets passed to the tween. **/
        public function get vars():TextFormat {

            return _format;
        }

        /** @private **/
        public function get isTextFormatVars():Boolean {
            return true;
        }
    }
}