package
{
	import com.dell.DocumentClass;
	import com.dell.alienFx.ConfigText;
	import com.dell.alienFx.GlobalAnim;
	import com.dell.services.PathManager;
	import com.dell.services.TrackEvent;
	import com.dpa.utils.displayObject.getLoaderInfo;
	import com.dpa.utils.object.addHandCurserNoChildren;
	import com.greensock.TimelineMax;
	import com.greensock.TweenAlign;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.XMLLoader;
	import com.greensock.plugins.FramePlugin;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.omniture.AppMeasurement;
	import com.demonsters.debugger.MonsterDebugger;

	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.UncaughtErrorEvent;
	import flash.system.Capabilities;
	import flash.ui.Mouse;
	
	import shell.Omniture.Tracking;
	import shell.navigation.CreateNavSystem;
	import shell.progressBar.LoaderProgress;
	import shell.uiGraphics.CTAIntro;
	import shell.uiGraphics.Containers;

	
	[SWF(width="965", height="500")]
	public class Main_1115_Shell extends DocumentClass
	{
		
		[Embed(source="/assets/fonts/PillAlt600mg-Medium.ttf",
            fontName="PillAlt600mg-Medium",
            fontFamily="PillAlt600mg-Medium",
            mimeType="application/x-font",
            fontWeight="normal",
            fontStyle="normal",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
		private var embeddedFont1:Class;
		
		[Embed(source="/assets/fonts/PillAlt600mg-Bold.ttf",
            fontName="PillAlt600mg-Bold",
            fontFamily="PillAlt600mg-Bold",
            mimeType="application/x-font",
            fontWeight="normal",
            fontStyle="normal",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
		private var embeddedFont2:Class;
		
		[Embed(source="/assets/fonts/PillAlt600mg-Regular.ttf",
            fontName="PillAlt600mg-Regular",
            fontFamily="PillAlt600mg-Regular",
            mimeType="application/x-font",
            fontWeight="normal",
            fontStyle="normal",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
		private var embeddedFont3:Class;
		
		private var _shellData:Vector.<Object>;
		private var _ctaObj:Object;
		//    private var _loader:SWFLoader;
		
		private var queue:LoaderMax;
		private var designSWFLoader:SWFLoader;
		private var afxSWFLoader:SWFLoader;
		private var ccSWFLoader:SWFLoader;
		private var gallerySWFLoader:SWFLoader;
		private var videoSWFLoader:SWFLoader;
		
		private var tertiaryLoader:LoaderMax;
		
		private var navSystem:CreateNavSystem;
		public var designContainer:MovieClip;
		public var alienFxContainer:MovieClip;
		public var commandCenterContainer:MovieClip;
		public var galleryContainer:MovieClip;
		public var videoContainer:MovieClip;
		
		private var vars:Object;
		
		private var mcDesign:MovieClip;
		private var mcAlienFx:MovieClip;
		private var mcVideo:MovieClip;
		private var mcGallery:MovieClip;
		private var mcCommandCenter:MovieClip;
		private var ctaBtn:CTAIntro;
		
		
		//INTRO ANIMATION
		private var _loaderProgress:LoaderProgress;
		private var awFamily:AWFamily;
		private var led:LED;
		private var transitionBg:Sprite;
		private var introAnim:MovieClip;
		
		private var itl:TimelineMax;
		
		public static var s:AppMeasurement;
		public static var site:String = "AlienWare-1115";  //product name, this is used in tracking, so it is important.
		


		public function Main_1115_Shell()
		{
			
			trace("test");
		}
		private function initHandler(event:LoaderEvent):void {
			var mc:MovieClip = new MovieClip();
			
		}
		
		
		
		override protected function init():void {
			super.init();
			
			var bg:Sprite = new Sprite();
			
			bg.graphics.beginFill(0x000000, 1);
			bg.graphics.drawRect(0, 0, 965, 500);
			bg.graphics.endFill();
			bg.x = bg.y = 0;
			addChild(bg);
			
			MonsterDebugger.initialize(this);
			MonsterDebugger.trace(this, "GDC", Capabilities.version, "playerVersion");
			
			this.vars = {};
			
			_shellData = new Vector.<Object>();
			
			PathManager.init( getLoaderInfo(this) );
			
			s = new AppMeasurement();
			Tracking.configActionSource();
			initTracking();
			
			ConfigText.init();
			TweenPlugin.activate([TintPlugin, FramePlugin]);
			LoaderMax.activate([SWFLoader]);
			trace(PathManager.baseURL + "Main_1115_Design.swf");
			
			MonsterDebugger.trace(this, PathManager.baseURL + "Main_1115_Design.swf");
			
			commandCenterContainer = Containers.createModuleContainer("commandCenter");
			addChild(commandCenterContainer);
			commandCenterContainer.alpha = 0;
			commandCenterContainer.visible = false;
			
			galleryContainer = Containers.createModuleContainer("gallery");
			addChild(galleryContainer);
			galleryContainer.alpha = 0;
			galleryContainer.visible = false;
			
			videoContainer = Containers.createModuleContainer("video");
			addChild(videoContainer);
			videoContainer.alpha = 0;
			videoContainer.visible = false;
			
			designContainer = Containers.createModuleContainer("design");
			addChild(designContainer);
			designContainer.alpha = 0;
			designContainer.visible = false;
			
			alienFxContainer = Containers.createModuleContainer("exploreAlienFx");
			addChild(alienFxContainer);
			alienFxContainer.alpha = 0;
			alienFxContainer.visible = false;
			
			
			//***************************************************************************************************
			//***************************************************************************************************
			//***************************************************************************************************
			//INTRO ASSETS
			_loaderProgress = new LoaderProgress();
			_loaderProgress.visible = false;
			_loaderProgress.alpha = 0;
			_loaderProgress.x = _loaderProgress.y = 0;
			addChild(_loaderProgress);
			
			awFamily = new AWFamily();
			awFamily.x = 0;
			awFamily.y = 0;
			awFamily.visible = false;
			awFamily.alpha = 0;
			addChild(awFamily);
			
			
			introAnim = new introAnimation();
			introAnim.gotoAndStop(1)
			introAnim.x = introAnim.y = 0;
			addChild(introAnim);
			
			transitionBg = new Sprite();
			transitionBg.graphics.beginFill(0x34fd39, 1);
			transitionBg.graphics.drawRect(0, 0, 965, 500);
			transitionBg.graphics.endFill();
			transitionBg.alpha = 0;
			transitionBg.visible = false;
			addChild(transitionBg);
			
			
			//***************************************************************************************************
			//***************************************************************************************************
			//***************************************************************************************************
			//LOGO
			var logo:MovieClip = new shell_menu_icons()["logo"];
			logo.x = 800;
			logo.y = 12;
			addChild(logo);
			
			
			
			initApp();
		}
		
		public static function initTracking():void
		{
			
			
			
			var tEvt:TrackEvent = new TrackEvent("shell","initialLoad");
			Tracking.trackMetrics(tEvt);
			
			var tEvt2:TrackEvent = new TrackEvent("playerVersion",Capabilities.version.replace(" ","-"));
			Tracking.trackMetrics(tEvt2);
			
		}
		
		
		
		private function initApp():void {
			
			queue = new LoaderMax({name:"mainQueue", onComplete:playIntro});
			queue.append( new XMLLoader(PathManager.getConfigXML('shell-config'), {name:"shellConfig"}) );
			queue.append( new XMLLoader(PathManager.getLocalizedXML(), {name:"shellCopy"}) );
			queue.load();
		}
		
		//***************************************************************************************************
		//***************************************************************************************************
		//***************************************************************************************************
		//INTRO ASSETS
		private function playIntro(event:LoaderEvent = null):void {
			
			var _intro:XMLList = (LoaderMax.getContent("shellCopy") as XML).hero;
			
			var _introData:Object = {};
			_introData.xmlNode = _intro;
			
			
			var ctaParams:Object = {
				width:107,
				height:20,
				radiusRect:18,
				fillColor:0x34fd39,
				xmlNode:_intro,
				name:"introCTA"
			};
			
			ctaBtn = new CTAIntro(ctaParams);
			ctaBtn.x = 965/2;
			ctaBtn.y = 217;
			ctaBtn.alpha = 0;
			addChild(ctaBtn);
			
			_loaderProgress.addText(_intro);
			
			itl = new TimelineMax({paused:true, onComplete:onIntroComplete});
			itl.insertMultiple([
				TweenLite.to(introAnim, 2.3, {frame:57}),
				TweenMax.to(transitionBg,.05, {delay:2.3,autoAlpha:1})
			],0,TweenAlign.NORMAL, 0);
			
			itl.appendMultiple([
				TweenLite.to(introAnim,.01, {visible:false}),
				TweenMax.to(_loaderProgress, .01, {autoAlpha:1}),
				TweenMax.to(transitionBg,.05, {autoAlpha:0}),
			], 0, TweenAlign.NORMAL, 0);
			itl.append(TweenMax.to(awFamily,.4, {autoAlpha:1}));
			itl.append(TweenLite.to(_loaderProgress,.01, {animateOn:true}));
			itl.append(TweenLite.to(ctaBtn,.01, {delay:1.35,alpha:1}));
			
			itl.play();
		}
		
		
		private function onIntroComplete():void {
			stage.addEventListener(MouseEvent.MOUSE_DOWN, showLoader, false, 0, true);
			addHandCurserNoChildren(ctaBtn);
			
			
			
		}
		
		public function showLoader(event:MouseEvent = null):void {
			var tEvt:TrackEvent = new TrackEvent('button','TakeCommand');
			Tracking.trackMetrics(tEvt);
			
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, showLoader);
			TweenMax.to(awFamily,.01, {autoAlpha:0, overwrite:true});
			//        TweenMax.to(ctaBtn, GlobalAnim.TRANSISITION, {autoAlpha:0});
			
			TweenMax.to(ctaBtn,.01, {visible:false});
			TweenMax.to(ctaBtn,.01, {delay:.05, visible:true});
			TweenMax.to(ctaBtn,.01, {delay:.1, visible:false});
			TweenMax.to(ctaBtn,.01, {delay:.15, visible:true});
			TweenMax.to(ctaBtn,.01, {delay:.2, visible:false});
			
			TweenLite.delayedCall(.2, parseData);
		}
		
		
		
		private function parseData(event:LoaderEvent = null):void {
			_loaderProgress.show();
			removeChild(ctaBtn);
			itl.kill();
			itl = null;
			removeChild(transitionBg);
			removeChild(awFamily);
			removeChild(introAnim);
			
			
			var _nav:XMLList = (LoaderMax.getContent("shellConfig") as XML).shell.nav.item;
			
			var yPos:Number = 0;
			var stagger:Number = 74;
			
			for each (var _item:XML in _nav) {
				var item:Object = {};
				
				item.icon = _item.@icon;
				item.type = "moduleItem";
				item.stateName = _item.@stateName;
				item.initState = _item.@initState;
				item.name = _item.@name;
				item.yPos = yPos;
				
				yPos += stagger;
				
				vars[_item.@name] = item;
				_shellData.push(item);
			}
			
			var _copy:XMLList = (LoaderMax.getContent("shellCopy") as XML).shell.nav.item;
			
			var counter:int = 0;
			
			for each (var _copyItem:XML in _copy) {
				_shellData[counter].htmlText = _copyItem;
				counter++;
			}
			
			vars.design.htmlText = _shellData[0].htmlText;
			vars.commandCenter.htmlText = _shellData[1].htmlText;
			vars.exploreAlienFx.htmlText = _shellData[2].htmlText;
			vars.gallery.htmlText = _shellData[3].htmlText;
			vars.video.htmlText = _shellData[4].htmlText;
			
			_ctaObj = {};
			var btnBuyNowConfigData:XMLList = (LoaderMax.getContent("shellConfig") as XML).shell.buttons;
			_ctaObj.url = btnBuyNowConfigData.buyNow.@url;
			_ctaObj.name = btnBuyNowConfigData.buyNow.@name;
			_ctaObj.icon = btnBuyNowConfigData.buyNow.@icon;
			_ctaObj.state = btnBuyNowConfigData.buyNow.@state;
			
			var btnBuyNowCopyData:XMLList = (LoaderMax.getContent("shellCopy") as XML).shell.buttons.buyNow;
			_ctaObj.htmlText = btnBuyNowCopyData.title;
			_ctaObj.type = "buyNow";
			
			buildShellNavUi();
		}
		
		
		
		
		private function buildShellNavUi():void {
			
			navSystem = new CreateNavSystem(_shellData, this.loadSWF);
			navSystem.x = 10;
			navSystem.y = 46;
			addChild(navSystem);
			
			/*
			var cta:CreateShellCTA = new CreateShellCTA(_ctaObj);
			cta.x = 10;
			cta.y = 455;
			addChild(cta);
			*/
			
			/* designLM = new LoaderMax({name:"dswf",auditSize:false, onComplete:onDesignLoadComplete, onProgress:onDesignProgress, estimatedBytes:12183});
			designLM.append(new SWFLoader(PathManager.baseURL + "Main_1115_Design.swf", {name:"dswf",auditSize:false, onComplete:onDesignLoadComplete, onProgress:onDesignProgress, estimatedBytes:15183}));
			designLM.getContent("dswf").x =  designLM.getContent("dswf").y = 0;
			designContainer.addChild(designLM.getContent("dswf"));
			designLM.load();
			*/
			designSWFLoader = new SWFLoader(PathManager.baseURL + "Main_1115_Design.swf", {name:"dswf",auditSize:false, onComplete:onDesignLoadComplete, onProgress:onDesignProgress, estimatedBytes:12183});
			designSWFLoader.content.x = designSWFLoader.content.y = 0;
			designContainer.addChild( designSWFLoader.content );
			designSWFLoader.autoDispose = true;
			designSWFLoader.load();
			
			ccSWFLoader = LoaderMax.getLoader("commandCenter");
			ccSWFLoader = new SWFLoader(PathManager.baseURL + "Main_1115_CommandCenter.swf", {onComplete:onCommandCenterComplete, onProgress:ccLoadProgress});
			ccSWFLoader.autoDispose = true;
			commandCenterContainer.addChild( ccSWFLoader.content );
			
			afxSWFLoader = new SWFLoader(PathManager.baseURL + "Main_1115_AlienFx.swf", {onComplete:onAFXLoadComplete, onProgress:afxLoadProgress});
			afxSWFLoader.autoDispose = true;
			alienFxContainer.addChild( afxSWFLoader.content );
			
			gallerySWFLoader = new SWFLoader(PathManager.baseURL + "Main_1115_Gallery.swf", {onComplete:onGalleryComplete, onProgress:galleryLoadProgress});
			gallerySWFLoader.autoDispose = true;
			galleryContainer.addChild( gallerySWFLoader.content );
			
			videoSWFLoader = new SWFLoader(PathManager.baseURL + "Main_1115_Video.swf", {onComplete:onVideoComplete, onProgress:videoLoadProgress});
			videoSWFLoader.autoDispose = true;
			videoContainer.addChild( videoSWFLoader.content );
		}
		
		
		private var designLoadCache:Number = 0;
		private function onDesignProgress(event:LoaderEvent):void {
			var currentProgress:Number = event.target.progress *.5;
			if (!designIsLoaded && designLoadCache < currentProgress ) {
				designLoadCache = currentProgress;
				_loaderProgress.progress(currentProgress);
			}
		}
		
		private var ccLoadCache:Number = 0;
		private function ccLoadProgress(event:LoaderEvent):void {
			var currentProgress:Number = event.target.progress;
			if (!ccIsLoaded && ccLoadCache < currentProgress ) {
				ccLoadCache = currentProgress;
				_loaderProgress.progress(currentProgress);
			}
		}
		
		private var afxLoadCache:Number = 0;
		private function afxLoadProgress(event:LoaderEvent):void {
			var currentProgress:Number = event.target.progress;
			if (!afxIsLoaded && afxLoadCache < currentProgress ) {
				afxLoadCache = currentProgress;
				_loaderProgress.progress(currentProgress);
			}
		}
		
		private var galleryLoadCache:Number = 0;
		private function galleryLoadProgress(event:LoaderEvent):void {
			var currentProgress:Number = event.target.progress;
			if (!galleryIsLoaded && galleryLoadCache < currentProgress ) {
				galleryLoadCache = currentProgress;
				_loaderProgress.progress(currentProgress);
			}
		}
		
		private var videoLoadCache:Number = 0;
		private function videoLoadProgress(event:LoaderEvent):void {
			var currentProgress:Number = event.target.progress;
			if (!videoIsLoaded && videoLoadCache < currentProgress ) {
				videoLoadCache = currentProgress;
				_loaderProgress.progress(currentProgress);
			}
		}
		
		
		private function loadSWF(name:String):void {
			
			
			if (name === "design") {
				
				
			} else if (name === "commandCenter") {
				if (!ccIsLoaded) {
					ccSWFLoader.load();
					_loaderProgress.animateOn();
				} else {
					_loaderProgress.visible = false;
				}
			} else if (name === "exploreAlienFx") {
				if (!afxIsLoaded) {
					afxSWFLoader.load();
					_loaderProgress.animateOn();
				} else {
					_loaderProgress.visible = false;
				}
			} else if (name === "gallery") {
				if (!galleryIsLoaded) {
					gallerySWFLoader.load();
					_loaderProgress.animateOn();
				} else {
					_loaderProgress.visible = false;
				}
			} else if (name === "video") {
				if (!videoIsLoaded) {
					videoSWFLoader.load();
					_loaderProgress.animateOn();
				} else {
					_loaderProgress.visible = false;
				}
			} else {
				if (!videoIsLoaded) {
					videoSWFLoader.unload();
					_loaderProgress.animateOff();
				} else {
					_loaderProgress.visible = false;
				}
			}
		}
		
		
		private var designIsLoaded:Boolean = false;
		private var ccIsLoaded:Boolean = false;
		private var afxIsLoaded:Boolean = false;
		private var galleryIsLoaded:Boolean = false;
		private var videoIsLoaded:Boolean = false;
		
		public function onDesignLoadComplete(event:LoaderEvent):void {
			
			var tEvt:TrackEvent = new TrackEvent('subLoadComplete','designModule');
			Tracking.trackMetrics(tEvt);
			
			designIsLoaded = true;
			//        designSWFLoader.removeEventListener(LoaderEvent.COMPLETE, onDesignLoadComplete);
			//        designSWFLoader.removeEventListener(LoaderEvent.PROGRESS, _loaderProgress.progress);
			//design
			_loaderProgress.animateOff();
			
			//MonsterDebugger.trace(this, "second load completed");
			mcDesign = designSWFLoader.rawContent;
			//        mcDesign = designLM.getContent("dswf") as MovieClip;
			navSystem.addToObserver(mcDesign, designContainer, vars.design.name);
			
			if (navSystem.subject.getState() == "design") {
				TweenMax.killTweensOf(designContainer, {alpha:true, visible:true});
				TweenMax.to(designContainer, GlobalAnim.TRANSISITION, {delay:GlobalAnim.TRANSISITION, autoAlpha:1});
			}
		}
		
		public function onAFXLoadComplete(event:LoaderEvent):void {
			var tEvt:TrackEvent = new TrackEvent('subLoadComplete','AlienFxModule');
			Tracking.trackMetrics(tEvt);
			//MonsterDebugger.trace(this, "AlienFxModule loaded");
			afxIsLoaded = true;
			_loaderProgress.animateOff();
			mcAlienFx = afxSWFLoader.rawContent;
			navSystem.addToObserver(mcAlienFx, alienFxContainer, vars.exploreAlienFx.name);
			mcAlienFx.callChildFromParent({transitionOn:true});
			
			if (navSystem.subject.getState() == "exploreAlienFx") {
				TweenMax.killTweensOf(alienFxContainer, {alpha:true, visible:true});
				TweenMax.to(alienFxContainer, GlobalAnim.TRANSISITION, {delay:GlobalAnim.TRANSISITION, autoAlpha:1});
			}
		}
		
		
		public function onCommandCenterComplete(event:LoaderEvent):void {
			var tEvt:TrackEvent = new TrackEvent('subLoadComplete','CommandCenterModule');
			Tracking.trackMetrics(tEvt);
			//MonsterDebugger.trace(this, "CommandCenterModule loaded");
			ccIsLoaded = true;
			_loaderProgress.animateOff();
			mcCommandCenter = ccSWFLoader.rawContent;
			navSystem.addToObserver( mcCommandCenter, commandCenterContainer, vars.commandCenter.name );
			mcCommandCenter.callChildFromParent({transitionOn:true});
			
			if (navSystem.subject.getState() == "commandCenter") {
				TweenMax.killTweensOf(commandCenterContainer, {alpha:true, visible:true});
				TweenMax.to(commandCenterContainer, GlobalAnim.TRANSISITION, {delay:GlobalAnim.TRANSISITION, autoAlpha:1});
			}
		}
		
		public function onGalleryComplete(event:LoaderEvent):void {
			var tEvt:TrackEvent = new TrackEvent('subLoadComplete','GalleryModule');
			Tracking.trackMetrics(tEvt);
			//MonsterDebugger.trace(this, "CommandCenterModule GalleryModule");
			galleryIsLoaded = true;
			_loaderProgress.animateOff();
			mcGallery = gallerySWFLoader.rawContent;
			navSystem.addToObserver(mcGallery, galleryContainer, vars.gallery.name);
			mcGallery.callChildFromParent({transitionOn:true});
			
			if (navSystem.subject.getState() == "gallery") {
				TweenMax.killTweensOf(galleryContainer, {alpha:true, visible:true});
				TweenMax.to(galleryContainer, GlobalAnim.TRANSISITION, {delay:GlobalAnim.TRANSISITION, autoAlpha:1});
			}
		}
		
		public function onVideoComplete(event:LoaderEvent):void {
			var tEvt:TrackEvent = new TrackEvent('subLoadComplete','VideoModule');
			Tracking.trackMetrics(tEvt);
			
			videoIsLoaded = true;
			_loaderProgress.animateOff();
			mcVideo = videoSWFLoader.rawContent;
			navSystem.addToObserver(mcVideo, videoContainer, vars.video.name);
			mcVideo.callChildFromParent({transitionOn:true});
			
			if (navSystem.subject.getState() == "video") {
				TweenMax.killTweensOf(videoContainer, {alpha:true, visible:true});
				TweenMax.to(videoContainer, GlobalAnim.TRANSISITION, {delay:GlobalAnim.TRANSISITION, autoAlpha:1});
			}
		}
		
		
		public function callFromChildSwf():void {
			trace("Parent called")
			//        mcDesign.startBuild();
			
			
		}
		
		
		public function designTertiaryLoading(value:Number):void {
			trace("tertiary Loading");
			var currentProgress:Number = ((value *.5) +.5);
			
			if (designLoadCache < currentProgress) {
				designLoadCache = currentProgress;
				_loaderProgress.progress(currentProgress);
			}
			
		}
		
		private function showMouse(event:MouseEvent):void {
			Mouse.show();
		}
		
		private function handleGlobalErrors( evt : UncaughtErrorEvent ):void
		{
			evt.preventDefault();
		}
		
		
	}
}
