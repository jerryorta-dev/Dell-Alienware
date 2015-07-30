package com.dpa.graphics
{
    import com.dpa.graphics.core.BitmapGrabber;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BitmapDivide extends BitmapGrabber
	{
		/**
		 * the sourece movieclip or sprite that will be cut into pieces
		 */
		private var _source:DisplayObject;
		
		/**
		 * Number of pieces per row
		 */
		private var _rowPieces:int;
		
		/**
		 * Number of pieces per column
		 */
		private var _columnPieces:int;
		
		public function BitmapDivide()
		{
			super();
			
		}
		
		/**
		 * <p>Divide the source display object into even rows and columns, and return each piece as a bitmap in a Vector array.</p>
		 * 
		 * @PARAM source = the display object to divide into pieces.<br>
		 * @PARAM rowPieces = number of divisions horizontally<br>
		 * @PARAM columnPieces = number of divisions vertically
		 */
		public static function divide(source:DisplayObject, rowPieces:int, columnPieces:int):Vector.<Bitmap>
		{
			var _rectWidth:Number = source.width / rowPieces;
			var _rectHeight:Number = source.height / columnPieces;
			var _totalPieces:Number = rowPieces * columnPieces;
			
			//Set up the vector array
			var bitmapVector:Vector.<Bitmap> = new Vector.<Bitmap>();
			
			//create the target rectangle
			var _targRect:Rectangle = new Rectangle(0, 0, _rectWidth, _rectHeight);
			
			//Let's grab image snapshots from Upper left, to bottom right,
			//We'll move the registration point of the targ rectangle (_regPoint) horizontally, then down.
			for (var i:Number = 0; i < _totalPieces; i++) {
				
				//If x value of the registration point is beyond the width of the target, move it back to 0.
				if (_targRect.x >= source.width) 
				{
					_targRect.x = 0;
					_targRect.y += _rectHeight;
				}
				
				var bmpData:BitmapData = grab(source, _targRect, true);
				var bmp:Bitmap = new Bitmap( bmpData, "auto", true );
				
				//Store into vectore
				bitmapVector.push(bmp);
				
				_targRect.x += _rectWidth;
			}
			
			
			return bitmapVector;
		}
	}
}