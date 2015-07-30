/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/31/13
 * Time: 2:52 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.displayObject {
import flash.display.DisplayObject;
import flash.display.LoaderInfo;

public function getLoaderInfo(dispObj:DisplayObject):LoaderInfo {
    var root:DisplayObject = getRootDisplayObject(dispObj);
    if (root!=null) {
        return root.loaderInfo;
    }
    return null;
    }

}
