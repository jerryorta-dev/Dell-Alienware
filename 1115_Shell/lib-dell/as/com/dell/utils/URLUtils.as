package com.dell.utils
{
	import mx.utils.URLUtil;
	
	public class URLUtils
	{
		public static var basePath:String;
		
		public function URLUtils()
		{
			//TODO: implement function
		}
		
		public static function getServerDomain( strVal:String ):String
		{
			var _val:String;
			
			if( URLUtil.isHttpURL(strVal ) )
			{
				_val = "http://";
			}
			else if( URLUtil.isHttpsURL(strVal ) )
			{
				_val = "https://";
			}
			_val += URLUtil.getServerName( strVal );
			return _val;
		}
		
		public static function getQualifiedPath( strVal:String ):String
		{
			var _temp:String = strVal;
			var _path:String = _temp.substr( 0, _temp.lastIndexOf("/") + 1 ); 
			return _path;

		}
	}
}