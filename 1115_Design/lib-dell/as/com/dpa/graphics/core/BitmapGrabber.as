package com.dpa.graphics.core
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BitmapGrabber
	{
		public function BitmapGrabber()
		{
		}
		
		public static function grab( source:DisplayObject, rect:Rectangle, smoothing:Boolean ): BitmapData
		{
			
			if( !source is IBitmapDrawable )
			{
				throw new Error( "Cannot create BitmapData.  Source must implement IBitmapDrawable" );
			}
			
			var bmpData1:BitmapData = new BitmapData( source.width, source.height, true, 0x00000000 );
			var bmpData2:BitmapData = new BitmapData( rect.width, rect.height, true, 0x00000000 );
			
			bmpData1.draw( source, null, null, null, null, smoothing );
			bmpData2.copyPixels( bmpData1, rect, new Point( 0, 0 ) );
			
			bmpData1.dispose();
			
			return bmpData2;
		}
	}
}