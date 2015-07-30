/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 10:41 AM
 * To change this template use File | Settings | File Templates.
 */
package alienFxModule.uiGraphics {
import alienFxModule.Omniture.Tracking;

import com.dell.services.PathManager;
import com.dell.services.TrackEvent;
import com.dpa.utils.object.addHandCurserNoChildren;
import com.dpa.utils.objects.union;
import com.greensock.plugins.TintPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.display.MovieClip;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;

import alienFxModule.uiGraphics.navItemStates.abstract.Context_HideControl_States;
import alienFxModule.uiGraphics.navItemStates.abstract.IState_ButtonONOFF;
import alienFxModule.uiGraphics.uiFactoryPattern.abstractCreators.AbstractShapeCreator;
import alienFxModule.uiGraphics.uiFactoryPattern.abstractCreators.AbstractTextFieldCreator;
import alienFxModule.uiGraphics.uiFactoryPattern.concrete.ConcreteHideControlsTextFieldWidget;
import alienFxModule.uiGraphics.uiFactoryPattern.creators.CreateShape;
import alienFxModule.uiGraphics.uiFactoryPattern.creators.CreateUITextField;

public class CreateHideControlButton extends Sprite {

    private var _hoverGraphic:Sprite;
    private var _iconGraphic:Sprite;
    private var _hitBox:Sprite;

    private var _state:Context_HideControl_States;
    private var _stateIsOn:Boolean;

    private var _load:Function;

    private var _hideLabel:TextField;
    private var _showLabel:TextField;

    private var _target:MovieClip;




    public function CreateHideControlButton( target:MovieClip, _data:Object ) {
        super();
        this.name = name;
        this._target = target;
//        _load = load;

        TweenPlugin.activate([TintPlugin]);
//
//        var :AbstractShapeCreator = new CreateNavShapeItem();
//
//        var bgParams:Object = {};
//        bgParams = union(bgParams, data);
//        bgParams.name = "navItemBg";
//
//        background.draw(CreateNavShapeItem.BACKGROUND, this, 0, 0, bgParams);
//        _background = this.getChildByName("navItemBg") as ConcreteNavItemBackgroundWidget;


        var tfHide:AbstractTextFieldCreator = new CreateUITextField();

        var tfHideParams:Object = {};
//        tfHideParams = union(tfHideParams, data);
        tfHideParams.name = "hide";

        if (PathManager.language != "en") {
            tfHideParams.htmlText = _data.button;
        } else {
            tfHideParams.htmlText = "Hide<br>Controls";
        }

        tfHide.draw(CreateUITextField.HIDE_CONTROLS, this, 0, 0, tfHideParams);
        _hideLabel = this.getChildByName("hide") as ConcreteHideControlsTextFieldWidget;

        var tfShow:AbstractTextFieldCreator = new CreateUITextField();

        var tfShowParams:Object = {};
//        tfShowParams = union(tfShowParams, data);
        tfShowParams.name = "show";
//        tfParams.htmlText = data.button;
        tfShowParams.htmlText = "Show<br>Controls";

        if (PathManager.language != "en") {
            tfShowParams.htmlText = _data.button;
        } else {
            tfShowParams.htmlText = "Show<br>Controls";
        }

        tfShow.draw(CreateUITextField.HIDE_CONTROLS, this, 0, 0, tfShowParams);
        _showLabel = this.getChildByName("show") as ConcreteHideControlsTextFieldWidget;
        _showLabel.alpha = 0;

        var hitBox :AbstractShapeCreator = new CreateShape();
        var hitBoxParams:Object = {};
        hitBoxParams.name = "hitBox";
        hitBox.draw(CreateShape.HOTSPOT, this, 0, 0, hitBoxParams);
        _hitBox = this.getChildByName("hitBox") as Sprite;

        //Vertical Align
        _hideLabel.y = ((_hitBox.height - _hideLabel.height) / 2) + 6;
        _showLabel.y = ((_hitBox.height - _showLabel.height) / 2) + 6;

        addHandCurserNoChildren(_hitBox);

//        _hitBox.addEventListener(MouseEvent.ROLL_OVER, onRollOver, false, 0, true);
        _hitBox.addEventListener(MouseEvent.ROLL_OUT, onRollOut, false, 0, true);
        _hitBox.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);

        _stateIsOn = true;

        _state = new Context_HideControl_States(this);
        _state.setState( _state.getOnButtonState() );

    }

    public function get target():MovieClip {
        return _target;
    }

    private function onRollOut(event:MouseEvent):void {
//        if (!_stateIsOn) {
//            _state.OFF();
//        }
    }

    private function onRollOver(event:MouseEvent):void {
        _state.OVER();
    }

    private function onMouseDown(event:MouseEvent = null):void {
       if (_stateIsOn) {
           var tEvt1:TrackEvent = new TrackEvent("AlienFx","HideShowButton-" + "OFF" );
           alienFxModule.Omniture.Tracking.trackMetrics(tEvt1);

           this.OFF();
       } else {
           var tEvt2:TrackEvent = new TrackEvent("AlienFx","HideShowButton-" + "ON" );
           alienFxModule.Omniture.Tracking.trackMetrics(tEvt2);

           this.ON();
       }
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


    public function get hitBox():Sprite {
        return _hitBox;
    }

    public function get state():Context_HideControl_States {
        return _state;
    }

    public function get stateIsOn():Boolean {
        return _stateIsOn;
    }

    public function set stateIsOn(value:Boolean):void {
        _stateIsOn = value;
    }

    public function get showLabel():TextField {
        return _showLabel;
    }

    public function get hideLabel():TextField {
        return _hideLabel;
    }
}
}
