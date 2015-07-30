/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 9:35 AM
 * To change this template use File | Settings | File Templates.
 */
package video.uiFactoryPattern.concrete {
import com.dpa.text.TextUtil;
import com.dpa.text.params.TextFormatVars;

import flash.text.AntiAliasType;
import flash.text.Font;
import flash.text.GridFitType;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import video.uiFactoryPattern.abstractWidgets.AbstractTextFieldWidget;


public class ConcreteTitleTextFieldWidget extends AbstractTextFieldWidget {

    override public function drawWidget(vars:Object = null):void {
        this.name = vars.name;


        //***********************************************************************
        //***********************************************************************
        //***********************************************************************
        //VARS
        var _Copy:String = vars.htmlText.title;
        var _fontName:String, _className:String;
        _fontName = _className = "PillAlt600mg-Regular";

        //***********************************************************************
        //***********************************************************************
        //***********************************************************************
        //NO FONT
        var _noFontTextFormatVars:TextFormatVars = new TextFormatVars();
        _noFontTextFormatVars.color(0xffffff);
        _noFontTextFormatVars.size(14);
        _noFontTextFormatVars.font("_sans");
        _noFontTextFormatVars.align(TextFormatAlign.LEFT);
        var _noFontTextFormat:TextFormat = TextUtil.createTextFormat(_noFontTextFormatVars.vars);

        //***********************************************************************
        //***********************************************************************
        //***********************************************************************
        //EMBEDDED FONT
        var _embeddedFontVARS:TextFormatVars = new TextFormatVars();
        _embeddedFontVARS.color(0xffffff);
        _embeddedFontVARS.size(14);
        _embeddedFontVARS.font(_fontName);
        _embeddedFontVARS.align(TextFormatAlign.LEFT);
        var _embeddedFontFormat:TextFormat = TextUtil.createTextFormat(_embeddedFontVARS.vars);

        //***********************************************************************
        //***********************************************************************
        //***********************************************************************
        //STYLE SHEET
//        var defaultStyleObj:Object = new Object();
//        defaultStyleObj.fontFamily = "PillAlt600mg-Medium";
//
//        var _styleSheet:StyleSheet = new StyleSheet();
//        _styleSheet.setStyle("p", {fontFamily:"PillAlt600mg-Medium", fontSize:'14',color:'#990200', fontWeight:'normal', textAlign:"left"});
//        _styleSheet.setStyle(".defaultStyle", defaultStyleObj);

        //***********************************************************************
        //***********************************************************************
        //***********************************************************************
        //CONFIGS
        this.width = 142;
        this.multiline = true;

//        this.styleSheet = _styleSheet;
        this.selectable = false;

        // get the classname from HTML string
//        var _className:String = getFontClassName( _Copy );
//        trace( "drawText > _className: " + _className );

        // get the font-family from the _className
//        var _fontName:String = _styleSheet.getStyle( "."+_className ).fontFamily;
//        trace( "drawText > _fontName: " + _fontName );

//        if( _className != null && _fontName != null )
        if( _fontName != null )
        {
            // create a Font reference
            var _font:Font;

            var _fonts:Array = Font.enumerateFonts();

            for( var c:Number=0; c < _fonts.length; c++ )
            {
                if( _fonts[c].fontName == _fontName )
                {
                    _font = _fonts[c];
                    break;
                }
            }

            if( _font.hasGlyphs( vars.htmlText.title ) )
            {
//                trace("embed fonts");
                this.antiAliasType = AntiAliasType.ADVANCED;
                this.defaultTextFormat = _embeddedFontFormat;
                this.embedFonts = true;
            }
            else
            {
//                trace("no font embed");
                //trace( "Embedded font does not contain all the necessary chars.  using non-embedded version font?");
                this.styleSheet = null;
                this.defaultTextFormat = _noFontTextFormat;
            }
        }
        else
        {
//            trace("using embedded fonts")
            // there's no class name, so just use some default
            this.styleSheet = null;
//            var _tf2:TextFormat = new TextFormat( "_sans", 12 );
            this.antiAliasType = AntiAliasType.ADVANCED;
            this.defaultTextFormat = _embeddedFontFormat;
        }
        this.autoSize = TextFieldAutoSize.LEFT;
        this.wordWrap = true;
        this.htmlText =  _Copy;
//        trace(this.htmlText);

        //END FOR LOCALIZATION
        //***********************************************
        //***********************************************
        //***********************************************

    }

    /*
     *		get the "class" from an HTML string, if one exists
     */
    private function getFontClassName( str:String ):String
    {
        var _term:String = "class=";
        var _classIdx:Number = str.indexOf( _term );
        if( _classIdx > - 1 )
        {
            var _searchTermLength:Number =_term.length;
            var _quote:String = str.slice( _classIdx + _searchTermLength, _classIdx + _searchTermLength + 1 );
            var _lastQuoteIdx:Number = str.slice( _classIdx + _searchTermLength + 1, str.length ).indexOf( _quote );
            var _className:String = str.slice( _classIdx + _searchTermLength + 1, _classIdx + _searchTermLength + 1 + _lastQuoteIdx );
            //trace( "getFontClassName > idx: " + _classIdx );
            //trace( "getFontClassName > _quote: " + _quote );
            //trace( "getFontClassName > _lastQuoteIdx: " + _lastQuoteIdx );
            //trace( "getFontClassName > _className: " + _className );
            return _className;
        }
        else
        {
            return null;
        }
    }
}
}
