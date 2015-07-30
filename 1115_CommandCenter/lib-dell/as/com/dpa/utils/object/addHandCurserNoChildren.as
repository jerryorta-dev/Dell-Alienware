/**
 * Created with IntelliJ IDEA.
 * User: jerry.orta
 * Date: 2/25/13
 * Time: 9:07 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.object {
import flash.display.MovieClip;

public function addHandCurserNoChildren(target:*):void {
        target.buttonMode = true;
        target.mouseChildren = false;
        target.useHandCursor = true;
    }
}

