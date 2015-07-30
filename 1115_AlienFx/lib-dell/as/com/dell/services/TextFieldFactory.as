package com.dell.services
{
	import flash.display.MovieClip;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	/**
	 * 	
	 * 	@author John Tipton
	 *	@summary	This TextFieldFactory class allows one to pass in a stylesheet object, string and container MC - without having to know if the 
	 *						embedded font has all the glyphs.  If the font does not, it will render using a device font
	 */
	public class  TextFieldFactory 
	{
		private var _styleSheet:StyleSheet;
		
		private var _id:String;
		public function get id():String
		{
			return _id;
		}
		public function set id( val:String ):void
		{
			_id = id;
		}
		/*
		*		must pass in a valid stylesheet
		*/
		public function TextFieldFactory( stylesheet:StyleSheet = null )
		{
			if( stylesheet != null )
			{
				_styleSheet = stylesheet;
			}
			else
			{
				// not using a stylesheet
			}
		}
		
		/*
		*		basic test draw textfield function
		*/
		public function drawText( str:String, _container:MovieClip, xPos:Number=0, yPos:Number=0, w:Number=200, ml:String="false" ):void
		{
			var tf:TextField = new TextField();
			tf.x = xPos;
			tf.y = yPos;
			if( isNaN( w ) || w == 0 )
			{
				w = 200;
			}
			tf.width = w;
			if( ml == "true" )
			{
				tf.multiline = true;
			}
			
			if( _styleSheet != null )
			{
				tf.styleSheet = _styleSheet;
			}
			tf.selectable = false;
			
			// get the classname from HTML string
			var _className:String = getFontClassName( str );
			//trace( "drawText > _className: " + _className );
			
			// get the font-family from the _className
			var _fontName:String = _styleSheet.getStyle( "."+_className ).fontFamily;
			//trace( "drawText > _fontName: " + _fontName );
			
			if( _className != null && _fontName != null )
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
			
				if( _font.hasGlyphs( str ) )
				{
					
					tf.antiAliasType = AntiAliasType.ADVANCED;
					tf.embedFonts = true;
				}
				else
				{
					//trace( "Embedded font does not contain all the necessary chars.  using non-embedded version font?");
					var _fontSize:Number = ( _styleSheet.getStyle( "."+_className ).fontSize != undefined ) ? _styleSheet.getStyle( "."+_className ).fontSize : 12;
					var _fontColor:Number = ( _styleSheet.getStyle( "."+_className ).color != undefined ) ? _styleSheet.getStyle( "."+_className ).color : 0x000000;
					tf.styleSheet = null;
					var _tf:TextFormat = new TextFormat( "_sans", _fontSize, _fontColor );
					tf.defaultTextFormat = _tf;
				}
			}
			else
			{
				// there's no class name, so just use some default
				tf.styleSheet = null;
				var _tf2:TextFormat = new TextFormat( "_sans", 12 );
				tf.defaultTextFormat = _tf2;
			}
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.wordWrap = true;
			tf.htmlText = str;
			_container.addChild( tf );
			
			//trace( "tf.width: " + tf.width );
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