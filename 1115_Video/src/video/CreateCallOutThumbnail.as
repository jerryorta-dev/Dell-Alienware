/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 6/2/13
 * Time: 5:33 PM
 * To change this template use File | Settings | File Templates.
 */
package video {
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.text.TextField;

import video.uiFactoryPattern.abstractCreators.AbstractShapeCreator;
import video.uiFactoryPattern.abstractCreators.AbstractTextFieldCreator;
import video.uiFactoryPattern.concrete.ConcreteCallOutBackgroundWidget;
import video.uiFactoryPattern.creators.CreateShape;
import video.uiFactoryPattern.creators.CreateVideoTextField;

public class CreateCallOutThumbnail extends Sprite {
    private var vars:Object;
    private var _referenceMovieClip:tn;

    public function CreateCallOutThumbnail(vars:Object = null) {
        this.vars = (vars != null) ? vars : {};
        this.name = this.vars.name;

        var bg:AbstractShapeCreator = new CreateShape();
        var bgParams:Object = {};
        bgParams.name = "bg";
        bgParams.pointX = 18;
        bg.draw(CreateShape.TITLE_BACKGROUND, this, 0, 0, bgParams);

        var tf:AbstractTextFieldCreator = new CreateVideoTextField();
        var tfParams:Object = {};
        tfParams.name = "title";
        tfParams.htmlText = this.vars.htmlText;
        tf.draw(CreateVideoTextField.TITLE, this, 10, 10, tfParams);

        this.background.rectHeight = this.title.height + this.title.y + 10;
    }

    private function onEnterFrame(event:Event):void {
        if (_referenceMovieClip != null) {
            this.x = _referenceMovieClip.localToGlobal(new Point(0, 0)).x;
        }
    }


    //GETTERS AND SETTERS

    public function set setEnterFrame(value:Boolean):void {
        if (value) {
            this.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
        } else {
            this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
        }
    }

    public function set refMC(_mc:tn):void {
        _referenceMovieClip = _mc;
    }


    public function get title():TextField {
        return this.getChildByName("title") as TextField;
    }

    public function get background():ConcreteCallOutBackgroundWidget {
        return this.getChildByName("bg") as ConcreteCallOutBackgroundWidget;
    }

    public function get rectHeight():Number {
        return this.background.rectHeight;
    }

    public function set rectHeight(value:Number):void {
        this.background.rectHeight = value;
    }

    public function get pointX():Number {
        return this.background.pointX;
    }

    public function set pointX(value:Number):void {
        this.background.pointX = value;
    }
}
}
