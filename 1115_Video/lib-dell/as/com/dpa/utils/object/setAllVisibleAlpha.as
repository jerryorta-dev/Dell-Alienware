/**
 * Created with IntelliJ IDEA.
 * User: jerry.orta
 * Date: 2/27/13
 * Time: 6:25 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.object {
import flash.utils.Dictionary;

    public function setAllVisibleAlpha(uiDictionary:Dictionary, _visible:Boolean, _alpha:Number):void {
        for each (var object : Object in uiDictionary)
        {
            object.visible = _visible;
            object.alpha = _alpha;
        }
    }
}

