/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 10:41 AM
 * To change this template use File | Settings | File Templates.
 */
package shell.navigation.navTabItemFactoryPattern {
import com.dell.services.TrackEvent;
import com.dpa.utils.object.addHandCurserNoChildren;
import com.dpa.utils.objects.union;
import com.dpa.utils.tracers.traceProps;
import com.greensock.TweenLite;
import com.greensock.plugins.TintPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.display.MovieClip;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import shell.Omniture.Tracking;

import shell.navigation.navItemStates.abstract.Context_NavItem_States;
import shell.navigation.navItemStates.abstract.IState_ButtonONOFF;

import shell.navigation.navTabItemFactoryPattern.abstractCreators.AbstractShapeCreator;
import shell.navigation.navTabItemFactoryPattern.abstractCreators.AbstractTextFieldCreator;
import shell.navigation.navTabItemFactoryPattern.concrete.ConcreteNavItemBackgroundWidget;
import shell.navigation.navTabItemFactoryPattern.creators.*;

public class CreateNavItem extends Sprite {

    private var _background:ConcreteNavItemBackgroundWidget;
    private var _hoverGraphic:Sprite;
    private var _iconGraphic:Sprite;
    private var _label:TextField;
    private var _hitBox:Sprite;

    private var _state:Context_NavItem_States;
    private var _stateIsOn:Boolean;

    private var _loadSwf:Function;


    public function CreateNavItem(data:Object, name:String, load:Function) {
        super();
        this.name = name;
        _loadSwf = load;

        TweenPlugin.activate([TintPlugin]);

        var background:AbstractShapeCreator = new CreateNavShapeItem();

        var bgParams:Object = {};
        bgParams = union(bgParams, data);
        bgParams.name = "navItemBg";

        background.draw(CreateNavShapeItem.BACKGROUND, this, 0, 0, bgParams);
        _background = this.getChildByName("navItemBg") as ConcreteNavItemBackgroundWidget;

        var hover:AbstractShapeCreator = new CreateNavShapeItem();

        var hoverParams:Object = {};
        hoverParams = union(hoverParams, data);
        hoverParams.name = "navItemHover";
        hover.draw(CreateNavShapeItem.HOVER, this, 101, 0, hoverParams);

        _hoverGraphic = this.getChildByName("navItemHover") as Sprite;

        var icon:AbstractShapeCreator = new CreateNavShapeItem();
        icon.draw(CreateNavShapeItem.ICON, this, 5, 35, data);
        _iconGraphic = this.getChildByName(data.icon) as Sprite;
        TweenLite.to(_iconGraphic, 0, {tint: 0xffffff, alpha: .5});

        var tf:AbstractTextFieldCreator = new CreateNavTextFieldItem();

        var tfParams:Object = {};
        tfParams = union(tfParams, data);
        tfParams.name = "navItemTf";

        tf.draw(CreateNavTextFieldItem.TITLE, this, 10, 7, tfParams);

        _hitBox = new Sprite;
        _hitBox.graphics.clear();
        _hitBox.graphics.beginFill(0xFFFFFF, 0);
        _hitBox.graphics.drawRoundRect(0, 0, 107, 67, 5);
        _hitBox.graphics.endFill();
        _hitBox.x = _hitBox.y = 0;
        addChild(_hitBox);

        _state = new Context_NavItem_States(this);

        addHandCurserNoChildren(_hitBox);

        _hitBox.addEventListener(MouseEvent.ROLL_OVER, onRollOver, false, 0, true);
        _hitBox.addEventListener(MouseEvent.ROLL_OUT, onRollOut, false, 0, true);
        _hitBox.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);

    }

    private function onRollOut(event:MouseEvent):void {
        if (!_stateIsOn) {
            _state.OFF();
        }
    }

    private function onRollOver(event:MouseEvent):void {
        _state.OVER();
    }

    private function onMouseDown(event:MouseEvent = null):void {
        var tEvt:TrackEvent = new TrackEvent('button', "MainMenu" + this.name);
        shell.Omniture.Tracking.trackMetrics(tEvt);

        if (_loadSwf != null) {
            _loadSwf.apply(null, [this.name]);
        }
        _stateIsOn = true;
        _state.ON();
    }

    //Set this state
    public function ON():void {
        _stateIsOn = true;
        _state.ON();
    }

    public function OFF():void {
        _stateIsOn = false;
        _state.OFF();
    }

    public function OVER():void {
        _stateIsOn = false;
        _state.OVER();
    }

    public function setState(_newState:IState_ButtonONOFF):void {
        if (_newState == _state.getOffButtonState()) {
            _stateIsOn = false;
            _state.OFF();
        }

        if (_newState == _state.getOnButtonState()) {
            _stateIsOn = true;
            _state.ON();
        }

    }


    //TRANSFORMATION PROPERTIES
    public function get matrixTx():Number {
        return _background.matrixTx;
    }

    public function set matrixTx(value:Number):void {
        _background.matrixTx = value;
    }

    public function get pointX():Number {
        return _background.pointX;
    }

    public function set pointX(value:Number):void {
        _background.pointX = value;
    }

    public function get hoverAlpha():Number {
        return _hoverGraphic.alpha;
    }

    public function set hoverAlpha(value:Number):void {
        _hoverGraphic.alpha = value;
    }


    //ELEMENTS


    public function get iconGraphic():Sprite {
        return _iconGraphic;
    }

    public function set hoverGraphic(value:Sprite):void {
        _hoverGraphic = value;
    }


    public function get label():TextField {
        return _label;
    }

    public function set label(value:TextField):void {
        _label = value;
    }

    public function get hitBox():Sprite {
        return _hitBox;
    }

    public function get state():Context_NavItem_States {
        return _state;
    }

    public function get stateIsOn():Boolean {
        return _stateIsOn;
    }

    public function set stateIsOn(value:Boolean):void {
        _stateIsOn = value;
    }
}
}
