/*
	@updated	1.Jul.2008	Adding locale vars to PathManager - not sure if _mc is where it should go
*/
package com.dell.services
{
	import com.abdulqabiz.utils.QueryString;
	import com.dell.utils.HelperFunctions;
	
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;

	public class PathManager	
	{
        public static var assetFolder:String = "assets";
        public static var configFolder:String = "config";

        public static var baseURL:String;
        //public static var containerURL:String; // deprecated in favor of the QueryString class
		public static var fontPath:String;
		public static var cssPath:String;
		public static var imagePath:String;
		public static var swfPath:String;
		public static var videoPath:String;
		public static var language:String;
		public static var country:String;
		public static var segment:String;
		public static var region:String;
		public static var customerset:String;
		public static var xmlPath:String;
		public static var projectID:String;
		public static var useDeviceFonts:Boolean = true;
		public static var embedCode:String;
		public static var ooid:String;
		public static var labels:*;
		public static var qs:QueryString = new QueryString();
		
		public static function init( _li:LoaderInfo ):void
		{
			// get the file name
			var lastSlashIdx:Number = _li.url.lastIndexOf( "/" );
			//trace( "lastSlashIdx: " + lastSlashIdx );
			var mainFile:String = _li.url.slice( lastSlashIdx + 1, _li.url.length );
			//trace( "mainFile: " + mainFile );
			
			PathManager.baseURL = ( _li.parameters.basePath != null ) ? _li.parameters.basePath : _li.url.slice(0,_li.url.indexOf( mainFile ));
			PathManager.fontPath = ( _li.parameters.fontPath != null ) ? PathManager.baseURL + _li.parameters.fontPath : PathManager.baseURL + "font/";
			PathManager.xmlPath = ( _li.parameters.xmlPath != null ) ? PathManager.baseURL + _li.parameters.xmlPath : PathManager.baseURL + "xml/";
			PathManager.cssPath = ( _li.parameters.cssPath != null ) ? PathManager.baseURL + _li.parameters.cssPath : PathManager.baseURL + "css/";
			PathManager.imagePath = ( _li.parameters.imagePath != null ) ? PathManager.baseURL + _li.parameters.imagePath : PathManager.baseURL + "image/";
			PathManager.videoPath = ( _li.parameters.videoPath != null ) ? PathManager.baseURL + _li.parameters.videoPath : PathManager.baseURL + "video/";
			//PathManager.containerURL = ( _li.parameters.containerURL != null ) ? _li.parameters.containerURL : PathManager.baseURL;
			
			// language
			if( qs.parameters.l != null )
			{
				PathManager.language = qs.parameters.l;
			}
			else if( _li.parameters.language != null )
			{
				PathManager.language = _li.parameters.language;
			}
			else if( _li.parameters.l != null )
			{
				PathManager.language = _li.parameters.l;
			}
			else
			{
				PathManager.language = "en";
			}
			// lowercase it
			PathManager.language = PathManager.language.toLowerCase();
			
			// country
			if( qs.parameters.c != null )
			{
				PathManager.country = qs.parameters.c;
			}
			else if( _li.parameters.country != null )
			{
				PathManager.country = _li.parameters.country;
			}
			else if( _li.parameters.c != null )
			{
				PathManager.country = _li.parameters.c;
			}
			else
			{
				PathManager.country = "us";
			}
			// lowercase it
			PathManager.country = PathManager.country.toLowerCase();
			
			// segment
			if( qs.parameters.s != null )
			{
				PathManager.segment = qs.parameters.s;
			}
			else if( _li.parameters.segment != null )
			{
				PathManager.segment = _li.parameters.segment;
			}
			else if( _li.parameters.s != null )
			{
				PathManager.segment = _li.parameters.s;
			}
			else
			{
				PathManager.segment = "dhs";
			}
			// lowercase it
			PathManager.segment = PathManager.segment.toLowerCase();
			
			// customer set
			if( qs.parameters.cs != null )
			{
				PathManager.customerset = qs.parameters.cs;
			}
			else if( _li.parameters.customerset != null )
			{
				PathManager.customerset = _li.parameters.customerset;
			}
			else if( _li.parameters.cs != null )
			{
				PathManager.customerset = _li.parameters.cs;
			}
			else
			{
				PathManager.customerset = "19";
			}
			// lowercase it
			PathManager.customerset = PathManager.customerset.toLowerCase();
			
			// get the productID from the PathManager.baseURL
			var __lastSlashIdx:Number = PathManager.baseURL.lastIndexOf( "/" );
			var __tempPath:String = PathManager.baseURL.slice( 0, __lastSlashIdx );
			var __lastSlashIdx2:Number = __tempPath.lastIndexOf( "/" );
			PathManager.projectID = PathManager.baseURL.slice( __lastSlashIdx2+1, __lastSlashIdx );
			//trace( "PathManager > init > PathManager.projectID: " + PathManager.projectID );
			
			if( qs.parameters.embedcode != null )
			{
				PathManager.embedCode = qs.parameters.embedcode;
			}
			else if( _li.parameters.embedcode != null )
			{
				PathManager.embedCode = _li.parameters.embedcode
			}
			else
			{
				/*
				Get the hash, if any
				*/
				var hashidx:Number = qs.url.indexOf( "#" );
				var afterhashStr:String = qs.url.substring( hashidx + 1, qs.url.length );
				var equalidx:Number = afterhashStr.indexOf( "=" );
				var hashID:String = afterhashStr.substr( 0, equalidx );
				var value:String = afterhashStr.substr( equalidx + 1, afterhashStr.length );
				if( hashID.toLowerCase() == "ooid" )
				{
					PathManager.embedCode = value;
				}
			}
			
			/*
				Check for category labels
			*/
			if( qs.parameters.label != null )
			{
				PathManager.labels = qs.parameters.label;
			}
			else if( _li.parameters.label != null )
			{
				PathManager.labels = _li.parameters.label;
			}
		
			
				
		}
		
		public static function GetQSParam( param:String ):String
		{
			var queryString:QueryString = new QueryString();
			return queryString.parameters[ param ];
		}


        public static function getLocalizedXML():String {
            var language_country:String = PathManager.language + "_" + PathManager.country;
            var getBasePath:String = String(PathManager.xmlPath).replace("/xml/","/") + PathManager.assetFolder;
            return getBasePath  + "/xml/" + language_country + ".xml";
        }

        public static function getConfigXML(_name:String):String {
            var getBasePath:String = String(PathManager.xmlPath).replace("/xml/","/") + PathManager.assetFolder;
            return getBasePath  + "/xml/" + PathManager.configFolder + "/" + _name + ".xml";
        }
		
	}
}