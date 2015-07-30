/**
 * Created with IntelliJ IDEA.
 * User: jerry.orta
 * Date: 2/27/13
 * Time: 8:19 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.object {
import com.dpa.ui.object.utils.setAllVisibleAlpha;
import com.dpa.ui.object.utils.setVisibleAlpha;

import flash.utils.Dictionary;

/**
 * Toggle old state to visibility = false, alpha = 0
 * Toggle new state to visibility = true, alpha = 0;
 * @param uiDictionary
 * @param _oldState
 * @param _newState
 */
    public function toggleStateVisibleAlphaOfSingleSet(uiDictionary:Dictionary, _oldState:String ,_newState:String) {
        setVisibleAlpha(uiDictionary, _oldState, false, 0);
        setVisibleAlpha(uiDictionary, _newState, true, 0);
    }
}
