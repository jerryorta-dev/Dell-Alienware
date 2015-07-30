/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/31/13
 * Time: 2:53 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.displayObject {
import flash.display.DisplayObject;

public function getRootDisplayObject(dispObj:DisplayObject):DisplayObject {
    if (dispObj.parent != null) {
        return getRootDisplayObject(dispObj.parent);
    } else {
        return dispObj;
    }
}
}

