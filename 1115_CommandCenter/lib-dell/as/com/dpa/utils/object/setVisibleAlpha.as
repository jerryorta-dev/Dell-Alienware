/**
 * Created with IntelliJ IDEA.
 * User: jerry.orta
 * Date: 2/27/13
 * Time: 5:34 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.object {
import flash.utils.Dictionary;

    public function setVisibleAlpha(uiDictionary:Dictionary, _state:String, _visible:Boolean, _alpha:Number):void {
        uiDictionary[_state].visible = _visible;
        uiDictionary[_state].alpha = _alpha;
    }
}

