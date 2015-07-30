/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 10:41 AM
 * To change this template use File | Settings | File Templates.
 */
package alienFxModule.uiGraphics {
import com.dell.alienFx.GlobalAnim;
import com.dpa.utils.object.addHandCurserNoChildren;
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.plugins.TintPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;

import alienFxModule.uiGraphics.uiFactoryPattern.abstractCreators.AbstractShapeCreator;
import alienFxModule.uiGraphics.uiFactoryPattern.abstractCreators.AbstractTextFieldCreator;
import alienFxModule.uiGraphics.uiFactoryPattern.concrete.ConcreteResetTextFieldWidget;
import alienFxModule.uiGraphics.uiFactoryPattern.creators.CreateShape;
import alienFxModule.uiGraphics.uiFactoryPattern.creators.CreateUITextField;

public class CreateResetlButton extends Sprite {


    private var _hitBox:Sprite;

    private var _showLabel:TextField;

    private var _target:MovieClip;

    private var _zoneTimeLine:TimelineLite;

    private var initColor:uint;


    public function CreateResetlButton( target:MovieClip, initColor:uint ) {
        super();
        this.name = name;
        this._target = target;
//        _load = load;
        this.initColor = initColor

        TweenPlugin.activate([TintPlugin]);

        var background :AbstractShapeCreator = new CreateShape();
        var bgParams:Object = {};
        bgParams.name = "bg";
        background.draw(CreateShape.RESET_BACKGROUND, this, 0, 0, bgParams);
        _hitBox = this.getChildByName("bg") as Sprite;

        var tfShow:AbstractTextFieldCreator = new CreateUITextField();

        var tfShowParams:Object = {};
        tfShowParams.name = "Reset";
        tfShowParams.htmlText = "Reset";

        tfShow.draw(CreateUITextField.RESET, this, 0, 0, tfShowParams);
        _showLabel = this.getChildByName("Reset") as ConcreteResetTextFieldWidget;

        var hitBox :AbstractShapeCreator = new CreateShape();
        var hitBoxParams:Object = {};
        hitBoxParams.name = "hitBox";
        hitBox.draw(CreateShape.HOTSPOT, this, 0, 0, hitBoxParams);
        _hitBox = this.getChildByName("hitBox") as Sprite;

        //Vertical Align
        _showLabel.y = ((_hitBox.height - _showLabel.height) / 2);

        addHandCurserNoChildren(_hitBox);

        _hitBox.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);

    }

    public function get target():MovieClip {
        return _target;
    }


    private function onMouseDown(event:MouseEvent = null):void {
        trace("reset clicked");
        _zoneTimeLine = new TimelineLite({pause:true});
        for (var i:int = 1; i <= 10; i++) {
            _zoneTimeLine.insert(TweenLite.to(_target["zone" + i], GlobalAnim.TRANSISITION, {tint:initColor}));
        }
        _zoneTimeLine.play();
    }


}
}
