/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 6/3/13
 * Time: 2:51 PM
 * To change this template use File | Settings | File Templates.
 */
package gallery.heroImages {
import com.demonsters.debugger.MonsterDebugger;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.ImageLoader;
import com.greensock.loading.LoaderMax;

import flash.display.DisplayObject;

import flash.display.Sprite;

import gallery.uiFactoryPattern.abstractCreators.AbstractTextFieldCreator;
import gallery.uiFactoryPattern.creators.CreateDescriptionTextField;

import gallery.uiFactoryPattern.abstractCreators.AbstractTextFieldCreator;

import gallery.uiFactoryPattern.creators.CreateDescriptionTextField;

import utils.display.addChild;

public class HeroImage extends Sprite {
    private var vars:Object;
    public var imageLoader:ImageLoader;

    private var imgContainer:Sprite;


    public function HeroImage(vars:Object) {
        this.vars = (vars != null) ? vars : {};
        this.name = vars.name;
        this.alpha = 0;

//        this.imageLoader = LoaderMax.getLoader(this.vars.name) as ImageLoader;
        this.imageLoader = new ImageLoader(this.vars.url, {onComplete:onComplete});
        MonsterDebugger.trace(this.imageLoader, this.imageLoader, "Gallery", "hero url", 0x24fd00);
        this.imageLoader.addEventListener(LoaderEvent.COMPLETE, onComplete, false, 0, true);
        this.imageLoader.load();

        imgContainer = new Sprite();
        imgContainer.x = imgContainer.y = 0;
        this.addChild(imgContainer);

        var tf:AbstractTextFieldCreator = new CreateDescriptionTextField();
        var titleParams:Object = {};
        titleParams.name = "title";
        titleParams.xmlNode = vars.xmlNode;
        tf.draw(CreateDescriptionTextField.TITLE, this, 0, 340, titleParams);

        var df:AbstractTextFieldCreator = new CreateDescriptionTextField();
        var descParams:Object = {};
        descParams.name = "description";
        descParams.xmlNode = vars.xmlNode;
        df.draw(CreateDescriptionTextField.DESCRIPTION, this, 0, 360, descParams);
    }

    private function onComplete(event:LoaderEvent):void {
        this.imageLoader.removeEventListener(LoaderEvent.COMPLETE, onComplete);

        var img:DisplayObject = this.imageLoader.content;
        img.x = img.y = 0;

        imgContainer.addChild(img);
    }
}
}
