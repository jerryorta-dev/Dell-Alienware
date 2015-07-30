/**
 * Created with IntelliJ IDEA.
 * User: Jerry Orta
 * http://www.digitalproductionart.com
 * jerryorta@gmail.com
 *
 * Date: 11/21/12
 * Time: 8:24 AM
 */
package com.dpa.utils.flashvars
{


public function addProperty(flashVars:Object, property:String, _paramsObj:Object = null):Object {


        if (flashVars.hasOwnProperty(property) && flashVars[property] != "") {
            _paramsObj[property] = flashVars[property];
        }

        return _paramsObj;
    }
}
