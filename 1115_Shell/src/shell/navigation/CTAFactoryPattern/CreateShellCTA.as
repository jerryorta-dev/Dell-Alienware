/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 10:41 AM
 * To change this template use File | Settings | File Templates.
 */
package shell.navigation.CTAFactoryPattern {
import com.dell.alienFx.ConfigGlobal;
import com.dpa.text.params.TextField_TextFormat_Vars;

import com.dpa.utils.object.addHandCurserNoChildren;

import flash.display.DisplayObject;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.net.navigateToURL;
import flash.text.TextField;

import shell.navigation.CTAFactoryPattern.abstractCreators.AbstractShapeCreator;
import shell.navigation.CTAFactoryPattern.abstractCreators.AbstractTextFieldCreator;
import shell.navigation.CTAFactoryPattern.concrete.ConcreteCTABackgroundWidget;
import shell.navigation.CTAFactoryPattern.creators.CreateCTAShapeItem;
import shell.navigation.CTAFactoryPattern.creators.CreateCTATextFieldItem;


public class CreateShellCTA extends Sprite {

    private var vars:Object;
    private var _hitBox:Sprite;

    public function CreateShellCTA(data:Object) {
        super();
        this.vars = (data != null) ? data : {};

        var background:AbstractShapeCreator = new CreateCTAShapeItem();
        data.bgName = "ctaBg";
        background.draw(CreateCTAShapeItem.BACKGROUND, this, 0, 0, data);


        var tf:AbstractTextFieldCreator = new CreateCTATextFieldItem();
        data.name =  "ctaText";

        tf.draw(CreateCTATextFieldItem.TITLE, this, 16, 0, data);




        this.addEventListener(Event.ADDED_TO_STAGE, addIcon, false, 0, true);


    }

    private function addIcon(e:Event):void {
        this.removeEventListener(Event.ADDED_TO_STAGE, addIcon);

        var tfRef:TextField = this.getChildByName( "ctaText") as TextField;
        var xPos:Number  = 16 + tfRef.getLineMetrics(0).width + 12;

        var icon:AbstractShapeCreator = new CreateCTAShapeItem();
        icon.draw(CreateCTAShapeItem.ICON, this, xPos, 3, this.vars);
        var _bgRef:ConcreteCTABackgroundWidget = this.getChildByName("ctaBg") as ConcreteCTABackgroundWidget;
        _bgRef.rectWidth = xPos + 28;

        _hitBox = new Sprite();
        _hitBox.graphics.beginFill(0xffffff, 0);
        _hitBox.graphics.drawRoundRect(0, 0, _bgRef.rectWidth, _bgRef.rectHeight, 18);
        addChild(_hitBox);

        addHandCurserNoChildren(_hitBox);

        _hitBox.addEventListener(MouseEvent.CLICK, navigate, false, 0, true );

    }

    private function navigate(event:MouseEvent):void {
        var request:URLRequest = new URLRequest(this.vars.url);
         navigateToURL(request, "_blank");
    }


}
}
