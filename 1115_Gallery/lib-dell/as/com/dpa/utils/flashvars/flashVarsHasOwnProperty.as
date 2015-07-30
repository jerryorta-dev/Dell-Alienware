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
    public function flashVarsHasOwnProperty(flashVars:Object, property:String):Boolean {

        if (flashVars != null && flashVars.hasOwnProperty(property) && flashVars[property] != "") {
            return true;
        }

        return false;

    }
}
