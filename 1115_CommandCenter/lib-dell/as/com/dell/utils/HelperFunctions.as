package com.dell.utils
{
	import flash.geom.Point;
	import flash.display.DisplayObject;
	
	public class HelperFunctions
	{
		/*
		*	Return global position of displayObject
		*/
		static public function getGlobalPosition( displayObject:DisplayObject ):Point
  	{
  		var m:Point = new Point(displayObject.x, displayObject.y);
  		//Alert.show( "point x: " + m.x + " point y: " + m.y );
			var ml:Point = displayObject.localToGlobal(m);
			return ml;
  	}
  	
  	/**
		 * 
		 * @param val
		 * @return 
		 * 
		 */		
		public static function convertToBoolean( val:String ):Boolean
		{
			if( val.toLowerCase() == "true" )
			{
				return true
			}
			else
			{
				return false;	
			}
		}
		
		/**
		 * 
		 * @param langXML
		 * @param lang
		 * @return 
		 * 
		 */		
		static public function getFontEmbed( langXML:XML, lang:String ):Boolean
		{
			var langXMLList:XMLList = langXML.language;
			for each( var item:XML in langXMLList )
			{
				var attr:String = item.@id;
				if( lang == attr )
				{
					if( item.@devicefont == "true" )
					{
						return true;
					}
					else
					{
						return false;
					}
				}
			}		
			return false;
		}
		
		/*
		Date helper function
		*/
		static public function stringToDate( strDate:String ):Date
		{
			var arrRaw:Array = strDate.split( "/" );
			
			var day:Number = arrRaw[1];
			var month:Number = arrRaw[0]-1;
			var year:Number = arrRaw[2];
			var theDate:Date = new Date();
			var today:Number = theDate.valueOf();
			//trace( "today: " +  today );
			theDate.setFullYear( year, month, day); 
			theDate.setHours( 0 );
			theDate.setMinutes( 0 );
			theDate.setSeconds( 0 );
			theDate.setMilliseconds( 0 );
			//trace( "then: " + theDate.valueOf() );
			//trace( "diff: " + ( today - theDate.valueOf() )/1000 + " seconds" );
			return theDate;
		}
	  	

	}
}