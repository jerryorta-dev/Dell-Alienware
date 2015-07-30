/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/25/13
 * Time: 4:44 PM
 * To change this template use File | Settings | File Templates.
 */
package shell.navigation {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.utils.Dictionary;

import shell.navigation.navItemStates.abstract.Context_NavItem_States;
import shell.navigation.navObserverPattern.concrete.NavItemObserver;
import shell.navigation.navObserverPattern.subjects.NavItemSubject;
import shell.navigation.navTabItemFactoryPattern.CreateNavItem;

public class CreateNavSystem extends Sprite {

    private var _data:Vector.<Object>

    private var _observers:Dictionary;

    private var _subject:NavItemSubject;

    private var _loadSWF:Function;

    public function CreateNavSystem( data:Vector.<Object>, loadSWF:Function ):void {

        _data = data;
        _observers = new Dictionary();
        _loadSWF = loadSWF;

        if (this.stage) {
            createNavItem();
        } else {
            addEventListener(Event.ADDED_TO_STAGE, createNavItem);
        }
    }

    private function createNavItem(event:Event = null):void {

        if (event) {
            removeEventListener(Event.ADDED_TO_STAGE, createNavItem);
        }

        _subject = new NavItemSubject();
        var yPos:Number = 0;
        for (var i:int = 0, len:int = _data.length; i < len; i++) {

            var item:CreateNavItem = new CreateNavItem( _data[i] , _data[i].name, _loadSWF);

            item.x = 0;
            item.y = yPos;
            yPos += 74;
            addChild(item);
            var navItemO:NavItemObserver = new NavItemObserver(item, _data[i]);
            addChild(navItemO);

//            trace(navItemO);
            _observers[item.name] = navItemO;

            subject.addObserver(navItemO);

            if (_data[i].initState == "on") {
                item.ON();
                item.iconGraphic.alpha = 1;
                subject.setState({state:_data[i].stateName, activeState:_data[i].stateName});
            } else {
                item.OFF();
            }

        }

    }

    public function addToObserver(_rootSWFContainer:MovieClip, _container:MovieClip, _name:String):void {
        _observers[_name].addSWF( _rootSWFContainer, _container );
    }


    public function get subject():NavItemSubject {
        return _subject;
    }
}
}
