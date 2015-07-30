package com.dpa.interactive {
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
    import flash.display.LoaderInfo;
	
	/*
	 * TopLevel class
	 * have all document classes extend this
	 * class instead of Sprite or MovieClip to
	 * allow global stage and root access through
	 * TopLevel.stage and TopLevel.root
	 */
	public class TopLevel extends MovieClip {
		
		public static var _stage:Stage;
		public static var _root:DisplayObject;
        public static var _flashVars:Object;
			
		public function TopLevel() {
			if (this.stage){
				setupTopLevel();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, setupTopLevel);
			}
		}
		
		private function setupTopLevel(event:Event = null):void {
			if (event){
				removeEventListener(Event.ADDED_TO_STAGE, setupTopLevel);
			}
			TopLevel._stage = this.stage;
			TopLevel._root = root;

            stage.scaleMode = StageScaleMode.SHOW_ALL;// NO_SCALE
            stage.align = StageAlign.TOP_LEFT;

            TopLevel._flashVars = (_stage.loaderInfo != null) ? LoaderInfo(_stage.loaderInfo).parameters : {};
            init();
		}

        protected function init():void {

        }
	}
}