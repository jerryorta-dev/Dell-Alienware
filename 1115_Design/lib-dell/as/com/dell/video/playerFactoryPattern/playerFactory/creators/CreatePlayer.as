/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 9:21 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.video.playerFactoryPattern.playerFactory.creators {
import com.dell.video.playerFactoryPattern.playerFactory.abstractCreators.AbstractPlayerCreator;
import com.dell.video.playerFactoryPattern.playerFactory.abstractWidgets.AbstractPlayerWidget;
import com.dell.video.playerFactoryPattern.playerFactory.concrete.ConcretePlayerWidget;

public class CreatePlayer extends AbstractPlayerCreator{

    public static const PLAYER_INSTANCE             :uint = 0;

    override public function createElement(_type:uint, vars:Object = null):AbstractPlayerWidget {
        if (_type === PLAYER_INSTANCE) {
            return new ConcretePlayerWidget();
        } else {
            return null;
        }
        return null;
    }


}
}
