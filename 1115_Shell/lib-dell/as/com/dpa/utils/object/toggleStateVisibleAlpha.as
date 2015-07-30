/**
 * Created with IntelliJ IDEA.
 * User: jerry.orta
 * Date: 2/27/13
 * Time: 8:19 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.object {


import flash.utils.Dictionary;

    public function toggleStateVisibleAlpha(uiDictionary:Dictionary, _state:String,  _visible:Boolean, _alpha:Number):void {
        setAllVisibleAlpha(uiDictionary, false, 0);
        setVisibleAlpha(uiDictionary, _state, _visible, _alpha);
    }
}
