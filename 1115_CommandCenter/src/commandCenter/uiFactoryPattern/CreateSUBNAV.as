/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 6/4/13
 * Time: 4:55 AM
 * To change this template use File | Settings | File Templates.
 */
package commandCenter.uiFactoryPattern {
import commandCenter.uiFactoryPattern.abstractCreators.AbstractShapeCreator;
import commandCenter.uiFactoryPattern.concrete.ConcreteSubNavWidget;
import commandCenter.uiFactoryPattern.creators.CreateShapes;

import flash.display.Sprite;
import flash.events.Event;

import utils.object.numProperties;

public class CreateSUBNAV extends Sprite {
    private var vars:Object;
    private var gap:Number = 20;
    private var _subNavArray:Array = new Array();

    public function CreateSUBNAV(vars:Object, snArray:Array) {
        this.vars = (vars != null) ? vars : {};
        this.name = vars.subNavName;
        this._subNavArray = snArray
//        trace(this.name);

        if (this.stage){
            init();
        }else{
            addEventListener(Event.ADDED_TO_STAGE, init);
        }
    }

    private function init(event:Event = null):void {

//        traceProps(this.vars.subNav);
        var nLen:int = numProperties(this.vars.subNav);

        var sp:Sprite = new Sprite();
        sp.x = 0;
        sp.y = 0;
        addChild(sp);

        //16 is width, 8 is half of width
        var xPos:Number  = 8;
        var yPos:Number = 0;
        var stagger:Number = gap + 8;

        for (var i:int = 1; i < nLen + 1; i++) {
            var navItem:AbstractShapeCreator  = new CreateShapes();

            var varsObj:Object = {};
            varsObj.target =  vars.subNav["target" + i];
            varsObj.refNum = i;
            varsObj.name = "target" + i;
            varsObj.callBack = this.vars.callBack;

            if (i == 1) {
                varsObj.isActive = true;
            }

            navItem.draw(CreateShapes.SUB_NAV, sp, xPos, yPos, varsObj)
            xPos += stagger;
            _subNavArray.push((sp.getChildByName("target" + i) as ConcreteSubNavWidget));
        }

        sp.x = -(sp.width / 2);

        if (_subNavArray.length == 1) {
            _subNavArray[0].visible = false;
        }


    }
}
}
