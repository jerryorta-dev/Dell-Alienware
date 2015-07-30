/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 6/6/13
 * Time: 9:55 AM
 * To change this template use File | Settings | File Templates.
 */
package shell.progressBar {
import com.dell.services.PathManager;
import com.greensock.TweenMax;
import com.greensock.events.LoaderEvent;

import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;

import shell.uiFactoryPattern.abstractCreators.AbstractTextFieldCreator;
import shell.uiFactoryPattern.creators.CreateTextField;



public class LoaderProgress extends Sprite {

    private var awBackground:AWBackground;

    private var designed:AbstractTextFieldCreator;
    private var _d:TextField;

    private var victory:AbstractTextFieldCreator;
    private var _v:TextField;

    private var title:AbstractTextFieldCreator;
    private var _t:TextField;
    private var desc:AbstractTextFieldCreator;
    private var _desc:TextField;


    private var  _loaderBar:ProgressBar;

    private var vars:Object;

    public function LoaderProgress(vars:Object = null) {
        this.vars = (vars != null) ? vars : {};

        if (this.stage){
            init();
        }else{
            addEventListener(Event.ADDED_TO_STAGE, init);
        }

    }

    private function init(event:Event = null):void {
        if (event){
            removeEventListener(Event.ADDED_TO_STAGE, init);
        }


        awBackground = new AWBackground();
        awBackground.x = awBackground.y = 0;
        addChild(awBackground);
    }



    public function addText(vars:Object):void {
//        trace(PathManager.language);


        if (PathManager.language == "en") {
            designed = new CreateTextField();
            vars.name = "designed";
            designed.draw(CreateTextField.DESIGNED_FOR, this, 0, 30, vars);
            _d = this.getChildByName("designed") as TextField;
            _d.x = this.width / 2 - (_d.width / 2);
            _d.visible = false;

            victory = new CreateTextField();
            vars.name = "victory";
            victory.draw(CreateTextField.VICTORY, this,0, 63, vars);
            _v = this.getChildByName("victory") as TextField;
            _v.x = this.width / 2 - (_v.width / 2);
            _v.visible = false;

        } else {
            title = new CreateTextField();
            vars.name = "title";
            title.draw(CreateTextField.INTRO_TITLE, this, 0, 50, vars);
            _t = this.getChildByName("title") as TextField;
            _t.x = this.width / 2 - (_t.width / 2);
            _t.visible = false;
        }

//        trace(vars);

        desc = new CreateTextField();
        vars.name = "desc";
        desc.draw(CreateTextField.DESCRIPTION, this, 0, 161, vars);
        _desc = this.getChildByName("desc") as TextField;
        _desc.x = this.width / 2 - (_desc.width / 2);

        //Adjust

        if (PathManager.language != "en") {
            _desc.y = _t.y + _t.height + 30;
        }



        _desc.visible = false;

        _loaderBar = new ProgressBar();
        _loaderBar.visible = false;
        _loaderBar.x = 332;
        _loaderBar.y = 252;
        addChild(_loaderBar);

    }



    public function animateOn(_junk:Boolean = true):void {
        if (!this.visible) {
            this.visible = true;
        }


        if (PathManager.language == "en") {
            TweenMax.to(_d,.01, {visible:true});
            TweenMax.to(_d,.01, {delay:.05, visible:false});
            TweenMax.to(_d,.01, {delay:.1, visible:true});
            TweenMax.to(_d,.01, {delay:.15, visible:false});
            TweenMax.to(_d,.01, {delay:.2, visible:true});

            var adjust:Number = .3;
            TweenMax.to(_v,.01, {delay:adjust, visible:true});
            TweenMax.to(_v,.01, {delay:.05 + adjust, visible:false});
            TweenMax.to(_v,.01, {delay:.1 + adjust, visible:true});
            TweenMax.to(_v,.01, {delay:.15 + adjust, visible:false});
            TweenMax.to(_v,.01, {delay:.2 + adjust, visible:true});
        } else {
            TweenMax.to(_t,.01, {visible:true});
            TweenMax.to(_t,.01, {delay:.05, visible:false});
            TweenMax.to(_t,.01, {delay:.1, visible:true});
            TweenMax.to(_t,.01, {delay:.15, visible:false});
            TweenMax.to(_t,.01, {delay:.2, visible:true});
        }


        var descAdj:Number = .5;
        TweenMax.to(_desc,.01, {delay:descAdj, visible:true});
        TweenMax.to(_desc,.01, {delay:.2 + descAdj, visible:false});
        TweenMax.to(_desc,.01, {delay:.24 + descAdj, visible:true});



    }

    public function animateOff(_junk:Boolean = true):void {
        if (PathManager.language == "en") {

            TweenMax.to(_d,.01, {visible:false});
            TweenMax.to(_d,.01, {delay:.05, visible:true});
            TweenMax.to(_d,.01, {delay:.1, visible:false});
            TweenMax.to(_d,.01, {delay:.15, visible:true});
            TweenMax.to(_d,.01, {delay:.2, visible:false});

            var adjust:Number = .3;
            TweenMax.to(_v,.01, {delay:adjust, visible:false});
            TweenMax.to(_v,.01, {delay:.05 + adjust, visible:true});
            TweenMax.to(_v,.01, {delay:.1 + adjust, visible:false});
            TweenMax.to(_v,.01, {delay:.15 + adjust, visible:true});
            TweenMax.to(_v,.01, {delay:.2 + adjust, visible:false});

        } else {
            TweenMax.to(_t,.4, {delay:.5, autoAlpha:0});
        }

        var descAdj:Number = .5;
        TweenMax.to(_desc,.01, {delay:descAdj, visible:false});
        TweenMax.to(_desc,.01, {delay:.2 + descAdj, visible:true});
        TweenMax.to(_desc,.01, {delay:.24 + descAdj, visible:false});

        TweenMax.to(this,.01, {delay:.3 + descAdj, visible:false});

    }

    public function show():void {
        TweenMax.to(_loaderBar,.01, {visible:true});
        TweenMax.to(_loaderBar,.01, {delay:.05, visible:false});
        TweenMax.to(_loaderBar,.01, {delay:.1, visible:true});
        TweenMax.to(_loaderBar,.01, {delay:.15, visible:false});
        TweenMax.to(_loaderBar,.01, {delay:.2, visible:true});
    }

    public function hide():void {
        TweenMax.to(_loaderBar,.01, {visible:false});
        TweenMax.to(_loaderBar,.01, {delay:.05, visible:true});
        TweenMax.to(_loaderBar,.01, {delay:.1, visible:false});
        TweenMax.to(_loaderBar,.01, {delay:.15, visible:true});
        TweenMax.to(_loaderBar,.01, {delay:.2, visible:false});
    }

    public function progress(value:Number):void {
        _loaderBar.progress(value)

    }



}
}
