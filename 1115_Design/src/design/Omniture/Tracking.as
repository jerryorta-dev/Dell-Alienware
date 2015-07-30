package design.Omniture
{

	import com.dell.services.PathManager;
	import com.dell.services.TrackEvent;
import com.demonsters.debugger.MonsterDebugger;
import com.omniture.AppMeasurement
	
	public class Tracking extends Main_1115_Design
	{
		
		
		public function Tracking()
		{
		}
		
			
		
		public static function configActionSource():void
		{                             
			/* Specify the Report Suite ID(s) to track here */
			s.account = "dellglobalonline";// (development: dellglobalonlinedev)
			
			/* You may add or alter any code config here */
			s.pageName = PathManager.country + ":" + PathManager.language + ":" + PathManager.segment + ":" + PathManager.customerset + ":" + "flash" + ":" + site;
			
			s.charSet = "UTF-8";
			s.currencyCode = "USD";
			
			/* Turn on and configure ClickMap tracking here */
			s.trackClickMap = true;
			
			/* Turn on and configure debugging here */
			s.debugTracking = true;
			s.trackLocal = true;
			
			/* WARNING: Changing any of the below variables will cause drastic changes
			to how your visitor data is collected.  Changes should only be made
			when instructed to do so by your account manager.*/
			s.dc = "112";
			s.trackingServer="nsm.dell.com";
			s.trackingServerSecure="sm.dell.com";
			
			s.prop49="?c=" + PathManager.country + "&l=" + PathManager.language + "&s=" + PathManager.segment + "&cs=" + PathManager.customerset;
			
			s.visitorNamespace = "dell";
			
		}
		
		public static function trackMetrics( event:TrackEvent ):void
		{
			
			var _clickType:String = event.clickType;
			var _metricID:String = ( event.metricID != "" ) ? event.metricID : "all";
			s.prop4 = PathManager.country + ":" + PathManager.language + ":" + PathManager.segment + ":" + PathManager.customerset + ":" +  "flash" + ":" + site + ":" + _clickType + ":" + _metricID;
			s.track();
			/*
			trace("");
			trace("s.prop4: "+s.prop4);
			trace("");
            */

            MonsterDebugger.trace(s, "s.prop4: "+s.prop4, "GDC", "Tracking", 0x990000);

			
//			trackingDebug.text += "\n"+s.prop4;
		}
		
	}
}