/**
 * Created with IntelliJ IDEA.
 * User: Jerry Orta
 * http://www.digitalproductionart.com
 * jerryorta@gmail.com
 *
 * Date: 11/21/12
 * Time: 8:24 AM
 */
package com.dpa.utils.objects
{
    public function addProperty(vars:Object, property:String, value:*, relative:Boolean = false):Object {

        if (value == null) {
            delete vars[property]; //in case it was previously set
        } else {
            vars[property] = (relative) ? String(value) : value;
        }

        return vars;
    }
}
