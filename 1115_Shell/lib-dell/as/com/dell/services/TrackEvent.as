package com.dell.services
{
	import flash.events.Event;
	
	public class TrackEvent extends Event
	{
		public static const TRACK_EVENT:String = "trackEvent";
		
		public function TrackEvent( type:String, metricID:String, clickType:String = "button" )
		{
			super( type, true, false );
			_eventName = type;
			_metricID = metricID;
			_clickType = clickType;
		}
		
		private var _eventName:String;	// event name
		public final function get eventName():String 
		{
			return _eventName;
		}
		
		private var _metricID:String;	// button/link name
		public final function get metricID():String 
		{
			return _metricID;
		}
		
		private var _clickType:String;	// 
		public final function get clickType():String 
		{
			return _clickType;
		}
		
		override public function clone():Event 
		{
			return new TrackEvent( _eventName, _metricID, clickType  );
		}
	}
}