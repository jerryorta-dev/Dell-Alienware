/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/24/13
 * Time: 4:03 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.video.playerFactoryPattern.playerFactory.abstractCreators {
import com.dell.video.playerFactoryPattern.playerFactory.abstractWidgets.AbstractPlayerWidget;
import com.dell.video.playerFactoryPattern.playerFactory.creators.CreatePlayer;
import com.ooyala.api.FlashPlayer;

import flash.display.DisplayObjectContainer;

import flash.display.Sprite;
import flash.errors.IllegalOperationError;

public class AbstractPlayerCreator {

    public function draw(_type:uint, target:Sprite, xLoc:Number, yLoc:Number, vars:Object = null):void {
        var  element:* = this.createElement(_type, vars);
        element.drawWidget(vars);
        element.setLoc(xLoc, yLoc); // set the x and y location
        target.addChild(element); // add the sprite to the display list
    }

    public function createElement(_type:uint, vars:Object = null):AbstractPlayerWidget {
        throw new IllegalOperationError("Abstract method: must be overridden in a subclass");
        return null;
    }

    /**
     *
     * @param parent = container object of Flash Player (usually "this")
     * @param playerName = name instantiate with player
     * @return
     */
    public function getPlayer(parent:DisplayObjectContainer, playerName:String):FlashPlayer {
        return parent.getChildByName(playerName)["player"];
    }

}
}